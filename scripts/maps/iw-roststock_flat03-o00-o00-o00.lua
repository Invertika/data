----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                          --
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
 create_npc("Marle", 67, 27 * TILESIZE + 16, 29 * TILESIZE + 16, marle_talk, nil)
end)

function marle_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Ich würde gerne mal Effendi besuchen.",
	  "Die beste Freundin von Effendi ist Anne. Habe ich zumindestens gehört.",
	  "Eigentlich heißt er garnicht Effendi sondern Effendi der Erste.",
	  "Du hättest dir ruhig die Schuhe abputzen können. Jetzt ist hier alles voller Sand.",
	  "In den westlichen Gegenend soll es manchmal sogar Schnee geben habe ich gehört.",
	  "Frühler sammelte ich Porzellanfiguren.")) 
	 do_npc_close(npc, ch)
end