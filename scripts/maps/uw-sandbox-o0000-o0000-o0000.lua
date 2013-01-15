----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2010 by Invertika Project                                  --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"
require "scripts/libs/scorpionrace"
require "scripts/libs/poker"
require "scripts/libs/postmen"
require "scripts/libs/guard"
---require "scripts/libs/trap"

require "scripts/libs/warp"


local function poker_dealer_talk(npc, ch)
    npc_message(npc, ch, "Hallo.")
    if game == nil then
        game = poker.PokerGame:new(200)
        --game:startGame()
    end

    if game:playerIsInGame(ch) then
        npc_message(npc, ch, "Spieler ist im Spiel")
        if game:isRunning() then
            npc_message(npc, ch, "Spiel läuft.")
            if game:playerIsOnTurn(ch) then
                npc_message(npc, ch, "Poker: Spieler ist an der Reihe.")
                local possibilities =  game:getPossibilities(ch)
                local choices = {}
                for i, possibility in ipairs(possibilities) do
                    if possibility == poker.PokerConstants.POSSIBILITY_FOLD then
                        table.insert(choices, "Karten abgeben - FOLD")
                        print("Spieler kann Fold spielen")
                    elseif possibility == poker.PokerConstants.POSSIBILITY_CALL then
                        table.insert(choices, "Mitgehen - CALL")
                        print("Spieler kann Call spielen")
                    elseif possibility == poker.PokerConstants.POSSIBILITY_RAISE then
                        table.insert(choices, "Erhöhen - RAISE")
                        print("Spieler kann Raise spielen")
                    elseif possibility == poker.PokerConstants.POSSIBILITY_CHANGE_CARD then
                        table.insert(choices, "Karte tauschen.")
                        print("Spieler kann Karte tauschen")
                    end
                end
                while true do
                    local v = npc_choice(npc, ch, choices)
                    if (v >= 1) or (v <= table.getn(choices)) then
                        if possibilities[v] == poker.PokerConstants.POSSIBILITY_FOLD then
                            game:chActionFold(ch)
                            being_say(npc, string.format("%s spielt Fold", being_get_name(ch)))
                        elseif possibilities[v] == poker.PokerConstants.POSSIBILITY_CALL then
                            game:chActionCall(ch)
                            being_say(npc, string.format("%s spielt Call", being_get_name(ch)))
                        elseif possibilities[v] == poker.PokerConstants.POSSIBILITY_RAISE then
                            local min = game:getMoneyPlayerHasToRaise(ch)
                            local max = game:getMaxMoneyPlayerCanRaise(ch)
                            local amount = npc_ask_integer(npc, ch, min, max, min)
                            game:chActionRaise(ch, amount)
                            being_say(npc, string.format("%s spielt Raise um %s", being_get_name(ch), amount))
                        elseif possibilites[v] == poker.PokerConstants.POSSIBILITY_CHANGE_CARD then
                            local player = game:getPlayerFromCh(ch)
                            local cards = player:getSpade():getCards()
                            local text = {}
                            local numbers = {}
                            for i, value in ipairs(cards) do
                                table.insert(text, string.format("%s: %s", i, value:getText()))
                                talbe.insert(numbers, i)
                            end
                            text = table.concat(text, ", ")
                            npc_message(npc, ch, "Wähle eine Karte aus, die du tauschen möchtest.")
                            npc_message(npc, ch, text)
                            while true do
                                local v1 = npc_choice(npc, ch, numbers)
                                if cards[i] ~= nil then
                                    game:chActionSwapCard(player, i)
                                    being_say(npc, string.format("%s tauscht eine Karte", being_get_name(ch)))
                                    -- TODO: Testen ob Karte getauscht werden kann.
                                end
                            end
                        end
                        break
                    end
                end
            else
                npc_message(npc, ch, "Du bist nicht dran.")
            end
        else
            npc_message(npc, ch, "Spiel läuft nicht.")
            print("Poker: Spiel läuft nicht.")
            npc_message(npc, ch, "Spiel starten?")
            while true do
                local v = npc_choice(npc, ch, "Ja.", "Nein.")
                if v == 1 then
                    game:startGame()
                    being_say(npc, "Das Spiel wurde gestartet.")
                    print("Poker: Spiel wurde gestartet.")
                    break
                elseif v == 2 then
                    break
                end
            end
        end
    else
        npc_message(npc, ch, "Du bist nicht im Spiel")
        print("Poker: Spieler bist nicht im Spiel")
        -- Dem Spieler die Möglichkeit geben ins Spiel einzusteigen.
        npc_message(npc, ch, "Möchtest du mitspielen?")
        while true do
            local v = npc_choice(npc, ch, "Ja.", "Nein.")
            if v == 1 then
                game:addPlayer(ch)
                npc_message(npc, ch, "Viel Glück!")
                break
            elseif v == 2 then
                break
            end
        end
    end
