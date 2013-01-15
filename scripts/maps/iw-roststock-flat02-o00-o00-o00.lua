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


local function icero_talk(npc, ch)
    local quest_string = "roststock_icero_quest"
    invertika.init_quest_status(ch, quest_string)
    local get_qstatus = function() return invertika.get_quest_status(ch, quest_string) end
    local set_qstatus = function(x) invertika.set_quest_status(ch, quest_string, x) end

    if get_qstatus() == 0 then
        npc_message(npc, ch, invertika.get_random_element(
          "Es hat doch alles keinen Sinn mehr.",
          "Ich habe keine Lust mehr.",
          "*Gääääähn*",
          "Hier ist nix los.",
          "zZzzzzz... zZzzzzz... Was? Hast du was gesagt?",
          "Ich glaube ich geh schlafen..."))
        set_qstatus(1)
    elseif get_qstatus() == 1 then
        npc_message(npc, ch, "Inspirin! Inspirin! Bring mir Inspirin!")
        if chr_inv_count(ch, 30015) > 0 then
            npc_message(npc, ch, "Gib mir dein Inspirin! Bitte!")
            while true do
                local v = npc_choice(npc, ch,
                  "Hier. Nimm.",
                  "Ich hab keine.")
                if v == 1 then
                    invertika.add_items(ch, 30015, -1, "Inspirin")
                    set_qstatus(2)
                    npc_message(npc, ch, "*schluckt die Tablette hastig*")
                    npc_message(npc, ch, "*atmet tief durch*")
                    npc_message(npc, ch, "Danke!")
                    break
                elseif v == 2 then
                    npc_message(npc, ch, "*schaut wild umher*")
                    break
                end
            end
        end
    elseif get_qstatus() == 2 then
        npc_message(npc, ch, "Hast du mal ein Bier?")
        if chr_inv_count(ch, 30006) > 0 then
            while true do
                local v = npc_choice(npc, ch,
                  "Ihm ein Bier geben.",
                  "Das Bier behalten.")
                if v == 1 then
                    invertika.add_items(ch, 30006, -1, "Bier")
                    npc_message(npc, ch,
                      "Danke. Hier, ich hab noch ein paar alte Tabletten. Ich teste die zur Zeit.")
                    invertika.add_items(ch, 30017, 1, "Inspirin Megaplus")
                    set_qstatus(3)
                    break
                elseif v == 2 then
                    break
                end
            end
        end
    elseif get_qstatus() == 3 then
        npc_message(npc, ch, "Im Moment fühle ich mich besser.")
        npc_message(npc, ch, "Ich muss dringend mal wieder zum Psychiater.")
        while true do
            local v = npc_choice(npc, ch, 
              "Soll ich einen für dich suchen?",
              "Aha. Dann mal auf Wiedersehen...")
            if v == 1 then
                npc_message(npc, ch, "Ich war mal bei einem in Selphi Timlet. Wenn du herausfindest wer das war wäre ich glücklich.")
                set_qstatus(4)
                break
            elseif v == 2 then
                break
            end
        end
    elseif get_qstatus() == 4 then
        npc_message(npc, ch, "Der Psychiater wohnte in Selphi Timlet. Kannst du ihn suchen?")
    elseif get_qstatus() == 5 then
        npc_message(npc, ch, "Ich habe es schon gehört; Ceech will mal vorbei kommen.")
        npc_message(npc, ch, "Danke für deine Hilfe!")
        npc_message(npc, ch, "Nimm diese Tabletten. Ich brauche sie jetzt nicht mehr.")
        invertika.add_items(ch, 30017, 15, "Inspirin Megaplus")
        invertika.add_items(ch, 30003, 15, "Nogatch Hemlock")
        set_qstatus(6)
    elseif get_qstatus() == 6 then
        npc_message(npc, ch, invertika.get_random_element(
          "Es ist hart sich wieder an das Leben zu gewöhnen.",
          "Ab und zu nehme ich noch eine Tablette.",
          "Ich versuche mich zu bessern."))
    end
end

atinit(function()
    ---npc_create("Banker", 122, GENDER_UNSPECIFIED, 180 * TILESIZE + 16, 160 * TILESIZE + 16, banker.banker_talk, nil) --- Banker (Debug)
    npc_create("Icero", 80, GENDER_UNSPECIFIED, 29 * TILESIZE + 16, 29 * TILESIZE + 16, icero_talk, nil) --- Icero
end)
