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
    create_npc("Worrany", 69, 22 * TILSIZE + 16, 27 * TILESIZE + 16, worrany_talk, worrany_update)
end)

function worrany_talk(npc, ch)
    do_message(npc, ch, "Tag")
    do_npc_close(npc, ch)
end

local timer = {}
function worrany_update(npc)
    if not timer[npc] then
        timer[npc] = 1
    end
    
    timer = timer + 1
    local x = (mana.posX(chr) - 16) / 32
    
    if timer % 100 == 0 then
        if x == 22 then
            x = 18
        elseif x == 18 then
            x = 27
        else
            x == 22
        end
        mana.being_walk(npc, x * 32 + 16, 880, 2)
        mana.effect_create(5, (x + 1) * TILESIZE, 28 * TILESIZE)
    end
end