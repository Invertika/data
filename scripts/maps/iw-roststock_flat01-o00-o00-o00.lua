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

require "scripts/libs/npclib"
require "scripts/ivklibs/invertika"

atinit(function()
 create_npc("Velera", 175, 24 * TILESIZE + 16, 27 * TILESIZE + 16, velera_talk, nil)
end)

function velera_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Ja schon wieder ein Sandsturm. So wie immer...",
	  "Warum Roststock Roststock heißt? Also wenn du da nicht selbst draufkommst.",
	  "Ich wohne hier seitdem ich denken kann...",
	  "Mein Freund Björn ist, schon wieder nicht hier...",
	  "Ich bin Velera. Wie bitte? Ja ich bin vergeben.",
	  "Heute ist mal wieder einer dieser seltsamen Tage.")) 
	 do_npc_close(npc, ch)
end