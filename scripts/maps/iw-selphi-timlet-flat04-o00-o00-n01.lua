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
    mana.trigger_create(45 * TILESIZE, 23 * TILESIZE, 1 * TILESIZE, 1 * TILESIZE, "warp_escape_tunnel2", 0, true)
end)

function warp_escape_tunnel2(obj, arg)
    if(mana.being_type(obj)==TYPE_CHARACTER) then
        mana.chr_warp(obj, 20188, 3 * TILESIZE + 16, 14 * TILESIZE + 16)
    end
end
