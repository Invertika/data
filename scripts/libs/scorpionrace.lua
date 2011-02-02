----------------------------------------------------------------------------------
-- Skorpionrennen Modul - Funktionen für Skorpionrennen                         --  
--                                                                              --  
-- Dieses Modul stellt Grundfunktionen zur Verfügung                            --  
--                                                                              --  
--                                                                              --  
----------------------------------------------------------------------------------
--  Copyright 2008 The Invertika Development Team                               --  
--                                                                              --  
--  This file is part of Invertika.                                             --  
--                                                                              --  
--  Invertika is free software; you can redistribute it and/or modify it        --  
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("skorpionrace", package.seeall)

require("scripts/libs/invertika")

SCORPION_START_X = 0
SCORPION_START_Y = 1
SCORPION_STROLL_UP = 2
SCORPION_STROLL_RIGHT = 3
SCORPION_STROLL_DOWN = 4
SCORPION_STROLL_LEFT = 5
SCORPION_TARGET_X = 6
SCORPION_TARGET_Y = 7
SCORPION_TARGET_WIDTH = 8
SCORPION_TARGET_HEIGHT = 9
SCORPION_NPC = 10
SCORPION_NAME = 11

--- scorpions[<index>][<Eigenschaft>] = Wert
local scorpions = nil
local bets = {}
local status = 0
local winnings = {}
local bet_npc = nil
local winnig_factor = nil

--- Events
local event_scorpion_won = function(id)
  mana.being_say(bet_npc, string.format("Das Skorpion %s hat gewonnen.", scorpions[SCORPION_NAME]))
  end
local event_scorpions_ready_again = function()
  mana.being_say(bet_npc, "Die Skorpione sind wieder bereit! Auf in die neue Runde! Wetten können hier abgeschlossen werden.")
  end)




-- Initialisiert die Variablen.
Parameter
function initializeRace(p_scorpions, p_bet_npc, p_winning_factor)
    scoprions = p_scorpions
    bet_npc = p_bet_npc
    winning_factor = p_winning_factor
    create_trigger()
end

function create_trigger()
    for i, scorpion in ipairs(scorpions) do
        mana.trigger_create(
          scorpion[SCORPION_TARGET_X],
          scorpion[SCORPION_TARGET_Y],
          scorpion[SCORPION_TARGET_WIDTH],
          scorpion[SCORPION_TARGET_HEIGHT],
          trigger_race_end, i, true)
    end
end

function trigger_race_end(being, id)
    if status == 1 then -- Sieger
        winnings = bets[id]
        bets = {}
        status = 2
        for i, scorpion in ipairs(scorpions) do
            mana.being_walk(
              scorpion[SCORPION_NPC],
              scorpion[SCORPION_TARGET_X] + scorpion[SCORPION_TARGET_WIDTH] / 2,
              scorpion[SCORPION_TARGET_Y] + scorpion[SCORPION_TARGET_HEIGHT] / 2,
              1) -- Alle Skorpione zum Ziel laufen lassen.

        end
        -- Den Skorpionen Zeit geben zurück zur Startlinie zu kommen.
        local time_till_all_home = invertika.get_distance(
          mana.posX(scorpion[SCORPION_NPC_START_X]),
          mana.posY(scorpion[SCORPION_NPC_START_Y]),
          scorpion[SCORPION_TARGET_X] + scorpion[SCORPION_TARGET_WIDTH] / 2,
          scorpion[SCORPION_TARGET_Y] + scorpion[SCORPION_TARGET_HEIGHT] / 2) / TILESIZE * 2.5

        event_scorpion_won(id)
        schedule_in(time_till_all_home, function()
          status = 0
          event_scorpions_ready_again()
          end)
   end 
   mana.being_walk(scorpion[SCORPION_NPC],
     scorpion[SCORPION_START_X],
     scorpion[SCORPION_START_Y],
     1) -- Skorpion zurück zur Startlinie laufen lassen.
end

function move_scorpions()
    if status == 1 then -- Rennen läuft.
        for i, scorpion in ipairs(scorpions) do
            local desired_x = mana.posX(scorpion[SCOPRION_NPC])
            local desired_y = mana.posY(scorpion[SCOPRION_NPC])

            local desired_x = desired_x + math.random(
              scorpion[SCOPRION_STROLL_LEFT], scorpion[SCOPRION_STROLL_RIGHT])

            local desired_y = desired_y + math.random(
              scorpion[SCOPRION_STROLL_UP], scorpion[SCOPRION_STROLL_DOWN])

            mana.being_walk(scorpion[SCORPION_NPC], desired_x, desired_y, 1)
        end
        schedule_in(1, move_scorpions())
    end
end

function start_race()
    if status == 0 then
        status = 1
        move_scorpions()
    end
end

function race_manager_talk(npc, ch)
    do_message(npc, ch, "Willkommen beim Skorpionrennen! Hier kannst du auf ein Skorpion bieten und bekommst, wenn du richtig liegst den Gewinn.")
    local answer_choices = {}
    answer_choices[1] = "Auf Skorpion bieten."
    if (winnings[ch] ~= nil) and (winnings[ch] > 0) then
        answer_choices[2] = "Gewinn abholen."
    end
    while true do
        local v = do_choice(npc, ch, answer_choices)
        if v == 1 then
            local answer_choices2 = {}
            for i,scorpion in ipairs(scorpions) do
                answer_choices2[i] = scorpion[SCORPION_NAME]
            end
            while true do
                local v2 = do_choice(npc, ch, answer_choices2)
                if scorpions[v2] ~= nil then
                local betrag = do_ask_integer(npc, ch, 0, 50000, 100)

                if status == 0 then --Nur wenn Skorpionen beim Start sind Angebote annehmen.
                    if mana.chr_money(ch) >= betrag then
                        invertika.add_money(ch, -betrag)
                        if bets[v2] == nil then bets[v2] = {} end -- ggf. init    ialisie
                        if bets[v2][ch] == nil then
                            bets[v2][ch] = betrag
                        else
                            bets[v2][ch] = bets[v2][ch] + betrag
                        end
                        mana.being_say(npc, string.format("%s hat %s Aki auf Skorpion Nummer %s geboten!", mana.being_get_name(ch), betrag, v2))
                    else
                        do_message(npc, ch, "Du hast nicht genügen Geld!")
                    end
                else
                    do_message(npc, ch, "Zur Zeit nehme ich keine Gebote an!")
                end
                end
            end
            break
        elseif v == 2 then
            if winnings == nil then -- Keiner hat auf den Sieger gesetzt.
                do_message(npc, ch, "Du hast nichts gewonnen a")
            elseif winnings[ch] == nil then -- Spieler hat nicht auf den Sieger gesetzt.
                do_message(npc, ch, "Du hast nichts gewonnen b")
            elseif winnings[ch] > 0 then -- Gewonnen
                winnings[ch] = winnings[ch] * winning_factor
                do_message(npc, ch, string.format(
                  "Herzlichen Glückwunsch! Hier hast du deine %s Aki.", winnings[ch]))
                invertika.add_money(ch, winnings[ch])
                winnings[ch] = 0
            end
            break
        end
    end
end