end

local function scorpion_talk(npc, ch)
    schedule_in(5, function() being_say(npc, "BUH!") end)
    npc_message(npc, ch, "Ich werde gewinnen!")
end

local function zelan_talk(npc, ch)
    npc_message(npc, ch, "Wo du bist? Im Vacare. Jeder neue kommt hier her bevor es raus geht in die große Welt. Also pass auf dich auf.")
end

local function alaria_talk(npc, ch)
    -- "Example: Let the player sell every item with a 'value' parameter in the server's items.xml file
    local sellcase = npc_trade(npc, ch, true)
    if sellcase == 0 then
      npc_message(npc, ch, "Ok, what do you want to sell:")
    elseif sellcase == 1 then
      npc_message(npc, ch, "I'm not interested by any of your items.")
    else
      npc_message(npc, ch, "Hmm, something went wrong... Ask a scripter to fix this!")
    end
    
end

--- Falle auslösen
local function trap_trigger_skorpions(ch, id)
  trap(ch, 21*TILESIZE, 21*TILESIZE,TILESIZE,TILESIZE,10)--- Bibliotheksfunktion
end

--- Bibliotheksfunktion
local function trap(ch, x, y, width, height, monsterid)
  if (being_type(ch) == TYPE_CHARACTER) then --- Nur Player löst Falle aus
   local x1 = x - width/2
   local y1 = y - height/2
   local x2 = x + width/2
   local y2 = y + height/2
   local currentTime = os.time(t)
   local lastTime = get_quest_var(ch, "trap_last_activated")

   if (lastTime == nil) or (lastTime == "") then
     chr_set_quest(ch, "trap_last_activated", currentTime)      
     print("trap case1: trap triggered for first time")
   elseif math.floor(currentTime-lastTime) > 20 then
     chr_set_quest(ch, "trap_last_activated", currentTime)      
     --local spawned_monster = monster_create(monsterid, x, y)
     --being_say(spawned_monster,"Du bist in einen Hinterhalt geraten!")
     print("trap case2: create monster")
   else
     print("trap case3: be patient")
     --- nichts passiert
   end

 end
end

---Testfunktionen
emo_count = 0
emo_state = EMOTE_SURPRISE

local function emote_talk(npc, ch)
  if emo_state     == EMOTE_SURPRISE then
    state = "confused"
  elseif emo_state == EMOTE_SAD then
    state = "sad"
  elseif emo_state == EMOTE_HAPPY then
    state = "happy"
  end
  npc_message(npc, ch, string.format("The emotional palm seems %s.", state))
  v = npc_choice(npc, ch,
    "Stupid palm, you are ugly and everyone hates you!",
    "You are such a nice palm, let me give you a hug.",
    "Are you a cocos nucifera or a syagrus romanzoffiana?")

  if (v     == 1) then
    emo_state = EMOTE_SAD
  elseif (v == 2) then
    emo_state = EMOTE_HAPPY
  elseif (v == 3) then
    emo_state = EMOTE_SURPRISE
  end
end

local function emote_update(npc)
  emo_count = emo_count + 1
  if emo_count > 50 then
    emo_count = 0
    effect_create(emo_state, npc)
  end
end

local function int_test_talk(npc, ch)
    npc_message(npc, ch, "Enter a number (50-100)")
    number = npc_ask_integer(npc, ch, 50, 100, 75)
    npc_message(npc, ch, string.format("You have entered %d ", number))
end

local function string_test_talk(npc, ch)
    npc_message(npc, ch, "Enter a string")
    input = npc_ask_string(npc, ch)
    npc_message(npc, ch, string.format("You have entered '%s' Nice choice ! ", input))
end

local function patrol_waypoint(obj, id)
    if (being_type(obj) ~= TYPE_MONSTER) then
        if (id == 1) then
            chat_message(obj, "you've reached patrol point 1")
            being_say(obj, "I have reached patrol point 1")
        elseif (id == 2) then
            chat_message(obj, "you've reached patrol point 2")
            being_say(obj, "I have reached patrol point 2")
        end
    end
