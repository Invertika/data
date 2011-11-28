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
require "scripts/libs/nethek"
require "scripts/libs/sign"

dofile("data/scripts/libs/warp.lua")

atinit(function()
    create_inter_map_warp_trigger(108, 118, 106, 96) --- Intermap warp
    nethek.create_netheksaeule(47 * TILESIZE, 127 * TILESIZE + 16) --- Netheksäule

    sign_entrance = "Umora"
    sign.create_sign(84, 149, sign_entrance) --- Schild Ortseingang
    sign.create_sign(89, 149, sign_entrance) --- Schild Ortseingang
end)
