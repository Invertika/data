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

require "scripts/libs/warp"


local function create_chris()
    local d = os.date("*t")
    local create_chris_on_fields_time = os.time{year=d.year, month=d.month, day=12,
                          hour=0, min=00, sec=0}
    if os.difftime(os.time(), create_chris_on_fields_time) > 0 then
        npc_create("Chris", 141, GENDER_UNSPECIFIED, 156 * TILESIZE + 16, 148 * TILESIZE + 16, chris_talk, npclib.walkaround_wide) -- Auf den Getreidefeldern
    else
        npc_create("Chris", 141, GENDER_UNSPECIFIED, 50 * TILESIZE + 16, 118 * TILESIZE + 16, chris_talk, npclib.walkaround_map) -- Im oberem Teil Burg Cedric's
    end
end

local function diem_talk(npc, ch)
    npc_trade(npc, ch, false, {
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
end

local function chris_talk(npc, ch)

    local queststring_lazy = "castle_cedric_lazy_chris_quest"
    local queststring_ice = "castle_cedric_chris_ice_quest"
    --Init Quests
    invertika.init_quest_status(ch, queststring_lazy)
    invertika.get_quest_status(ch, queststring_ice)
    --Get Quests
    local quest_var_lazy = invertika.get_quest_status(ch, queststring_lazy)
    local quest_var_ice = invertika.get_quest_status(ch, queststring_ice)
    
    if quest_var_lazy == 0 then
        npc_message(npc, ch, "psst")
    end
    
    if quest_var_lazy == 1 then
        npc_message(npc, ch, "Ahrg, garnicht mehr dran gedacht.")
        npc_message(npc, ch, "Habe aber auch keine Lust drauf.")
        npc_message(npc, ch, "Sage ihm, das ich gleich komme.")
        npc_message(npc, ch, "Danke")
        --Set Quest
        invertika.set_quest_status(ch, queststring_lazy, 3) -- Quest angenommen und es wurde mit Chris geredet
    end
    
    if quest_var_lazy == 3 then
        npc_message(npc, ch, "Hetz mich nicht so, bin ja schon aufm Weg.")
    end
    
    if quest_var_lazy == 4 then
        local d = os.date("*t")
        local create_chris_on_fields_time = os.time{year=d.year, month=d.month, day=12,
                                                hour=0, min=00, sec=0}
        if os.difftime(os.time(), create_chris_on_fields_time) > 0 then
            npc_message(npc, ch, "Du!")
            npc_message(npc, ch, "Los, hol mir ein Eis.")
            npc_message(npc, ch, "Wenn du mir schon diese Schwerstarbeit aufbrockst, kannst du wenigstens für mein leibliches Wohl sorgen.")
            npc_message(npc, ch, "Und, machst du's?")
            while true do
                local s = npc_choice(npc, ch, "Ja",
                  "Nein")
                if s == 1 then
                    npc_message(npc, ch, "Danke.")
                    --Set Quests
                    invertika.set_quest_status(ch, queststring_ice, 1) --Eishol Quest anfangen
                    invertika.set_quest_status(ch, queststring_lazy, 5) -- Weg mit der unnützen Quest :D
                    break
                elseif s == 2 then
                    npc_message(npc, ch, "ok.")
                    break
                end
            end
        end
    end
    
    if quest_var_ice == 1 then
        if chr_inv_count(ch, 30029) then
            npc_message(npc, ch, "Ich bin dir sehr dankbar.")
            invertika.add_money(ch, 400)
            invertika.add_items(ch, 30029, -1, "Eis")
            invertika.set_quest_status(ch, queststring_ice, 2)
        else
            do_mesage(npc, ch, "Eis.")
        end
    end
    
    if quest_var_ice == 2 then
        npc_message(npc, ch, "Hi.")
    end
    
end

local function estjdian_talk(npc, ch)

    local queststring = "castle_cedric_lazy_chris_quest"
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)

    if quest_var == 0 then
    
        npc_message(npc, ch, "Wo steckt dieser faule Bengel schon wieder...")
        npc_message(npc, ch, "Er sollte schon vor einer halben Stunde zur Arbeit antreten.")
        npc_message(npc, ch, "Von wem ich eigentlich spreche, willst du wissen?")
        npc_message(npc, ch, "Ich spreche von Chris.")
        npc_message(npc, ch, "Er kam früher bereits unpünktlich.")
        npc_message(npc, ch, "Würdest du ihn bitte suchen?")
        while true do
            local s = npc_choice(npc, ch, "Ja, na klar.",
              "Nein, leider nicht.")
            if s == 1 then
                npc_message(npc, ch, "Danke")
                --Set Quest
                invertika.set_quest_status(ch, queststring, 1) -- Quest angenommen
                break
            elseif s == 2 then
                npc_message(npc, ch, "Hmm, ok.")
                npc_message(npc, ch, "Dann mache ich mich eben selbst auf den Weg.")
                invertika.set_quest_status(ch, queststring, 2) -- Quest nicht angenommen
                break
            end
        end
    end
    
    if quest_var == 2 then
        npc_message(npc, ch, "Ah, du hast es dir anders überlegt?")
        while true do
            local a = npc_choice(npc, ch, "Jap",
              "nö")
            if a == 1 then
                npc_message(npc, ch, "OK, danke.")
                npc_message(npc, ch, "Besser spät als nie.")
                --Set Quest
                invertika.set_quest_status(ch, queststring, 1) -- Quest angenommen
                break
            elseif a == 2 then
                npc_message(npc, ch, "Hmmm, ok")
                break
            end
        end
    end
    
    if quest_var == 3 then
        npc_message(npc, ch, "Ich danke dir dafür, dass du diesen Nichtsnutz gefunden hast.")
        npc_message(npc, ch, "Hier eine kleine Belohnung für deine Mühen.")
        invertika.add_money(ch, 250)
        --Set Quest
        invertika.set_quest_status(ch, queststring, 4) -- Quest angenommen und Behlonung vom Estjdian kassiert
    end
    
    if quest_var >= 4 then
        npc_message(npc, ch, "Hoffentlich bessert er sich.")
    end
end

local function wache_bank_talk(npc, ch)
    --TODO bessere Texte
    npc_message(npc, ch, "Wir bewachen die Bank.")
end

local function wache_casino_talk(npc, ch)
    --TODO bessere Texte
    npc_message(npc, ch, invertika.get_random_element("Ich bewache das Kasino.",
      "Glücksspiel kann süchtig machen.",
      "Ohne uns Wachen würde die Stadt im Chaos versinken!"))
end

local function wache_talk(npc, ch)
    local quest_string = "burg_cedric_guard_macguffin"
    invertika.init_quest_status(ch, quest_string)
    local q_status = invertika.get_quest_status(ch, quest_string)
    if q_status == 0 then
        npc_message(npc, ch, "Ich habe meinen MacGuffin verloren!")
        npc_message(npc, ch, "Er ist bestimmt im Westen, in der Bolero Höhle, ganz sicher!")
        npc_message(npc, ch, "Woher ich das weiß?")
        npc_message(npc, ch, "Das gehört sich für einen MacGuffin einfach so!")
        npc_message(npc, ch, "Und deshalb lasse ich dich auch nicht in die Stadt, bevor du ihn mir wiedergebracht hast.")
        npc_message(npc, ch, "Obwohl... so, wie DU aussiehst, wird das wohl eh nix...")
        invertika.set_quest_status(ch, quest_string, 1)
    elseif q_status == 1 then
        if chr_inv_count(ch, 40047) > 0 then
            npc_message(npc, ch, "Ah, danke für den MacGuffin." ..
                                "Nun darfst du die Stadt betreten.")
            invertika.add_items(ch, 40047, -1, "MacGuffin")
            invertika.set_quest_status(ch, quest_string, 2)
        else
            npc_message(npc, ch, invertika.get_random_element(
              "Wenn du mir keinen MacGuffin bringst, kommst du nicht rein!",
              "Bringe mir einen MacGuffin, dann lasse ich dich rein!",
              "Du findest einen MacGuffin in der Bolero Höhle. " ..
                "Bringe mir einen davon"))
        end
    elseif q_status == 2 then
        npc_message(npc, ch, invertika.get_random_element(
          "Wir bewachen die Tore der Stadt",
          "Gehe weiter. Du blockierst die Straße.",
          "Ohne uns Wachen, würde die Stadt im Chaos versinken!"))
    end
end

local function wache_trigger(ch, id)
    local quest_string = "burg_cedric_guard_macguffin"
    invertika.init_quest_status(ch, quest_string)
    local q_status = invertika.get_quest_status(ch, quest_string)
    
    if being_type(ch) == TYPE_CHARACTER then
        if chr_inv_count(ch, 40047) == 0 and q_status <= 1 then
            local x = posX(ch)
            chr_warp(ch, nil, x, 180 * TILESIZE + 16)
            if x < 102 * TILESIZE + 16 then
                being_say(wache_unten_links, "Bevor ich meinen MacGuffin nicht wiederhabe, kommst du hier nicht durch!")
            else
                being_say(wache_unten_rechts, "Bevor ich meinen MacGuffin nicht wiederhabe, kommst du hier nicht durch!")
            end
        end
    end
end

local function wache_cache_trigger(ch, id)
    invertika.init_quest_status(ch, "burg_cedric_guard_macguffin")
end

local function firework_round()
    local c = 1
    while c < 50 do
        spawn_effect()
        c = c + 1
    end

    local d = os.date("*t")
    local start = os.time{year=d.year, month=d.month, day=d.day,
                          hour=18, min=00, sec=0}
    if os.difftime(os.time(), start) < 15 * 60 then
        schedule_in(1, firework_round)
    end
end

local function spawn_effect()
    effect_create(math.random(0, 25),
                       math.random(44 * TILESIZE, 159 * TILESIZE),
                       math.random(77 * TILESIZE, 133 * TILESIZE))
end

local function cedric_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Ich bin Graf Cedric.",
      "Fühle dich in meiner Burg wie zu Hause."))