end


local function npc1_talk(npc, ch)
  on_remove(ch, function() print "Player has left the map." end);
  npc_message(npc, ch, "Hello! I am the testing NPC.")
  local rights = chr_get_rights(ch);

  if (rights >= 128) then
    npc_message(npc, ch, "Oh mighty server administrator, how can I avoid your wrath?")
  elseif (rights >= 8) then
    npc_message(npc, ch, "How can I be of assistance, sir gamemaster?")
  elseif (rights >= 4) then
    npc_message(npc, ch, "What feature would you like to debug, developer?")
  elseif (rights >= 2) then
    npc_message(npc, ch, "How can I assist you in your testing duties?")
  elseif (rights >= 1) then
    npc_message(npc, ch, "What do you want, lowly player?")
  else
    npc_message(npc, ch, "...aren't you supposed to be banned??")
  end

  local v = npc_choice(npc, ch, "Guns! Lots of guns!",
                               "A Christmas party!",
                               "To buy.",
                               "To sell only the items you want to buy.",
                               "To sell whatever I want.",
                               "To make a donation.",
                               "Slowly count from one to ten.",
                               "Tablepush Test")
  if v == 1 then
    npc_message(npc, ch, "Sorry, this is a heroic-fantasy game, I do not have any gun.")
  elseif v == 2 then
    local n1, n2 = chr_inv_count(ch, 524, 511)
    if n1 == 0 or n2 ~= 0 then
      npc_message(npc, ch, "Yeah right...")
    else
      npc_message(npc, ch, "I can't help you with the party. But I see you have a fancy hat. I could change it into Santa's hat. Not much of a party, but it would get you going.")
      v = npc_choice(npc, ch, "Please do.", "No way! Fancy hats are classier.")
      if v == 1 then
        -- invertika.add_items(ch, 524, -1, 511, 1) Nicht vorhanden.
      end
    end
  elseif v == 3 then

    -- "To buy."
    local buycase = npc_trade(npc, ch, false, { {10001, 10, 20}, {10002, 10, 30}, {10003, 10, 50} })
    if buycase == 0 then
      npc_message(npc, ch, "What do you want to buy?")
    elseif buycase == 1 then
      npc_message(npc, ch, "I've got no items to sell.")
    else
      npc_message(npc, ch, "Hmm, something went wrong... Ask a scripter to fix the buying mode!")
    end

  elseif v == 4 then

    -- "To sell only the items you want to buy."
    local sellcase = npc_trade(npc, ch, true, { {10001, 10, 20}, {10002, 10, 30}, {10003, 10, 200}, {10004, 10, 300}, {10005, 10, 500}, {10006, 10, 25} })
    if sellcase == 0 then
      npc_message(npc, ch, "Here we go:")
    elseif sellcase == 1 then
      npc_message(npc, ch, "I'm not interested by your items.")
    else
      npc_message(npc, ch, "Hmm, something went wrong... Ask a scripter to fix me!")
    end

  elseif v == 5 then

    -- "To sell whatever I want."
    local sellcase = npc_trade(npc, ch, true)
    if sellcase == 0 then
      npc_message(npc, ch, "Ok, what do you want to sell:")
    elseif sellcase == 1 then
      npc_message(npc, ch, "I'm not interested by any of your items.")
    else
      npc_message(npc, ch, "Hmm, something went wrong... Ask a scripter to fix this!")
    end

  elseif v == 6 then
    if invertika.add_money(ch, -100) then
      npc_message(npc, ch, string.format("Thank you for you patronage! You are left with %d gil.", chr_money(ch)))
      local g = tonumber(get_quest_var(ch, "test_donation"))
      if not g then g = 0 end
      g = g + 100
      chr_set_quest(ch, "test_donation", g)
      npc_message(npc, ch, string.format("As of today, you have donated %d gil.", g))
    else
      npc_message(npc, ch, "I would feel bad taking money from someone that poor.")
    end
  elseif v == 7 then
    being_say(npc, "As you wish...")
    schedule_in(2, function() being_say(npc, "One") end)
    schedule_in(4, function() being_say(npc, "Two") end)
    schedule_in(6, function() being_say(npc, "Three") end)
    schedule_in(8, function() being_say(npc, "Four") end)
    schedule_in(10, function() being_say(npc, "Five") end)
    schedule_in(12, function() being_say(npc, "Six") end)
    schedule_in(14, function() being_say(npc, "Seven") end)
    schedule_in(16, function() being_say(npc, "Eight") end)
    schedule_in(18, function() being_say(npc, "Nine") end)
    schedule_in(20, function() being_say(npc, "Ten") end)
  elseif v == 8 then
    local function printTable (t)
      for k,v in pairs(t) do
        print (k, ":", v)
      end
    end
    local t1, t2, t3, t4, t5 = test_tableget();
    print("---------------");
    print ("Table 1:");
    printTable (t1)
    print ("Table 2:");
    printTable (t2)
    print ("Table 3:");
    printTable (t3)
    print ("Table 4:");
    printTable (t4)
    print ("Table 5:");
    printTable (t5)
    print("---------------");
  end
  npc_message(npc, ch, "See you later!")
