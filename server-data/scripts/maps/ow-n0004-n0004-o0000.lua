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
require "scripts/libs/nethek"
require "scripts/libs/seller"
require "scripts/libs/sign"

dofile("data/scripts/libs/warp.lua")

atinit(function()
    create_inter_map_warp_trigger(36, 26, 38, 48) --- Intermap warp
    nethek.create_netheksaeule(122 * TILESIZE, 114 * TILESIZE + 16) --- Netheksäule

    sign_entrance = "Liori"
    sign.create_sign(156, 107, sign_entrance) --- Schild Ortseingang

    --NPCs
    create_npc("Deaqon", 35, 94 * TILESIZE + 16, 103 * TILESIZE + 16, seller.seller_talk, nil) --- Verkäufer
end)
