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
require "scripts/libs/barber"
require "scripts/libs/invertika"

atinit(function()
    ---create_npc("Banker", 122, 180 * TILESIZE + 16, 160 * TILESIZE + 16, banker.banker_talk, nil) --- Banker (Debug)
    create_npc("Rocer", 60, 42 * TILESIZE + 16, 31 * TILESIZE + 16, rocer_talk, nil) -- Rocer (2. Zwilling)
end)


function rocer_talk(npc, ch)
    local questname = "twin_house_quest"
    invertika.init_quest_status(ch, questname)
    function get_qstatus() return invertika.get_quest_status(ch, questname) end
    function set_qstatus(x) invertika.set_quest_status(ch, questname, x) end

    if get_qstatus() == 0 then
        do_message(npc, ch, "Oh ich habe so einen grossen Kummer. Mein Bruder hat mich verraten und dann ...")
        do_message(npc, ch, "Ich bin so traurig, wegen meinem Bruder kann ich nicht weg. Ich muss auf das Haus aufpassen! Dabei will ich doch um die Hand von Imangi anhalten")
        while true do
            local v = do_choice(npc, ch, "Kann ich irgendwie helfen?", "Auf Wiedersehen!")
            if v == 1 then
                do_message(npc, ch, "Hm...")
                do_message(npc, ch, "Komm mal näher. Mein Bruder darf das nich hören.")
                do_message(npc, ch, "Er ist eifersüchtig auf mich.")
                do_message(npc, ch, "Ich liebe ein Mädchen namens Imangi.")
                do_message(npc, ch, "Sie klopfte einst an unsere Tür.")
                do_message(npc, ch, "Damals lebte ich noch mit meinem Bruder in dem gleichen Haus.")
                do_message(npc, ch, "Ich habe mich sofort in sie verliebt.")
                do_message(npc, ch, "Doch mein Bruder war neidisch auf mich.")
                do_message(npc, ch, "Deswegen leben wir nun zerstritten.")
                do_message(npc, ch, "Doch ich habe in aller Heimlichkeit einen Ring schmieden lassen.")
                do_message(npc, ch, "Ich will ihn ihr schenken. Allerdings weiß ich nicht wie ich ihn ihr unbemerkt von meinem Bruder geben soll.")
                while true do
                    local v2 = do_choice(npc, ch, "Hm...", "Ich könnte ihn zu ihr bringen, wenn ihr ihn mir anvertraut.")
                    if v2 == 1 then
                        do_message(npc, ch, "Ich belästige dich hier nur mit meinen Problemen...")
                        break
                    elseif v2 == 2 then
                        do_message(npc, ch, "*Schweigen")
                        do_message(npc, ch, "Gut ich gebe dir den Ring. Aber wenn du ihn nicht ablieferst gehe ich dir an den Kragen! Verstanden?")
                        set_qstatus(3)
                        invertika.add_items(ch, 20019, 1, "Imangis's Verlobungsring")
                        do_message(npc, ch, "Möge Invertika dich behüten!")
                        break
                    end
                end
                break
            elseif v == 2 then
                break
            end
        end
        
    elseif get_qstatus() == 1 then -- Quest beim ersten Zwilling angenommen.
        do_message(npc, ch, "Die Wände sind dünn hier! Ich habe gehört was du mit meinem Zwillingsbruder besprochen hast!")
        do_message(npc, ch, "Verlasse dieses Haus! Ich will dich hier nicht mehr sehen!")
    elseif get_qstatus() == 2 then -- Quest beim ersten Zwilling ausgeführt.
        do_message(npc, ch, "Die Wände sind dünn hier! Ich habe gehört was du mit meinem Zwillingsbruder besprochen hast!")
        do_message(npc, ch, "Verlasse dieses Haus! Ich will dich hier nicht mehr sehen!")
    elseif get_qstatus() == 3 then -- Quest beim zweiten Zwilling angenommen.
        if mana.chr_inv_count(ch, 20019) > 0 then
            do_message(npc, ch, "Bringe ihr den Ring!")
        else
            do_message(npc, ch, "DU VERLOGENES SCHWEIN! DU SOLLTEST DEN RING MEINER VERLIEBTEN BRINGEN!")
            mana.being_damage(ch, 100000, 1, 999999, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
        end
    elseif get_qstatus() == 4 then -- Quest beim zeiten Zwilling ausgeführt.
        do_message(npc, ch, "Vielen Dank, dass du ihr den Ring gebracht hast. Ich werde bald einmal in die Stadt gehen und sie besuchen.")
        do_message(npc, ch, "Mal sehen ob ich noch etwas für dich in dieser Kiste habe...")
        do_message(npc, ch, "Hier nimm dieses zerbrochene Kettenhemd. Ich habe es einst in der Wüste gefunden. Die Terraniten haben von dem Besitzer nicht viel übrig gelassen.")
        invertika.add_items(ch, 40028, 1, "Zerstörtes Kettenhemd")
        set_qstatus(5)
    elseif get_qstatus() == 5 then -- Allgemein
        do_message(npc, ch, invertika.get_random_element("Mein Bruder hat mich betrogen!",
          "Wir hassen uns seit wir auf der Welt sind!",
          "Ich bin als erstes geboren!"))
    end
    do_npc_close(npc, ch)
end