end

local function cedric_speech()
    local speech = {
      "Heute haben wir uns versammelt, um den Wiederaufbau der Burg Cedric zu feiern.",
      "Vor nicht allzu langer Zeit wurde unser gemeinsames Heim von einer Flutwelle überschwemmt.",
      "Wir mussten fliehen, um nicht zu ertrinken.",
      "Wir lebten in der Zeit als Bettler, Schnorrer und Diebe.",
      "Einige von uns sind gestorben oder wurden getötet.",
      "Sie werden uns aber immer in Erinnerung bleiben.",
      "Als wir hörten, dass sich das Wasser zurückzog, kamen wir hierhin zurück.",
      "Wir sahen, dass nur noch die Mauern der Burg standen.",
      "Aber durch unseren starken Gemeinschaftssinn konnten wir die Burg noch prächtiger und schöner wiederaufbauen, als sie jemals war.",
      "Ich danke euch, genießt das Feuerwerk."
    }

    if not cedric_speech_index then
       cedric_speech_index = 1
    end
    being_say(cedric, speech[cedric_speech_index])
    cedric_speech_index = cedric_speech_index + 1
    if cedric_speech_index <= #speech then
        schedule_in(5, cedric_speech)
    else
        cedric_speech_index = 1
    end
end

local function palastwache_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Wir bewachen den Palast Cedric´s.",
      "Im Haus hinter uns wohnt Cedric und seine Frau Ormylt"))
