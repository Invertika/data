----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
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

require "scripts/lua/npclib"

require "scripts/libs/invertika"
require "scripts/libs/nethek"
require "scripts/libs/sign"

dofile("data/scripts/libs/warp.lua")

atinit(function()
    create_inter_map_warp_trigger(nil, 33, 43, 55) --- Intermap warp
    nethek.create_netheksaeule(103 * TILESIZE, 107 * TILESIZE + 16) ---Netheksäule

    sign_entrance = "Burg Cedric"
    sign.create_sign(106, 182, sign_entrance) --- Schild Burgeingang
    
    mana.trigger_create(101 * TILESIZE, 170 * TILESIZE, 3 * TILESIZE, 3 * TILESIZE, "wache_trigger", 1, true)
    
    diem = create_npc("Diem", 139, 60 * TILESIZE + 16, 160 * TILESIZE + 16, diem_talk, diem_update)
    invertika.create_npc_talk_random(diem,
      {"Kauft Leute! Kauft!",
      "Beste Waren! Hergestellt in den königlichen Schmieden!",
      "Sehen Sie! Dieses Schwert ist unzerbrechlich! ZACK. Oh...",
      "Kommen Sie meine Herren. Diese Waffen sind die Besten."})

    create_npc("Chris", 141, 50 * TILESIZE + 16, 118 * TILESIZE + 16, chris_talk, npclib.walkaround_wide)

    create_npc("Estjdan", 120, 141 * TILESIZE + 16, 154 * TILESIZE + 16, estjdan_talk, nil)
    
    create_npc("Palastwache", 26, 58 * TILESIZE + 16, 100 * TILESIZE + 16, palastwache_talk, nil)
    create_npc("Palastwache", 26, 61 * TILESIZE + 16, 100 * TILESIZE + 16, palastwache_talk, nil)
    
    create_npc("Wache", 26, 150 * TILESIZE + 16, 119 * TILESIZE + 16, wache_bank_talk, nil)
    create_npc("Wache", 26, 153 * TILESIZE + 16, 119 * TILESIZE + 16, wache_bank_talk, nil)
    create_npc("Wache", 26, 52 * TILESIZE + 16, 149 * TILESIZE + 16, wache_casino_talk, nil)
    
    wache_unten_links = create_npc("Wache", 26, 100 * TILESIZE + 16, 174 * TILESIZE + 16, wache_talk, nil) -- Wache Außentor
    wache_unten_rechts = create_npc("Wache", 26, 104 * TILESIZE + 16, 174 * TILESIZE + 16, wache_talk, nil) -- Wache Außentor
    create_npc("Wache", 26, 100 * TILESIZE + 16, 140 * TILESIZE + 16, wache_talk, nil) -- Wache Innentor
    create_npc("Wache", 26, 104 * TILESIZE + 16, 140 * TILESIZE + 16, wache_talk, nil) -- Wache Innentor

    cedric = create_npc("Cedric", 39, 81 * TILESIZE + 16, 97 * TILESIZE + 16, cedric_talk, nil)
    
    -- Cedric´s Rede
    invertika.schedule_every_day(17, 59, 00, cedric_speech)
    
    -- Feuerwerk
    invertika.schedule_every_day(18, 00, 00, firework_round)
end)

function diem_talk(npc, ch)
    mana.npc_trade(npc, ch, false, {
      {10001, 30, 50},
      {10013, 30, 140},
      {10002, 30, 1000},
      {10009, 30, 1690},
      {20001, 30, 250},
      {20002, 30, 250},
      {20011, 30, 250},
      {20012, 30, 250},
      {20013, 30, 250},
      {20014, 30, 250},
      {20015, 30, 250},
      {20016, 30, 250},
      {20017, 30, 250},
      {20018, 30, 250},
      {20009, 30, 500}
    })
    do_npc_close(npc, ch)
end

function diem_update(npc)
    npclib.walkaround_wide(npc)
    invertika.npc_talk_random(npc)
end

function chris_talk(npc, ch)
    --TODO bessere Texte
    do_message(npc, ch, "Guten Tag der Herr.")
    do_npc_close(npc, ch)
end

function estjdan_talk(npc, ch)
    --TODO zu einem Händler machen keine Getränke, Lebensmittel
    do_message(npc, ch, "Tag der Herr")
    do_npc_close(npc, ch)
end

function wache_bank_talk(npc, ch)
    --TODO bessere Texte
    do_message(npc, ch, "Wir bewachen die Bank.")
    do_npc_close(npc, ch)
end

function wache_casino_talk(npc, ch)
    --TODO bessere Texte
    do_message(npc, ch, invertika.get_random_element("Ich bewache das Kasino.",
      "Glücksspiel kann süchtig machen.",
      "Ohne uns Wachen, würde die Stadt im Chaos versinken!"))
    do_npc_close(npc, ch)
