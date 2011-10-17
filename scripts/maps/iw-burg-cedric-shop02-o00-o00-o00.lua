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
require "scripts/libs/invertika"

atinit(function()
    --TODO change sprite
    create_npc("Toffi", 201, 22 * TILESIZE + 16, 27 * TILESIZE + 16, toffi_talk, nil)
end)

function toffi_talk()
    do_message(npc, ch, "Tag, Was gibt es?")
	
	while true do
        local v = do_choice(npc, ch, "Kaufen.",
					         "Verkaufen.",
					         "Nichts. Danke.")
						 
	    if v == 1 then
	        mana.npc_trade(npc, ch, false, {{10001, 5, 20}, {10002, 100, 60}, {10003, 5000, 80}, {10004, 50, 1}, {10005, 2500, 50}, {10006, 30000, 50}, {10007, 1, 1}, {10008, 200, 100}, {10009, 100,60}, {10010, 3000, 60}, {10011, 220, 100}, {10012, 150000, 120}, {10013, 14, 20}, {10014, 100, 120}})
	        break
        elseif v == 2 then
	        mana.npc_trade(npc, ch, true, {{10001, 2, 20}, {10002, 50, 60}, {10003, 2500, 80}, {10004, 25, 1}, {10005, 1250, 50}, {10006, 15000, 50}, {10007, 1, 1}, {10008, 100, 100}, {10009, 50,60}, {10010, 1500, 60}, {10011, 110, 100}, {10012, 75000, 120}, {10013, 7, 20}, {10014, 50, 120}})
		    break
	    else
	        do_message(npc, ch, "Beehren sie uns bald wieder.")
	        break
	    end
	end
    do_npc_close(npc, ch)
end
