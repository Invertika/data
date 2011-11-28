----------------------------------------------------------------------------------
-- Special                                                                      --
--                                                                              --
-- Spezielle nicht öffentliche Funktionen                                       --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008, 2009 The Invertika Development Team                         --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("special", package.seeall)

require "scripts/lua/npclib"

--- Fahrstuhl für das Ipsum Haus
function elevator_selphi_timlet_ipsum_house_talk(npc, ch) --- NPC für die Netheksäule
	do_message(npc, ch, "Bitte Stockwerk auswählen.")
	
	DEFAULT_X_POS = 78 * TILESIZE
	DEFAULT_Y_POS = 25 * TILESIZE
	
	while true do
		local v = do_choice(npc, ch, "00",
								     "01",
								     "02",
									 "03",
									 "04",
									 "05",
									 "Ich möchte nicht Fahrstuhl fahren.")
								
		if v == 1 then
		    mana.chr_warp(ch, 20148, 25 * TILESIZE, 23 * TILESIZE) 		
			break;
		elseif v == 2 then
		    mana.chr_warp(ch, 20002, DEFAULT_X_POS, DEFAULT_Y_POS) 		
			break;
		elseif v == 3 then
		    mana.chr_warp(ch, 20010, DEFAULT_X_POS, DEFAULT_Y_POS) 		
			break;
		elseif v == 4 then
		    mana.chr_warp(ch, 20011, DEFAULT_X_POS, DEFAULT_Y_POS) 		
			break;
		elseif v == 5 then
		    mana.chr_warp(ch, 20023, DEFAULT_X_POS, DEFAULT_Y_POS) 		
			break;
		elseif v == 6 then
		    mana.chr_warp(ch, 20027, DEFAULT_X_POS, DEFAULT_Y_POS) 		
			break;
		elseif v == 7 then	
			break;
		end
	end
	
	do_npc_close(npc, ch)
end

--- Erzeugt einen NPC für die Netheksäule
function create_elevator_selphi_timlet_ipsum_house_talk(xpos, ypos)
	create_npc("Fahrstuhl", 1, xpos, ypos, elevator_selphi_timlet_ipsum_house_talk, nil) --- Fahrstuhl
end