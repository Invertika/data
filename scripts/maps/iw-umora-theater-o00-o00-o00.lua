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


atinit(function()
     create_npc("Ingrid", 44, 38 * TILESIZE, 16 * TILESIZE + 16, ingrid_talk, nil) --- Ingrid 
     create_npc("Anne", 68, 19 * TILESIZE, 6 * TILESIZE + 16, anne_talk, nil) --- Anne 
     create_npc("Paul", 113, 24 * TILESIZE, 6 * TILESIZE + 16, paul_talk, nil) --- Paul 
end)

function ingrid_talk(npc, ch)
	do_message(npc, ch, "Das Theater hat leider noch nicht geöffnet wir arbeiten noch an der Bühne.")
	do_npc_close(npc, ch)
end

function anne_talk(npc, ch)
	do_message(npc, ch, "Ja, hier können sie ihre Garderobe abgeben wenn wir geöffnet haben.")
	do_npc_close(npc, ch)
end

function paul_talk(npc, ch)
	do_message(npc, ch, "Ihre Garderobe können sie erst bei Eröffnung abgeben.")
	do_npc_close(npc, ch)
end
