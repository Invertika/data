﻿----------------------------------------------------------------------------------
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


local function explosion()
    effect_create(5, 41 * TILESIZE + 16, 37 * TILESIZE + 16)
end

local function nalaf_talk(npc, ch)
    local quest_string = "narva_laboratory_nalaf_quest"
    invertika.init_quest_status(ch, quest_string)
    local function get_qstatus() return invertika.get_quest_status(ch, quest_string) end
    local function set_qstatus(x) invertika.set_quest_status(ch, quest_string, x) end

    if get_qstatus() == 0 then
        npc_message(npc, ch, "Willkommen in unserem Labor. Fass bitte nichts an.")
        while true do
            local v = npc_choice(npc, ch, "Kann ich irgendwie helfen?", "Auf Wiedersehen.")
            if v == 1 then
                npc_message(npc, ch, "Hm...")
                npc_message(npc, ch, "Wo du so fragst. Wir forschen an einem neuen Mittel. Alles höchst legal. Du brauchst keine Sorgen zu haben.")
                npc_message(npc, ch, "Aber wir benötigen für unsere Forschungen Überreste von Sandkriechern.")
                npc_message(npc, ch, "Die Überreste dieser Kreatur sind allerdings schwer zu bekommen, da sie nur relativ selten auftritt.")
                npc_message(npc, ch, "Wenn du dir ein paar Münzen dazu verdienen willst kannst du ein paar dieser Körper besorgen.")
                while true do
                    local v2 = npc_choice(npc, ch, "Mach ich.", "Jetzt nicht.")
                    if v2 == 1 then
                        set_qstatus(1)
                        npc_message(npc, ch, "Gut. Viel Glück bei der Jagd. Diese Viecher sind ziemlich schnell.")
                        break
                    elseif v2 == 2 then
                        break
                    end
                end
                break
            elseif v == 2 then
                break
            end
        end
    elseif get_qstatus() == 1 then
        local count = chr_inv_count(ch, 40043)
        if count > 0 then
            npc_message(npc, ch, "Ah. Du hast Sandkriecherüberreste... Überlässt du sie uns für 200 Aki das Stück?")
            while true do
                local v = npc_choice(npc, ch, "Verkaufen.", "Behalten.")
                if v == 1 then
                    -- Verkauf der Items in letzter Sekunde unterbinden
                    count = chr_inv_count(ch, 40043)
                    set_qstatus(2)
                    invertika.add_items(ch, 40043, -count, "Überreste eines Sandkriechers")
                    invertika.add_money(ch, count * 200)
                    npc_message(npc, ch, "Vielen Dank. Erzähl niemandem, dass du uns diese Stoffe gebracht hast. Unsere Forschungen sind hoch geheim.")
                    break
                elseif v == 2 then
                    break
                end
            end
        else
            npc_message(npc, ch, invertika.get_random_element("Wenn du mir ein Paar Sandkriecherüberreste bringst geb ich dir ein paar Münzen.", "Wolltest du nicht ein paar Sandkriecher für unsere Forschungen jagen?"))
        end
    elseif get_qstatus() == 2 then
        npc_message(npc, ch, "Zur Zeit habe ich keine weiteren Aufgaben für dich.")
    end

end


local function warves_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Vorsicht mit den Reagenzgläsern!",
      "Wir experimentieren hier mit neuen Mitteln.")) -- TODO: Mehr Varianten
end

atinit(function()
    schedule_every(5, explosion)
    nalaf = npc_create("Nalaf", 11, GENDER_UNSPECIFIED, 41 * TILESIZE + 16, 35 * TILESIZE + 16, nalaf_talk, nil)
    invertika.create_npc_talk_random(nalaf,
      {"Hm. das scheint nicht zu klappen...",
      "Wäre auch ein Wunder wenn es funktioniert hätte.",
      "Achtung! Bitte einen Schritt zurücktreten!"}) --TODO: Mehr Auswahl
    warves = npc_create("Warves", 7, GENDER_UNSPECIFIED, 45 * TILESIZE + 16, 38 * TILESIZE + 16, warves_talk, nil)
    invertika.create_npc_talk_random(warves,
      {"Probier das hier mal.",
      "Ich probier mal eine neue Mischung.",
      "Hmm..."}) -- TODO: Mehr Auswahl

end)
