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
    sign.create_sign(131, 108, sign_entrance) --- Schild Ortseingang
    sign.create_sign(92, 78, "\"Bank der Zweisamkeit\"\n\nBitte seien sie diskret, falls die Bank bereits besetzt sein sollte.")
    sign.create_sign(122, 68, "\"Statue von Er--i--l--mon\"\n\nZu gedenken des Gründers von Liori. Sein Name soll uns auf ewig in Erinnerung bleiben!")

    --NPCs
    create_npc("Deaqon", 35, 94 * TILESIZE + 16, 103 * TILESIZE + 16, seller.seller_talk, nil) --- Verkäufer
end)
