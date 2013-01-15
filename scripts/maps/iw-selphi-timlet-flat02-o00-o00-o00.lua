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


local function mercol_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Ich wohne hier.",
      "Selphi Timlet ist eine schöne Stadt.",
      "Ich bin hier aufgewachsen.",
      "Es gab auch schon schwerere Zeiten."))
end

local function samos_talk(npc, ch)
    local quest_string = "selphi_timlet_samos_quest"
    invertika.init_quest_status(ch, quest_string)
    local get_qstatus = function() return invertika.get_quest_status(ch, quest_string) end
    local set_qstatus = function(x) invertika.set_quest_status(ch, quest_string, x) end

    if get_qstatus() == 0 then
        npc_message(npc, ch, invertika.get_random_element("Hol mich hier raus!",
          "Mein Vater hat mich hier eingeschlossen.",
          "Ich hab doch nichts getan!"))
        npc_message(npc, ch, "Vielleicht kannst du mir ein wenig Schokolode bringen? Mein Vater hat mich hier eingesperrt, aber mit Schokolade könnte ich es hier drin aushalten.")
        while true do
            local v = npc_choice(npc, ch, "Na gut", "Nein, nix da. Schokolade ist schlecht für die Zähne und macht dick.")
            if v == 1 then
                npc_message(npc, ch, "Bring mir aber mindestens 5 Tafeln! Schliesslich weiß ich nicht, wann ich wieder was kriege.")
                invertika.set_quest_status(ch, quest_string, 1)
                break
            elseif v == 2 then
                npc_message(npc, ch, "Och komm schon... Du bist blöd.")
                break
            end
        end
    elseif get_qstatus() == 1 then
        if chr_inv_count(ch, 30009) > 4 then
            invertika.add_items(ch, 30009, -5, "Schokoladentafel")
            npc_message(npc, ch, "Super! Danke! *mampf*")
            invertika.set_quest_status(ch, quest_string, 2)
        else
            npc_message(npc, ch, "Mindestens 5 Tafeln Schokolade! Sonst habe ich hinterher nur noch mehr Hunger.")
        end
    elseif get_qstatus() == 2 then
        npc_message(npc, ch, "Wie, du willst noch eine Belohnung für die Schokolade? Nix da!")
        invertika.set_quest_status(ch, quest_string, 3)
    elseif get_qstatus() == 3 then
        npc_message(npc, ch, "Nein, das gebe ich nicht her! Verzieh dich!")
        invertika.set_quest_status(ch, quest_string, 4)
    elseif get_qstatus() == 4 then
        npc_message(npc, ch, "Denk nicht mal dran, mir das Ding wegzunehmen! Ich mag meine Sonnenbrille. Die hat mir Papa zum Geburtstag geschenkt.")
        while true do
            local v = npc_choice(npc, ch, "Na gut", "Ich hab dir die Schokolade besorgt, also gehört das mir *grabsch*")
            if v == 2 then
                npc_message(npc, ch, "HEY! PAAAPAAAA! WÄÄÄÄH!")
                invertika.add_items(ch, 20023, 1, "Sonnebrille")
                invertika.set_quest_status(ch, quest_string, 5)
                break
            elseif v == 1 then
                break
            end
        end
    elseif get_qstatus() == 5 then
        npc_message(npc, ch, invertika.get_random_element("Geh weg!",
          "Arschloch!",
          "Hau ab!",
          "*schnief*... *schluchz*...",
          "Mit dir rede ich nicht mehr!"))
    end
    
end

atinit(function()
 ---npc_create("Banker", 122, GENDER_UNSPECIFIED, 180 * TILESIZE + 16, 160 * TILESIZE + 16, banker.banker_talk, nil) --- Banker (Debug)
 npc_create("Mercol", 66, GENDER_UNSPECIFIED, 76 * TILESIZE + 16, 27 * TILESIZE + 16, mercol_talk, nil) -- Mercol
 npc_create("Samos", 64, GENDER_UNSPECIFIED, 59 * TILESIZE + 16, 25 * TILESIZE + 16, samos_talk, nil) -- Samos

end)
