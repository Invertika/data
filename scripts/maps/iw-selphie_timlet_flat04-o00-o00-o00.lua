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

atinit(function()
 create_npc("Haitan", 67, 62 * TILESIZE + 16, 29 * TILESIZE + 16, haitan_talk, nil) --- Haitan
end)

function haitan_talk(npc, ch)
	do_message(npc, ch, "Bitte bring doch ein paar von den Skorpionen im Keller um.")
	do_npc_close(npc, ch)
end
