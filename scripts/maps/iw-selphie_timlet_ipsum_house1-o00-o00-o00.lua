----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008, 2009 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"
require "scripts/libs/special"

atinit(function()
 create_npc("Nomo", 20, 48 * TILESIZE + 16, 23 * TILESIZE + 16, nomo_talk, nil) --- Nomo
end)

function nomo_talk(npc, ch)
	local count = mana.chr_inv_count(ch, 40010) 
	
	if count < 1 then
		do_message(npc, ch, invertika.get_random_element("Blub...",
	  "Wenn ich das bloß wüsste...",
	  "Der Regenwurm, der Regenwurm...",
	  "Immer zu Diensten.",
	  "Darüber darf ich nicht sprechen.",
	  "Das glaube ich allerdings nicht."))			
	else
		mana.chr_warp(ch,  61, 3936, 3488) 
		do_message(npc, ch, "Du bist in Besitz des Schlüssels. Willkommen auf der dunklen Seite. Die Kekse liegen im Haus.")
	end
	do_npc_close(npc, ch)
end