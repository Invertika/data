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
    do_message(npc, ch, invertika.get_random_element("Ich wäre gerne mal ein Waffenschmied. Aber keiner will es mir zeigen wie es geht.",
                                                     "Ich kann gut mit Metallen umgehen.",
                                                     "Wenn du eine Waffe haben willst komm später mal vorbei. Dann bin ich Waffenschmied."))
    do_npc_close(npc, ch)
end

function iaugh_talk(npc, ch)
        do_message(npc, ch, "Ein Reisender aus dem Sandsturm. Was willst du trinken?")
        mana.npc_trade(npc, ch, false, { {30006, 10, 25}, {30007, 10, 60}, {30008, 10, 450} })
        do_message(npc, ch, "Komm bald wieder.")
        do_npc_close(npc, ch)
end

