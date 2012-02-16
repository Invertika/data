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

require "scripts/libs/warp"
require "scripts/libs/sign"
require "scripts/libs/invertika"

atinit(function()
 create_inter_map_warp_trigger(40, 28, 34, 50) --- Intermap warp
 local sign_buttom = "Roststock"
 sign.create_sign(75, 90, sign_buttom)
 local sign_top = "Teralsiedlung"
 sign.create_sign(75, 81, sign_top)
 local sign_right = "Qakari"
 sign.create_sign(78, 81, sign_right)
end)
