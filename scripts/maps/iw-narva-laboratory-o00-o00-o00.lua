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

atinit(function()
    schedule_every(5, explosion)
    nalaf = create_npc("Nalaf", 11, 41 * TILESIZE + 16, 35 * TILESIZE + 16, nalaf_talk, invertika.npc_talk_random)
    invertika.create_npc_talk_random(nalaf,
      {"Hm. das scheint nicht zu klappen...",
      "Wäre auch ein Wunder wenn es funktioniert hätte.",
      "Achtung! Bitte einen Schritt zurücktreten!"}) --TODO: Mehr Auswahl
    warves = create_npc("Warves", 7, 45 * TILESIZE + 16, 38 * TILESIZE + 16, warves_talk, invertika.npc_talk_random)
    invertika.create_npc_talk_random(warves,
      {"Probier das hier mal.",
      "Ich probier mal eine neue Mischung.",
      "Hmm..."}) -- TODO: Mehr Auswahl

end)

function explosion()
    mana.effect_create(5, 41 * TILESIZE + 16, 37 * TILESIZE + 16)
end

function nalaf_talk(npc, ch)
    local quest_string = "narva_laboratory_nalaf_quest"
    invertika.init_quest_status(ch, quest_string)
    function get_qstatus() return invertika.get_quest_status(ch, quest_string) end
    function set_qstatus(x) invertika.set_quest_status(ch, quest_string, x) end

    if get_qstatus() == 0 then
        do_message(npc, ch, "Willkommen in unserem Labor. Fass bitte nichts an.")
        while true do
            local v = do_choice(npc, ch, "Kann ich irgendwie helfen?", "Auf Wiedersehen.")
            if v == 1 then
                do_message(npc, ch, "Hm...")
                do_message(npc, ch, "Wo du so fragst. Wir forschen an einem neuen Mittel. Alles höchst legal. Du brauchst keine Sorgen zu haben.")
                do_message(npc, ch, "Aber wir benötigen für unsere Forschungen Überreste von Sandkriechern.")
                do_message(npc, ch, "Die Überreste dieser Kreatur sind allerdings schwer zu bekommen, da sie nur relativ selten auftritt.")
                do_message(npc, ch, "Wenn du dir ein paar Münzen dazu verdienen willst, könntest du ein paar dieser Körper besorgen.")
                while true do
                    local v2 = do_choice(npc, ch, "Mach ich.", "Jetzt nicht.")
                    if v2 == 1 then
                        set_qstatus(1)
                        do_message(npc, ch, "Gut. Viel Glück bei der Jagd. Diese Viecher sind ziemlich schnell.")
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
        local count = mana.chr_inv_count(ch, 40043)
        if count > 0 then
            do_message(npc, ch, "Ah. Du hast Sandkriecherüberreste... Überlässt du sie uns für 200 Aki das Stück?")
            while true do
                local v = do_choice(npc, ch, "Verkaufen.", "Behalten.")
                if v == 1 then
                    -- Verkauf der Items in letzter Sekunde unterbinden
                    count = mana.chr_inv_count(ch, 40043)
                    set_qstatus(2)
                    invertika.add_items(ch, 40043, -count, "Überreste eines Sandkriechers")
                    invertika.add_money(ch, count * 200)
                    do_message(npc, ch, "Vielen Dank. Erzähl niemandem, dass du uns diese Stoffe gebracht hast. Unsere Forschungen sind hoch geheim.")
                    break
                elseif v == 2 then
                    break
                end
            end
        else
            do_message(npc, ch, invertika.get_random_element("Wenn du mir ein Paar Sandkriecherüberreste bringst geb ich dir ein paar Münzen.", "Wolltest du nicht ein paar Sandkriecher für unsere Forschungen jagen?"))
        end
    elseif get_qstatus() == 2 then
        do_message(npc, ch, "Zur Zeit habe ich keine weiteren Aufgaben für dich.")
    end

    do_npc_close(npc, ch)
end


function warves_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element(
      "Vorsicht mit den Reagenzgläsern!",
      "Wir experimentieren hier mit neuen Mitteln.")) -- TODO: Mehr Varianten
    do_npc_close(npc, ch)
end