end

local function npc4_talk(npc, ch)
  npc_message(npc, ch, "You are currently on map "..get_map_id()..". Where do you want to go?")
  local v = npc_choice(npc, ch, "Map 1", "Map 3","Map 3, but a warpable place.")
  if v >= 1 and v <= 3 then
    npc_message(npc, ch, "Are you really sure?")
    local w = npc_choice(npc, ch, "Yes, I am.", "I still have a few things to do around here.")
    if w == 1 then
      if v == 1 then
        chr_warp(ch, nil, 60 * TILESIZE, 50 * TILESIZE)
      elseif v == 2 then
        chr_warp(ch, 3, 25 * TILESIZE, 25 * TILESIZE)
      else
        chr_warp(ch, 3, 70 * TILESIZE, 60 * TILESIZE)
      end
    end
  end
end

local function npc5_talk(npc, ch)
  npc_message(npc, ch, "I am the scorpion tamer. Do you want me to spawn some scorpions?")
  local answer = npc_choice(npc, ch, "Yes", "No")
  if answer == 1 then
    local x = posX(npc)
    local y = posY(npc)
    m1 = monster_create(10, x + TILESIZE, y + TILESIZE)
    m2 = monster_create(10, x - TILESIZE, y + TILESIZE)
    m3 = monster_create(10, x + TILESIZE, y - TILESIZE)
    m4 = monster_create(10, x - TILESIZE, y - TILESIZE)

    on_death(m1, function() being_say(npc, "NOOO!") end)
    on_death(m2, function() being_say(npc, "Please stop this violence!") end)
    on_death(m3, function() being_say(npc, "Stop slaughtering my scorpions!") end)
    on_death(m4, function() being_say(npc, "Leave my scorpions alone!") end)
    on_death(m4, function() being_say(m4, "AAARGH!") end)
  end
end

local guard_position = 1

local function npc6_talk(npc, ch)
  npc_message(npc, ch, "I'm moving....")

  if guard_position == 1 then
    being_walk(npc, 61 * TILESIZE + 16, 15 * TILESIZE + 16, 2.5)
    guard_position = 2
  else
    being_walk(npc, 55 * TILESIZE + 16, 15 * TILESIZE + 16, 2.5)
    guard_position = 1
  end
end

local function npc6_update(npc)
  local r = math.random(0, 100)
  if (r == 0) then
    being_say(npc, "*humhumhum*")
  end
  if (r == 1) then
    being_say(npc, "guarding the city gate is so much fun *sigh*")
  end
  if (r == 2) then
    being_say(npc, "can't someone order me to walk to the other side of the gate?")
  end
end


local function firedemon_talk(npc, ch)
  npc_message(npc, ch, "Burn, puny mortals! BURN! BUUUURN!!!")
end

local firedemon_timer = 0;

local function firedemon_update(npc)
    firedemon_timer = firedemon_timer + 1
    if (firedemon_timer == 5) then
      firedemon_timer = 0
      local victims = get_beings_in_circle(posX(npc), posY(npc), 64)
      local i = 1;
      for i, being in ipairs(victims) do
        if being_type(being) == TYPE_CHARACTER or
           being_type(being) == TYPE_MONSTER then
          being_damage(being, 20, 10, 32000, DAMAGE_MAGICAL, ELEMENT_FIRE)
        end
      end
    end

    npclib.walkaround_map(npc)
end

