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
require "scripts/libs/nethek"
require "scripts/libs/sign"
require "scripts/libs/invertika"
require "scripts/libs/datetime"

require "scripts/libs/warp"


-- Silvester
local function fireworker_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Willst du ein wenig Feuerwerk sehen?",
      "Willst du ein kleines Feuerwerk sehen?",
      "Möchtest du ein kleines Feuerwerk sehen?",
      "Möchtest du ein wenig Feuerwerk sehen?",
      "Möchtest du dir ein kleines Feuerwerk anschauen?",
      "Möchtest du dir ein wenig Feuerwerk anschauen?",
      "Willst du ein kleines Feuerwerk betrachten?",
      "Auf deinen Wunsch hin, beschwöre ich den Gott des Feuerwerkes, und dieser wird es mächtig krachen lassen!"))
    local answer = npc_choice(npc, ch, "Juhuu! Feuerwerk!", "Nee, danke.")
    if answer == 1 then
        local x = posX(npc)
        local y = posY(npc)
        for c = 0, 25 do
            schedule_in (c, function()
            effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
            effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
            effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
            effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
            effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
            effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
            end)
        end
    end
end

local function egroe_talk(npc, ch)
    --TODO mehr Auswahl
    npc_trade(npc, ch, false, {
      {10001, 20, 19},
      {30037, 5, 2500},
      {10013, 30, 159},
      {10002, 30, 1000},
      {10009, 30, 1690},
      {20001, 30, 250},
      {20002, 30, 250},
      {20011, 30, 250},
      {20012, 30, 250},
      {20013, 30, 250}
    })
end

local function thinaima_talk(npc, ch)
    --TODO mehr Auswahl
    npc_trade(npc, ch, false, {
      {10001, 20, 19},
      {10013, 30, 140},
      {10002, 30, 1000},
      {10009, 30, 1690},
      {20014, 30, 250},
      {20015, 30, 250},
      {20016, 30, 250},
      {20017, 30, 250},
      {20018, 30, 250},
      {20009, 30, 500} 
    })
end

local function onurn_talk(npc, ch)
    local queststring = "nelaro_water_quest"
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)
    
    npc_message(npc, ch, "...")
    while true do   
        local v = npc_choice(npc, ch, 
                    "Wie ist das Wetter?",
                    "Wie viel Uhr ist es?",
                    "Tschüß.")
        if v == 1 and quest_var == 2 then
            npc_message(npc, ch, "Die bekommen das Wasser von einem Lieferanten aus dem Norden.")
            --Set Quest
            invertika.set_quest_status(ch, queststring, 3)
        elseif v == 1 and quest_var ~= 2 then
            npc_message(npc, ch, invertika.get_random_element(
              "Es ist sonnig.",
              "Es ist stürmisch.",
              "Dort oben ist eine Wolke. Vielleicht fängt es ja zu regnen an."))
            break
        elseif v == 2 then
            npc_message(npc, ch, string.format("Es ist %s Uhr.", datetime.get_current_time())) --Uhrzeit Ausgeben
            break
        else
            npc_message(npc, ch, "...")
            break
        end
    end
end

atinit(function()
    create_inter_map_warp_trigger(58, 70, 60, 4) --- Intermap warp
    nethek.create_netheksaeule(130 * TILESIZE, 151 * TILESIZE + 16) --- Netheksäule

    sign_descr = "Nelaro"
    sign.create_sign(69, 110, sign_descr) --- Schild Stadtmitte
    
    egroe = npc_create("Egroe", 34, GENDER_UNSPECIFIED, 119 * TILESIZE + 16, 153 * TILESIZE + 16, egroe_talk, nil)
    invertika.create_npc_talk_random(egroe,
      {"Qualitätswaren zum billigsten Preis.",
      "Wasser nur 2500 Aki pro Liter!"})
    thinaima = npc_create("Thinaima", 18, GENDER_UNSPECIFIED, 64 * TILESIZE + 16, 112 * TILESIZE + 16, thinaima_talk, nil)
    invertika.create_npc_talk_random(thinaima,
      {"Waffen, handgefertigte Waffen!",
      "Wasser zum billigsten Preis in der Region!",
      "Edelste Waren aus dem Norden!"})
    
    --TODO Change Sprite ID
    onurn = npc_create("Onurn", 2, GENDER_UNSPECIFIED, 91 * TILESIZE + 16, 98 * TILESIZE + 16, onurn_talk, nil)
    invertika.create_npc_talk_random(onurn,
      {"Wasser ist zum Waschen da, auch die Feuerwehr, braucht das Wasser sehr.",
      "Wasser ist zum Waschen da, auch zum Zähneputzen, kann man es benutzen.",
      "Die Fleischlackiererei ist auf der anderen Seite.",
      "˙ɟǝıɥɔs ʇsı ɹǝp 'ʇsǝıl sɐp ɹǝʍ"})
      
    ---Neujahr
    ---npc_create("Feuerwerker", 83, GENDER_UNSPECIFIED, 177 * TILESIZE + 16, 185 * TILESIZE + 16, fireworker_talk, npclib.walkaround_small)
end)