end

atinit(function()
    create_inter_map_warp_trigger(nil, 33, 43, 55) --- Intermap warp
    nethek.create_netheksaeule(103 * TILESIZE, 110 * TILESIZE + 16) ---Netheksäule

    sign_entrance = "Burg Cedric"
    sign.create_sign(104, 185, sign_entrance) --- Schild Burgeingang

    trigger_create(101 * TILESIZE, 176 * TILESIZE, 3 * TILESIZE, 3 * TILESIZE, wache_trigger, 1, true)
    ---trigger_create(101 * TILESIZE, 183 * TILESIZE, 3 * TILESIZE, 3 * TILESIZE, wache_cache_trigger, 1, true)

    diem = npc_create("Diem", 139, GENDER_UNSPECIFIED, 60 * TILESIZE + 16, 160 * TILESIZE + 16, diem_talk, npclib.walkaround_wide)
    invertika.create_npc_talk_random(diem,
      {"Kauft Leute! Kauft!",
      "Beste Waren! Hergestellt in den königlichen Schmieden!",
      "Sehen Sie! Dieses Schwert ist unzerbrechlich! ZACK. Oh...",
      "Kommen Sie meine Herren. Diese Waffen sind die Besten."})
      
    
    create_chris()

    npc_create("Estjdian", 120, GENDER_UNSPECIFIED, 156 * TILESIZE + 16, 160 * TILESIZE + 16, estjdian_talk, nil)

    npc_create("Palastwache", 26, GENDER_UNSPECIFIED, 58 * TILESIZE + 16, 100 * TILESIZE + 16, palastwache_talk, nil)
    npc_create("Palastwache", 26, GENDER_UNSPECIFIED, 61 * TILESIZE + 16, 100 * TILESIZE + 16, palastwache_talk, nil)

    --Bankwachen
    npc_create("Wache", 26, GENDER_UNSPECIFIED, 146 * TILESIZE + 16, 119 * TILESIZE + 16, wache_bank_talk, nil)
    npc_create("Wache", 26, GENDER_UNSPECIFIED, 149 * TILESIZE + 16, 119 * TILESIZE + 16, wache_bank_talk, nil)
    
    --Casinowache
    npc_create("Wache", 26, GENDER_UNSPECIFIED, 52 * TILESIZE + 16, 149 * TILESIZE + 16, wache_casino_talk, nil)

    --Außenwachen
    wache_unten_links = npc_create("Wache", 26, GENDER_UNSPECIFIED, 101 * TILESIZE + 16, 179 * TILESIZE + 16, wache_talk, nil) -- Wache Außentor
    wache_unten_rechts = npc_create("Wache", 26, GENDER_UNSPECIFIED, 103 * TILESIZE + 16, 179 * TILESIZE + 16, wache_talk, nil) -- Wache Außentor
    
    --Innentorwachen
    npc_create("Wache", 26, GENDER_UNSPECIFIED, 100 * TILESIZE + 16, 137 * TILESIZE + 16, wache_talk, nil) -- Wache Innentor
    npc_create("Wache", 26, GENDER_UNSPECIFIED, 104 * TILESIZE + 16, 137 * TILESIZE + 16, wache_talk, nil) -- Wache Innentor

    cedric = npc_create("Cedric", 39, GENDER_UNSPECIFIED, 81 * TILESIZE + 16, 97 * TILESIZE + 16, cedric_talk, nil)

    -- Cedric´s Rede
    --invertika.schedule_every_day(17, 59, 00, cedric_speech)

    -- Feuerwerk
    --invertika.schedule_every_day(18, 00, 00, firework_round)
end)
