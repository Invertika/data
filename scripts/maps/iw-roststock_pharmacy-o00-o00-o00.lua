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
require "scripts/ivklibs/invertika"

atinit(function()
    create_npc("Nijeta", 58, 50 * TILESIZE + 16, 33 * TILESIZE + 16, nijeta_talk, nil) --Nijeta
end)

function nijeta_talk(npc, ch)
	do_message(npc, ch, "Hallo, was kann ich für dich tun?")
	
	while true do 
		local v = do_choice(npc, ch, "Kaufen.",
								     "Verkaufen.",
								     "Nichts. Danke.")
								   
		if v == 1 then
			mana.npc_trade(npc, ch, false, { {30002, 70, 50}, {30015, 150, 50}, {30016, 450, 50}, {30018, 150, 50}, {30019, 500, 50} })
			break
		elseif v == 2 then
			mana.npc_trade(npc, ch, true, { {30002, 50, 50}, {30015, 50, 50}, {30016, 250, 50}, {30018, 50, 50}, {30019, 300, 50} })
			break
		elseif v == 3 then
			do_message(npc, ch, "Und immer an die Risiken und Nebenwirkungen denken!")
			break
		end
	end
	do_npc_close(npc, ch)
end