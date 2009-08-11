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

require "data/scripts/libs/npclib"

atinit(function()
 create_npc("Luor", 116, 34 * TILESIZE + 16, 24 * TILESIZE + 16, luor_talk, nil) --- Luor
 create_npc("Krenel", 150, 41 * TILESIZE + 16, 56 * TILESIZE + 16, krenel_talk, nil) --- Krenel
end)

function luor_talk(npc, ch)
    do_message(npc, ch, "Sei gegrüßt, ich bin Luor, Herscher über Selphi Timlet, Bewahrer des Heiligen Kelches von Rixx. Wie lautet deine Bitte? - Obwohl lieber nicht, im Moment steht es mir nicht nach einer Audienz.")
	do_npc_close(npc, ch)
end

function krenel_talk(npc, ch)
    				do_message(npc, ch, invertika.get_random_element("Wir müssen Aktivität vortäuschen...",
	  "Aktivität simulieren... Also steh hier nicht rum. Los hop hop!",
	  "Ich täusche Aktivität vor, also schau nicht so und mache das gleiche.",
	  "Wenn wir das nicht tun ist alles zu spät."))
	do_npc_close(npc, ch)
end