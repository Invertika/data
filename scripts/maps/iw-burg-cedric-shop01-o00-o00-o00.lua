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
    create_npc("Worrany", 69, 22 * TILESIZE + 16, 27 * TILESIZE + 16, worrany_talk, worrany_update)
end)

function worrany_talk(npc, ch)
    do_message(npc, ch, "Willkommen, in meinem Kräuterladen")
	do_message(npc, ch, "Was kann ich für sie tun?")
    
	while true do
        local v = do_choice(npc, ch, "Kaufen.",
					         "Verkaufen.",
					         "Nichts. Danke.")
						 
	    if v == 1 then
	        mana.npc_trade(npc, ch, false, {
            {30015, 12, 25}, 
            {30016, 12, 50}, 
            {30017, 12, 75}, 
            {30018, 12, 25}, 
            {30019, 12, 55}, 
            {30020, 12, 75},
            })
	        break
        elseif v == 2 then
	        mana.npc_trade(npc, ch, true, {
            {30015, 12, 12}, 
            {30016, 12, 25}, 
            {30017, 12, 37}, 
            {30018, 12, 12}, 
            {30019, 12, 27}, 
            {30020, 12, 37},
            })
		    break
	    elseif v == 3 then
	        do_message(npc, ch, "Beehren sie uns bald wieder.")
	        break
	    end
	end
    do_npc_close(npc, ch)
end

-- local walk_timer = {}
-- function worrany_update(npc)
    -- if walk_timer[npc] then
        -- walk_timer[npc] = walk_timer[npc] + 1
        -- local x = mana.posX(chr) / TILESIZE - 0.5
        
        -- if walk_timer[npc] % 100 == 0 then
            -- if x == 22 then
                -- x = 18
            -- elseif x == 18 then
                -- x = 27
            -- else
                -- x = 22
            -- end
        -- end
        -- mana.being_walk(npc, x * 32 + 16, 880, 2)
        -- if x ~= 22 then
            -- mana.effect_create(5, (x + 1) * TILESIZE, 28 * TILESIZE)
        -- end
    -- else
        -- walk_timer[npc] = 1
    -- end
-- end