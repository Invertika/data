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
require "scripts/libs/sign"

dofile("data/scripts/libs/warp.lua")

atinit(function()
  create_inter_map_warp_trigger(6, 56, 2, 12) --- Intermap warp
  sign_horiz = "<-- Roststock 10 km\nSelphie Timlet 5km -->"
  sign.create_sign(173, 68, sign_horiz)
  sign.create_sign(126, 66, sign_horiz)
  sign.create_sign(79, 64, sign_horiz)
  sign.create_sign(48, 74, sign_horiz)
  sign.create_sign(13, 76, sign_horiz)
end)
