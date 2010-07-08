----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------


require "scripts/lua/npclib"


dofile("data/scripts/ivklibs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(868, 816, 866, 918) --- Intermap warp
 create_npc("Schild", 1, 81 * TILESIZE + 16, 145 * TILESIZE + 16, schild_talk, nil) --- Schild
 create_npc("Schild", 1, 88 * TILESIZE + 16, 145 * TILESIZE + 16, schild_talk, nil) --- Schild
end)

function schild_talk(npc, ch)
	do_message(npc, ch, "Bebauen dieser Fläche verboten. Bei Zuwiderhandlung erfolgt Weltuntergang.")
	do_npc_close(npc, ch)
end