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
 create_npc("Haitan", 67, 62 * TILESIZE + 16, 29 * TILESIZE + 16, haitan_talk, nil) --- Haitan
end)

function haitan_talk(npc, ch)
    if (invertika.get_quest_status(ch, "selphi_timlet_haitan_scorpions") == nil) then
        do_message(npc, ch, "Die Skorpione im Keller nehmen inzwischen überhand. Könntest du die Plage für mich vielleicht ein wenig eindämmen?")
        local v = do_choice(npc, ch, "Aber natürlich!", "Die sind doch bestimmt gefährlich, nein!", "Aber ich bin Sternbild Skorpion! Die zu töten bringt mir Unglück!")
        if v == 1 then
            --- Questvariable anpassen
            invertika.set_quest_status(ch, "selphi_timlet_haitan_scorpions", "1")
            do_message(npc, ch, "Sammle ihre Stachel als Beweis. Solche Skorpione habe ich noch nirgendwo sonst gesehen.")
        else
            do_message(npc, ch, invertika.get_random_element("Na dann halt nicht...",
                "Und wie soll ich dann bitte schön an meine Vorräte kommen? Die Jugend von heute...",
                "Vielleicht überlegst du es dir ja noch anders",
                "Ich hätte dich auch dafür belohnt, na ja...",
                "...",
                "Dann muss ich wohl jemand anderen fragen"))
        end
    elseif (invertika.get_quest_status(ch, "selphi_timlet_haitan_scorpions")=="1") then
        local count = mana.chr_inv_count(ch, 40016)
        if count < 30 then
            --- Noch nicht genug umgebracht
            do_message(npc, ch, invertika.get_random_element("Worauf wartest du? Los, bring die Skorpione um!"))
        else
            --- Genug umgebracht
            invertika.add_items(ch, 40016, -count, "Kellerskorpionstachel")
            do_message(npc, ch, "Ich glaube nicht, dass du sie alle umgebracht kriegst. Aber das ist schon mal eine große Hilfe. Hier hast du etwas Schokolade als Belohnung.")
            --- Belohnung ausgeben
            if count > 100 then
                invertika.add_items(ch, 30014, math.floor(count/50), "riesen Schokolade")
            end
            invertika.add_items(ch, 30009, math.floor(count/2), "Schokolade")
            --- Questvariable anpassen
            invertika.set_quest_status(ch, "selphi_timlet_haitan_scorpions", 2)
        end
    else
        do_message(npc, ch, invertika.get_random_element("Vielen Dank für deine Hilfe",
            "Das war echt nett von dir",
            "Du darfst gerne mehr töten, aber leider kann ich dir nichts mehr dafür geben",
            "Leider sind immer noch Skorpione da unten..."))
    end
    do_npc_close(npc, ch)
end
