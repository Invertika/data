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
 ---create_npc("Banker", 122, 180 * TILESIZE + 16, 160 * TILESIZE + 16, banker.banker_talk, nil) --- Banker (Debug)
 create_npc("Asam", 66, 76 * TILESIZE + 16, 27 * TILESIZE + 16, asam_talk, nil) -- Asam
 create_npc("Samos", 64, 59 * TILESIZE + 16, 25 * TILESIZE + 16, samos_talk, nil) -- Samos

end)

function asam_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Ich wohne hier.",
      "Serlphie Timlet ist eine schöne Stadt.",
      "Ich bin hier aufgewachsen.",
      "Es gab auch schon schwerere Zeiten."))
    do_npc_close(npc, ch)
end

function samos_talk(npc, ch)
    local quest_string = "selphi_timlet_samos_quest"
    invertika.init_quest_status(ch, quest_string)
    local get_qstatus = function() return invertika.get_quest_status(ch, quest_string) end
    local set_qstatus = function(x) invertika.set_quest_status(ch, quest_string, x) end

    do_message(npc, ch, invertika.get_random_element("Hol mich hier raus!",
      "Mein Vater hat mich hier eingeschlossen.",
      "Ich hab doch nichts getan!"))

    if get_qstatus() == 0 then
        do_message(npc, ch, "Vielleicht kannst du mir ein wenig Schokolode bringen? Mein Vater hat mich hier eingesperrt, aber mit Schokolade könnte ich es hier drin aushalten.")
        while true do
            local v = do_choice(npc, ch, "Na gut", "Nein, nix da. Schokolade ist schlecht für die Zähne und macht dick.")
            if v == 1 then
                do_message(npc, ch, "Bring mir aber mindestens 5 Tafeln! Schliesslich weiß ich nicht, wann ich wieder was kriege.")
                invertika.set_quest_status(ch, quest_string, 1)
                break
            elseif v == 2 then
                do_message(npc, ch, "Och komm schon... Du bist blöd.")
                break
            end
        end
    end
    if get_qstatus() == 1 then
        if mana.chr_inv_count(ch, 40035) > 4 then
            invertika.add_items(ch, 30009, -5, "Schokoladentafel")
            do_message(npc, ch, "Super! Danke! *mampf*")
            invertika.set_quest_status(ch, quest_string, 2)
        else
            do_message(npc, ch, "Mindestens 5 Tafeln Schokolade! Sonst habe ich hinterher nur noch mehr Hunger.")
        end
    elseif get_qstatus() == 2 then
        do_message(npc, ch, "Wie, du willst noch eine Belohnung für die Schokolade? Nix da!")
        invertika.set_quest_status(ch, quest_string, 3)
    elseif get_qstatus() == 3 then
        do_message(npc, ch, "Nein, das gebe ich nicht her! Verzieh dich!")
        invertika.set_quest_status(ch, quest_string, 4)
    elseif get_qstatus() == 4 then
        do_message(npc, ch, "Denk nicht mal dran, mir das Ding wegzunehmen! Ich mag meine Sonnenbrille. Die hat mir Papa zum Geburtstag geschenkt.")
        while true do
            local v = do_choice(npc, ch, "Na gut", "Ich hab dir die Schokolade besorgt, also gehört das mir *grabsch*")
            if v == 2 then
                do_message(npc, ch, "HEY! PAAAPAAAA! WÄÄÄÄH!")
                invertika.add_items(ch, 20023, 1, "Sonnebrille")
                invertika.set_quest_status(ch, quest_string, 5)
                break
            elseif v == 1 then
                break
            end
        end
    elseif get_qstatus() == 5 then
        do_message(npc, ch, invertika.get_random_element("Geh weg!",
          "Arschloch!",
          "Hau ab!",
          "*schnief*... *schluchz*...",
          "Mit dir rede ich nicht mehr!"))
    end
    
    do_npc_close(npc, ch)
end
