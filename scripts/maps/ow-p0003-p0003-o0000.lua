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

require "data/scripts/libs/npclib"
require "data/scripts/ivklibs/nethek"

dofile("data/scripts/ivklibs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(98, 108, 96, 86) --- Intermap warp
 nethek.create_netheksaeule(106 * TILESIZE + 16, 125 * TILESIZE + 16) --- Netheksäule
end)
