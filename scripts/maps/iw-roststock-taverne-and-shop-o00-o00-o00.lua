----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                               --
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
 create_npc("Björn", 64, 75 * TILESIZE + 16, 24 * TILESIZE + 16, bjoern_talk, nil) --- Banker (Debug)
 create_npc("Rodhonu", 51, 43 * TILESIZE + 16, 34 * TILESIZE + 16, rodhonu_talk, nil) --- Rodhonu (Waffenschmied?)
 create_npc("Iaugh", 21, 93 * TILESIZE + 16, 34 * TILESIZE + 16, iaugh_talk, nil) --- Iaugh

end)

function bjoern_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Velera sucht mich? Einen Schluck trinke ich aber noch.",
	  "Lustig hier, oder?",
	  "Du möchtest auch was trinken, dann ab zum Barmann!",
	  "Prost. Wer? Velera? Joah meine Freundin.",
	  "Ja schon wieder ein Sandsturm. Jeden Tag einer...",
	  "Willkommen in Roststock. Trink doch was mit.")) 
	 do_npc_close(npc, ch)
end

function rodhonu_talk(npc, ch)
    if mana.chr_inv_count(ch, 40028) > 0 then
        do_message(npc, ch, "Kann ich etwas für dich tun?")
        while true do
            local v = do_choice(npc, ch, "Ich habe hier ein zerbrochenes Kettenhemd. Kannst du das reparien?", "Nein. Danke.")
            if v == 1 then
                do_message(npc, ch, "Hm... Lass mal sehen.")
                do_message(npc, ch, "Das sieht komplizierter aus als es ist.")
                do_message(npc, ch, "Für 500 Aki kann ich dir das reparieren.")
                while true do
                    local v2 = do_choice(npc, ch, "Hier hast du 500 Aki.", "Hm. Vielleicht später.")
                    if v2 == 1 then
                        if mana.chr_money(ch) >= 500 then
                            invertika.add_money(ch, -500)
                            invertika.add_items(ch, 40028, -1, "zerstörtes Kettenhemd")
                            invertika.add_items(ch, 20020, 1, "Kettenhemd")
                            do_message(npc, ch, "Bitte sehr.")
                        else
                            do_message(npc, ch, "Du hast nicht genügend Geld.")
                        end
                        break
                    elseif v2 == 2 then
                        break
                    end
                end
                break
            elseif v == 2 then
                do_message(npc, ch, "Auf Wiedersehen.")
                break
            end
        end
    else
        do_message(npc, ch, invertika.get_random_element(
          "Ich wäre gerne mal ein Waffenschmied. Aber keiner will es mir zeigen wie es geht.",
          "Ich kann gut mit Metallen umgehen.",
          "Wenn du eine Waffe haben willst komm später mal vorbei. Dann bin ich Waffenschmied."))
    end
    do_npc_close(npc, ch)
end

function iaugh_talk(npc, ch)
        do_message(npc, ch, "Ein Reisender aus dem Sandsturm. Was willst du trinken?")
        mana.npc_trade(npc, ch, false, { {30006, 10, 25}, {30007, 10, 60}, {30008, 10, 450} })
        do_message(npc, ch, "Komm bald wieder.")
        do_npc_close(npc, ch)
end