local function post_talk(npc, ch)
  npc_message(npc, ch, "Hello " .. being_get_name(ch))
  local strength = being_get_attribute(ch, ATTR_STRENGTH)
  npc_message(npc, ch, "You have " .. tostring(strength) .. " strength")
  npc_message(npc, ch, "What would you like to do?")
  local answer = npc_choice(npc, ch, "View Mail", "Send Mail", "Nothing")
  if answer == 1 then
    local sender, post = getpost(ch)
    if sender == "" then
      npc_message(npc, ch, "No Post right now, sorry")
    else
      npc_message(npc, ch, tostring(sender) .. " sent you " .. tostring(post))
    end
  end
  if answer == 2 then
    do_post(npc, ch)
  end
end

local function fireworker_talk(npc, ch)
  npc_message(npc, ch, "Do you want some fireworks?")
  local answer = npc_choice(npc, ch, "Wheee! Fireworks", "Nah, thanks.")
  if answer == 1 then
    local x = posX(npc)
    local y = posY(npc)
      for c = 0, 25 do
        schedule_in (c, function()
          effect_create(c, x + math.random(-200, 200), y + math.random(-200, 200))
        end)
      end
  end
end

local function axetrainer_talk(npc, ch)
  npc_message(npc, ch, "I am the axe trainer. Do you want to get better at using axes?")
  local answer = npc_choice(npc, ch, "Please train me, master.", "I am good enough with axes.")
  if answer == 1 then
    local newexp = chr_get_exp(ch, SKILL_WEAPON_AXE) + 100
    local nextlevel = exp_for_level(being_get_attribute(ch, SKILL_WEAPON_AXE) + 1)
    invertika.add_exp(ch, SKILL_WEAPON_AXE, 100, 0)
    local message = "I gave you 100 axe exp."
    if newexp > nextlevel then
      message = message.." This should be enough to reach the next level."
    else
      message = message.." You will still need "..tostring(nextlevel - newexp).." exp to reach the next level."
    end
    message = message.." I should really stop doing this when the server goes live."
    npc_message(npc, ch, message)
  end
end

local function plague_talk(npc, ch)
  npc_message(npc, ch, "I don't feel so good...")
  being_apply_status(ch, 1, 6000) -- Give plauge for 6000 ticks (I.E. 10 minutes)
end

local function jump_status_talk(npc, ch)
  being_apply_status(ch, 2, 6000) -- Give jumping bug
  npc_message(npc, ch, "Now you have the jumping bug")
end

local function monster_spawn_talk(npc, ch)
  local x = posX(npc)
  local y = posY(npc)
  monster = monster_create(5, x + TILESIZE, y + TILESIZE)
  --monster_load_script(monster, "testmonster.lua")
end

local function sitter_update(npc)
  if being_get_action(npc) == ACTION_SIT then
    if math.random(30) == 1 then
      being_set_action(npc, ACTION_STAND)
    end
  else -- walking or standing
    if math.random(60) == 1 then
      being_set_action(npc, ACTION_SIT)
    else
      npclib.walkaround_small(npc)
    end
  end
end

local spinner_timer = 0

local function spinner_update(npc)
  spinner_timer = spinner_timer + 1
  if spinner_timer == 10 then
    spinner_timer = 0

    direction = being_get_direction(npc)
    if direction == DIRECTION_UP then
      direction = DIRECTION_RIGHT
    elseif direction == DIRECTION_DOWN then
      direction = DIRECTION_LEFT
    elseif direction == DIRECTION_LEFT then
      direction = DIRECTION_UP
    elseif direction == DIRECTION_RIGHT then
      direction = DIRECTION_DOWN
    else
      direction = DIRECTION_DOWN -- set inital direction
    end

    being_set_direction(npc, direction)
  end
end

local function healer_talk(npc, ch)
    npc_message(npc, ch, "Do you need healing?")
    local c = npc_choice(npc, ch, "Heal me fully", "Heal 100 HP", "Don't heal me")
    if c == 1 then
        being_heal(ch)
    elseif c == 2 then
        being_heal(ch, 100)
    end
    
end

local function debugger_talk(npc, ch)
    npc_message(npc, ch, "Was soll debuggt werden?")
    local c = npc_choice(npc, ch, "Nix.", "Effekte.")
    if c == 2 then
        npc_message(npc, ch, "Effektid?")
        local id = npc_ask_integer(npc, ch, 0, 9999, 0)
        effect_create(id, ch)
    end
