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
require "scripts/libs/seller"

require "scripts/libs/warp"

atinit(function()
 create_inter_map_warp_trigger(23, 13, 25, 35) --- Intermap warp
 create_npc("Klero", 107, 94 * TILESIZE + 16, 124 * TILESIZE + 16, seller.seller_talk, nil) --- Verkäufer
end)
