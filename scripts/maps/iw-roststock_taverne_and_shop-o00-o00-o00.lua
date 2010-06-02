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
require "scripts/ivklibs/invertika"

atinit(function()
 create_npc("Björn", 160, 75 * TILESIZE + 16, 24 * TILESIZE + 16, bjoern_talk, nil) --- Banker (Debug)
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