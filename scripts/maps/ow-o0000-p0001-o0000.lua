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

dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(63, 73, 61, 7) --- Intermap warp
 mana.trigger_create(36 * TILESIZE + 8, 84 * TILESIZE + 8, 1.5 * TILESIZE, 1.5 * TILESIZE, "warp_escape_tunnel", 0, true) --- Warp zum Fluchttunnel
end)

function warp_escape_tunnel(obj, blubb)
    if(mana.being_type(obj)==TYPE_CHARACTER) then
        mana.chr_warp(obj, 20182, 976, 112) 
    end
end