end

function wache_talk(npc, ch)
    local quest_string = "burg_cedric_guard_macguffin"
    invertika.init_quest_status(ch, quest_string)
    local q_status = invertika.get_quest_status(ch, quest_string)
    if q_status = 0 then
        do_message(npc, ch, "Ich habe meinen MacGuffin verloren!")
        do_message(npc, ch, "Er ist bestimmt im Westen, in der Bolero Höhle, ganz sicher!")
        do_message(npc, ch, "Woher ich das weiß?")
        do_message(npc, ch, "Das gehört sich für einen MacGuffin einfach so!")
        do_message(npc, ch, "Und deshalb lasse ich dich auch nicht in die Stadt, bevor du ihn mir wiedergebracht hast.")
        do_message(npc, ch, "Obwohl.. so wie DU aussiehst, wird das wohl eh nix..")
        invertika.set_quest_status(ch, quest_string, 1)
    elseif q_status = 1 then
        if mana.chr_inv_count(ch, 40047) > 0 then
            do_message(npc, ch, "Ah Danke für den MacGuffin. " ..
                                "Nun darfst du die Stadt betreten")
            invertika.add_items(ch, 40047, -1, "MacGuffin")
            invertika.set_quest_status(ch, quest_string, 2)
        else
            do_message(npc, ch, invertika.get_random_element(
              "Wenn du mir keinen MacGuffin bringst kommst du nicht rein!",
              "Bringe mir einen MacGuffin. Dann lasse ich dich rein!",
              "Du findest einen MacGuffin in der Bolero Höhle. " ..
                "Bringe mir einen davon"))
        end
    elseif q_status = 2 then
        do_message(npc, ch, invertika.get_random_element(
          "Wir bewachen die Tore der Stadt",
          "Gehe weiter. Du blockierst die Straße.",
          "Ohne uns Wachen, würde die Stadt im Chaos versinken!"))
    end
    do_npc_close(npc, ch)
end

function wache_trigger(ch, id)
    if mana.being_type(ch) ~= TYPE_MONSTER then
        if mana.chr_inv_count(ch, 40047) == 0 then
            local x = mana.posX(ch)
            mana.chr_warp(ch, nil, x, 176 * TILESIZE + 16)
            if x < 102 * TILESIZE + 16 then
                mana.being_say(wache_unten_links, "Bevor ich meinen MacGuffin nicht wiederhabe, kommst du hier nicht durch!")
            else
                mana.being_say(wache_unten_rechts, "Bevor ich meinen MacGuffin nicht wiederhabe, kommst du hier nicht durch!")
            end
        end
    end
end

function firework_round()
    local c = 1
    while c < 100 do
        spawn_effect()
        c = c + 1
    end

    local d = os.date("*t")
    local start = os.time{year=d.year, month=d.month, day=d.day,
                          hour=24, min=01, sec=0}
    if os.difftime(os.time(), start) < 15 * 60 then
        schedule_in(1, firework_round)
    end
end

function spawn_effect()
    mana.effect_create(math.random(0, 25),
                       math.random(10 * TILESIZE, 190 * TILESIZE),
                       math.random(10 * TILESIZE, 190 * TILESIZE))
end

function cedric_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Ich bin Graf Cedric.", 
      "Fühle dich, in meiner Burg, wie zu Hause."))
    do_npc_close(npc, ch)
end

function cedric_speech()
    local speech = {
      "Heute haben wir uns versammelt, um den Wiederaufbau der Burg Cedric zu feiern.",
      "Vor nicht allzu langer Zeit, wurde unser gemeinsames Heim von einer Flutwelle überschwemmt.",
      "Wir mussten fliehen, um nicht zu ertrinken.",
      "Wir lebten in der Zeit als Bettler, Schnorrer und Diebe.",
      "Einige von uns sind gestorben oder wurden getötet.",
      "Sie werden uns aber immer in Erinnerung bleiben.",
      "Als wir hörten, dass sich das Wasser zurückzog, kamen wir hierhin zurück.",
      "Wir sahen, dass nur noch die Mauern der Burg standen.",
      "Aber durch unseren starken Gemeinschaftssinn, konnten wir die Burg noch prächtiger und schöner wiederaufbauen, als sie jemals war.",
      "Ich danke euch, genießt das Feuerwerk."
    }

    if not cedric_speech_index then
       cedric_speech_index = 1 
    end
    mana.being_say(cedric, speech[cedric_speech_index])
    cedric_speech_index = cedric_speech_index + 1
    if cedric_speech_index <= #speech then
        schedule_in(5, cedric_speech)
    else
        cedric_speech_index = 1
    end
end

function palastwache_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Wir bewachen den Palast Cedric´s.",
      "Im Haus hinter uns wohnt Cedric und seine Frau Ormylt"))
    do_npc_close(npc, ch)
end
