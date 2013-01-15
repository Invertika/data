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


local function tresor_talk(npc, ch)
    -- quest init
        invertika.init_quest_status(ch, "selphi_timlet_flat03_safe")

    -- quest get/set functions
    local function get_qstatus() return invertika.get_quest_status(ch, "selphi_timlet_flat03_safe") end
    local function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_flat03_safe", x) end

    if get_qstatus()==0 then
      npc_message(npc, ch, "Hinter dem Bild befindet sich etwas. Mal schauen. Oh das ist ein Tresor. Mmm da schaue ich mal hinein. Bloß wie bekomme ich ihn auf?")

      while true do
            local v = npc_choice(npc, ch, "Dynamit benutzen", "Nett anklopfen", "Zweimal links, einmal rechts, dreimal diagonal...", "42", "Die Zahlenkombination auf der Rückseite des Bildes benutzen")

          if v == 1 then
            local countDynamite = chr_inv_count(ch, 40025)
            if countDynamite == 0 then
              npc_message(npc, ch, "Ähm ich habe gar kein Dynamit.")
            else
              invertika.add_items(ch, 40025, -1, "Dynamit")
              effect_create(151, 68 * TILESIZE + 16, 18 * TILESIZE + 16)
              being_damage(ch, 200, 100, 100, 0, 0)
              set_qstatus(2)
            end

            break
          elseif v == 2 then
            npc_message(npc, ch, "Nein, bin gerade beschäftigt. Inventur. Bitte kommen sie während unserer Servicezeiten nochmal.")
            break
          elseif v == 3 then
            npc_message(npc, ch, "Da wir uns zu jeder Zeit, gleichzeitig im Universum befinden und alles Wissen erlangen das es gibt, wissen wir das diese Option die falsche war.")
            break
          elseif v == 4 then
            npc_message(npc, ch, "Wie jetzt? Das kann nicht dein Ernst sein.")
            break
          elseif v == 5 then
            npc_message(npc, ch, "Ein Zettel. Mal sehen was draufsteht: Diebstahl lohnt sich nicht.")
            set_qstatus(1)
            break
          end
      end
    elseif get_qstatus()==1 then
      npc_message(npc, ch, "Der Tresor ist offen und leer.")
    elseif get_qstatus()==2 then
      npc_message(npc, ch, "Der Tresor ist durch die Explosion verzogen und lässt sich nicht mehr öffnen.")
    end

end

local function ceech_talk(npc, ch)
    if invertika.get_quest_status(ch, "roststock_icero_quest") == 4 then
        npc_message(npc, ch, "Du siehst du aus als wolltest du etwas fragen?")
        while true do
            local v = npc_choice(npc, ch, "Icero braucht einen Psychiater.", "Nein. Nix.")
            if v == 1 then
                npc_message(npc, ch, "Icero? Dieser interessante Fall in Roststock?")
                npc_message(npc, ch, "Ich arbeite gerne mit Leuten die einen an der Klatsche haben.")
                npc_message(npc, ch, "Ich werde in nächster Zeit mal bei ihm vorbei kommen.")
                invertika.set_quest_status(ch, "roststock_icero_quest", 5)
                break
            elseif v == 2 then
                npc_message(npc, ch, "Dann lass mich arbeiten!")
                break
            end
        end
        return
    end

    local quest_string = "selphi_timlet_ceech_quest"
    invertika.init_quest_status(ch, quest_string)
    local get_qstatus = function() return invertika.get_quest_status(ch, quest_string) end
    local set_qstatus = function(x) invertika.set_quest_status(ch, quest_string, x) end

    if get_qstatus() == 0 then
        npc_message(npc, ch, "Hu. Ich war so in meine Arbeiten vertieft, dass ich dich nicht kommen sehen habe.")
        npc_message(npc, ch, "Hättest du Lust diese Klageschrift zur Rezeption im Hotel zu bringen? Ich kann es nicht zulassen, dass die einfach die Kokusnüsse ungesichert von den Bäumen fallen lassen! Es könnte sich jemand ernsthaft verletzen.")
        while true do
            local v = npc_choice(npc, ch, "Ja.", "Nein.")
            if v == 1 then
                set_qstatus(1)
                invertika.add_items(ch, 40035, 1, "Brief an die Rezeption")
                npc_message(npc, ch, "Sag mir Bescheid wenn du ihn vorbei gebracht hast.")
                break
            elseif v == 2 then
                npc_message(npc, ch, "Dann halt nicht.")
                set_qstatus(-1)
                break
            end
        end
    elseif get_qstatus() == 1 then
        npc_message(npc, ch, "Du sollst die Klageschrift in das Hotel bringen!")
    elseif get_qstatus() == 2 then
        if chr_inv_count(ch, 40035) == 0 then
            npc_message(npc, ch, "Hast du den Brief abgegeben?")
            while true do
                local v = npc_choice(npc, ch, "Ja.", "Nein. Ich habe ihn verloren.")
                if v == 2 then
                    npc_message(npc, ch, "Du hast ihn verloren? Unzuverlässiger Bengel!")
                    set_qstatus(-1)
                    break
                elseif v == 1 then
                    npc_message(npc, ch, "Hier. nimm diese Kokosnuss als Belohnung. Bald habe ich Anrecht auf die Kokosnuss Ernte!")
                    invertika.add_items(ch, 30026, 3, "Kokosnuss")
                    set_qstatus(3)
                    invertika.set_quest_status(ch, "selphi_timlet_rezeptionist_quest", -1)
                    break
                end
            end
        else
            npc_message(npc, ch, "Was machst du noch hier? Du solltest doch den Brief wegbringen!")
        end
    elseif get_qstatus() == 3 then
        npc_message(npc, ch, "Jetzt muss ich arbeiten.")
    elseif get_qstatus() == -1 then
        npc_message(npc, ch, invertika.get_random_element("Lass mich arbeiten!",
        "Ich habe zu tun.",
        "Jetzt nicht.",
        "Schhhhh.",
        "Hör auf zu stören!"))
    end
end

atinit(function()
 npc_create("...", 1, GENDER_UNSPECIFIED, 68 * TILESIZE + 16, 18 * TILESIZE + 16, tresor_talk, nil) --- Tresor
 npc_create("Ceech", 54, GENDER_UNSPECIFIED, 38 * TILESIZE + 16, 22 * TILESIZE + 16, ceech_talk, nil) --- Ceech
end)