end

local function speedy_talk(npc, ch)
    while true do
        npc_message(npc, ch, "Möchtest du schneller laufen?")
        local v = npc_choice(npc, ch, "Ja", "Nein")
        if v == 1 then
            local speed = being_get_speed(ch) * being_get_speed(ch)
            being_set_speed(ch, speed)
            npc_message(npc, ch, "Du bist nun schneller.")
            break
        elseif v == 2 then
            npc_message(npc, ch, "Blubb")
            break
        end
    end
end

local function timel_talk(npc, ch)
    time1 = os.time(t)
    npc_message(npc, ch, "Nehme 2. Zeit.")
    time2 = os.time(t)
    diff = time1 - time2
    npc_message(npc, ch, string.format("1. Zeit %d", time1))
    npc_message(npc, ch, string.format("2. Zeit %d", time2))
    npc_message(npc, ch, string.format("Differenz %d", diff))
end

atinit(function()
 create_inter_map_warp_trigger(19003, 19003, 19003, 19003) --- Intermap warp
 npc_create("Debugger", 58, GENDER_UNSPECIFIED, 133 * TILESIZE + 16, 21 * TILESIZE + 16, debugger_talk, nil) -- Debugger
 npc_create("Zelan", 58, GENDER_UNSPECIFIED, 132 * TILESIZE + 16, 21 * TILESIZE + 16, zelan_talk, nil) --- Zelan
 trigger_create(20 * TILESIZE, 20 * TILESIZE, 22 * TILESIZE, 22 * TILESIZE, trap_trigger_skorpions, 0, true) --- Trigger Trap
 npc_create("Aliria", 2, GENDER_UNSPECIFIED, 15 * TILESIZE + 16, 15 * TILESIZE + 16, alaria_talk, nil) --- Alaria Handels Test NPC

--Test NPCs
  npc_create("Test NPC", 200, GENDER_UNSPECIFIED, 50 * TILESIZE + 16, 19 * TILESIZE + 16, npc1_talk, npclib.walkaround_small)
  npc_create("Teleporter", 201, GENDER_UNSPECIFIED, 51 * TILESIZE + 16, 25 * TILESIZE + 16, npc4_talk, npclib.walkaround_wide)
  npc_create("Scorpion Tamer", 26, GENDER_UNSPECIFIED, 45 * TILESIZE + 16, 25 * TILESIZE + 16, npc5_talk, nil)
  npc_create("Guard", 22, GENDER_UNSPECIFIED, 58 * TILESIZE + 16, 15 * TILESIZE + 16, npc6_talk, npc6_update)
  npc_create("Fire Demon", 202, GENDER_UNSPECIFIED, 58 * TILESIZE + 16, 35 * TILESIZE + 16, firedemon_talk, firedemon_update)
  npc_create("Post Box", 58, GENDER_UNSPECIFIED, 45 * TILESIZE + 16, 22 * TILESIZE + 16, post_talk)
  npc_create("Fireworker", 58, GENDER_UNSPECIFIED, 43 * TILESIZE, 23 * TILESIZE, fireworker_talk, npclib.walkaround_small)
  npc_create("Axe Trainer", 26, GENDER_UNSPECIFIED, 65 * TILESIZE, 18 * TILESIZE, axetrainer_talk, nil)
  npc_create("Int NPC", 26, GENDER_UNSPECIFIED, 68 * TILESIZE, 20 * TILESIZE, int_test_talk, nil)
  npc_create("String NPC", 26, GENDER_UNSPECIFIED, 65 * TILESIZE, 20 * TILESIZE, string_test_talk, nil)
-- Auskommentiert, weil die Statuszustände Plage und Jumping Bug im Moment zu Servercrashs führen
--  npc_create("Plague NPC", 26, GENDER_UNSPECIFIED, 70 * TILESIZE, 20 * TILESIZE, plague_talk, nil)
--  npc_create("Jumping Bug NPC", 26, GENDER_UNSPECIFIED, 75 * TILESIZE, 20 * TILESIZE, jump_status_talk, nil)
  npc_create("Monster spawn", 26, GENDER_UNSPECIFIED, 80 * TILESIZE, 20 * TILESIZE, monster_spawn_talk, nil)
  npc_create("Emotional Palm", 27, GENDER_UNSPECIFIED, 68 * TILESIZE, 25 * TILESIZE, emote_talk, emote_update)
  npc_create("Sitter", 201, GENDER_UNSPECIFIED, 51 * TILESIZE + 16, 25 * TILESIZE + 16, nil, sitter_update)
  npc_create("Spinner", 201, GENDER_UNSPECIFIED, 51 * TILESIZE + 16, 30 * TILESIZE + 16, nil, spinner_update)
  npc_create("Healer", 19, GENDER_UNSPECIFIED, 54 * TILESIZE + 16, 32 * TILESIZE + 16, healer_talk, nil)
  skorpion_rennen_npc = npc_create("Skorpion Rennen", 27, GENDER_UNSPECIFIED, 142 * TILESIZE + 16, 72 * TILESIZE +16, scorpionrace.race_manager_talk, nil)
  poker_dealer_npc = npc_create("Dealer", 27, GENDER_UNSPECIFIED, 82 * TILESIZE + 16, 142 * TILESIZE + 16, poker_dealer_talk, nil)
  npc_create("Feuerwerker", 139, GENDER_UNSPECIFIED, 177 * TILESIZE + 16, 185 * TILESIZE + 16, fireworker_talk, npclib.walkaround_small)
  postmen.create_postman_npc("sandbox1", "A1", 27, 75 * TILESIZE + 16, 151 * TILESIZE + 16, {{id="sandbox2", distance=1}, {id="sandbox3", distance=1}, {id="sandbox4", distance=1}}, 40001)
  postmen.create_postman_npc("sandbox2", "A2", 27, 77 * TILESIZE + 16, 151 * TILESIZE + 16, {{id="sandbox1", distance=1}, {id="sandbox3", distance=1}, {id="sandbox4", distance=1}}, 40002)
  postmen.create_postman_npc("sandbox3", "A3", 27, 75 * TILESIZE + 16, 153 * TILESIZE + 16, {{id="sandbox1", distance=1}, {id="sandbox2", distance=1}, {id="sandbox4", distance=1}}, 40003)
  postmen.create_postman_npc("sandbox4", "A4", 27, 77 * TILESIZE + 16, 153 * TILESIZE + 16, {{id="sandbox1", distance=1}, {id="sandbox2", distance=1}, {id="sandbox3", distance=1}}, 40007)
  npc_create("Speedy", 19, GENDER_UNSPECIFIED, 150 * TILESIZE + 16, 175 * TILESIZE + 16, speedy_talk, nil)
  npc_create("Timel", 145, GENDER_UNSPECIFIED, 152 * TILESIZE + 16, 177 * TILESIZE + 16, timel_talk, nil)
  
 game = poker.PokerGame:new(200)
 game:registerEventNextPlayer(function(my_player)
   being_say(poker_dealer_npc, string.format("%s ist an der Reihe.", being_get_name(my_player:getCh())))
 end)
 game:registerEventPlayerExit(function(my_player)
   being_say(poker_dealer_npc, string.format("%s verlässt das Spiel.", being_get_name(my_player:getCh())))
 
  myguard = npc_create("Guard", 200, GENDER_UNSPECIFIED, 100 * TILESIZE, 100 * TILESIZE, function(npc, ch)
      npc_message(npc, ch, "bla!")
  end, nil)
  guard.create_player_hunter(myguard, 500, 32, 5 * TILESIZE, 1000, 10, 9999, DAMAGE_PHYSICAL, 1)
 end)


local scorpions = {}
scorpions[1] = {}
scorpions[1][scorpionrace.SCORPION_START_X] = 138 * TILESIZE + 16
scorpions[1][scorpionrace.SCORPION_START_Y] = 70 * TILESIZE + 16
scorpions[1][scorpionrace.SCORPION_STROLL_UP] = 5 * TILESIZE
scorpions[1][scorpionrace.SCORPION_STROLL_RIGHT] = 0 * TILESIZE
scorpions[1][scorpionrace.SCORPION_STROLL_DOWN] = 1
scorpions[1][scorpionrace.SCORPION_STROLL_LEFT] = 0
scorpions[1][scorpionrace.SCORPION_TARGET_X] = 138 * TILESIZE
scorpions[1][scorpionrace.SCORPION_TARGET_Y] = 62 * TILESIZE
scorpions[1][scorpionrace.SCORPION_TARGET_WIDTH] = TILESIZE
scorpions[1][scorpionrace.SCORPION_TARGET_HEIGHT] = TILESIZE * 2
scorpions[1][scorpionrace.SCORPION_NPC] = npc_create("Rennskorpion", 140, GENDER_UNSPECIFIED, 138 * TILESIZE + 16, 70 * TILESIZE + 16, scorpion_talk, nil)
scorpions[1][scorpionrace.SCORPION_NAME] = "Skorpion 1"

scorpions[2] = {}
scorpions[2][scorpionrace.SCORPION_START_X] = 140 * TILESIZE + 16
scorpions[2][scorpionrace.SCORPION_START_Y] = 70 * TILESIZE + 16
scorpions[2][scorpionrace.SCORPION_STROLL_UP] = 5 * TILESIZE
scorpions[2][scorpionrace.SCORPION_STROLL_RIGHT] = 0 * TILESIZE
scorpions[2][scorpionrace.SCORPION_STROLL_DOWN] = 1
scorpions[2][scorpionrace.SCORPION_STROLL_LEFT] = 0
scorpions[2][scorpionrace.SCORPION_TARGET_X] = 140 * TILESIZE
scorpions[2][scorpionrace.SCORPION_TARGET_Y] = 62 * TILESIZE
scorpions[2][scorpionrace.SCORPION_TARGET_WIDTH] = TILESIZE
scorpions[2][scorpionrace.SCORPION_TARGET_HEIGHT] = TILESIZE * 2
scorpions[2][scorpionrace.SCORPION_NPC] = npc_create("Rennskorpion", 140, GENDER_UNSPECIFIED, 140 * TILESIZE + 16, 70 * TILESIZE + 16, scorpion_talk, nil)
scorpions[2][scorpionrace.SCORPION_NAME] = "Skorpion 2"

scorpions[3] = {}
scorpions[3][scorpionrace.SCORPION_START_X] = 142 * TILESIZE + 16
scorpions[3][scorpionrace.SCORPION_START_Y] = 70 * TILESIZE + 16
scorpions[3][scorpionrace.SCORPION_STROLL_UP] = 5 * TILESIZE
scorpions[3][scorpionrace.SCORPION_STROLL_RIGHT] = 0 * TILESIZE
scorpions[3][scorpionrace.SCORPION_STROLL_DOWN] = 1 
scorpions[3][scorpionrace.SCORPION_STROLL_LEFT] = 0 
scorpions[3][scorpionrace.SCORPION_TARGET_X] = 142 * TILESIZE
scorpions[3][scorpionrace.SCORPION_TARGET_Y] = 62 * TILESIZE
scorpions[3][scorpionrace.SCORPION_TARGET_WIDTH] = TILESIZE
scorpions[3][scorpionrace.SCORPION_TARGET_HEIGHT] = TILESIZE * 2 
scorpions[3][scorpionrace.SCORPION_NPC] = npc_create("Rennskorpion", 140, GENDER_UNSPECIFIED, 142 * TILESIZE + 16, 70 * TILESIZE + 16, scorpion_talk, nil)
scorpions[3][scorpionrace.SCORPION_NAME] = "Skorpion 3"

scorpionrace.initializeRace(scorpions, skorpion_rennen_npc, 2)



  trigger_create(56 * TILESIZE, 32 * TILESIZE, 64, 64, patrol_waypoint, 1, true)
  trigger_create(63 * TILESIZE, 32 * TILESIZE, 64, 64, patrol_waypoint, 2, true)

  item_drop(58 * TILESIZE, 26 * TILESIZE, 10001, 1);
  item_drop(58 * TILESIZE, 27 * TILESIZE, 10002, 10);
  item_drop(58 * TILESIZE, 27 * TILESIZE, 10003, 1);

  schedule_every(1 * HOURS + 30 * MINUTES, function()
    print("One and a half hour has passed on map 1-1")
  end)


  scorpions_bet_accepted = function(scorpionId, player, money)
    being_say(skorpion_rennen_npc, string.format("%s hat %s Aki auf Skorpion Nummer %s geboten!", being_get_name(player), money, scorpionId))
    being_say(skorpion_rennen_npc, "Das Rennen beginnt in einer Minute.")
    schedule_in(60, function()
        being_say(skorpion_rennen_npc, "GO!")
        scorpionrace.start_race()
    end)
  end
  
  scorpionrace.set_event_scorpion_bet_accepted(scorpions_bet_accepted)

end)
