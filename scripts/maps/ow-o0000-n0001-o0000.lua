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
require "scripts/ivklibs/sign"

dofile("data/scripts/ivklibs/warp.lua")

atinit(function()
  create_inter_map_warp_trigger(61, 67, 57, 1) --- Intermap warp
  sign_entrance = "Selphie Timlet"
  sign.create_sign(110, 11, sign_entrance) --- Schild Ortseingang
  sign.create_sign(118, 11, sign_entrance) --- Schild Ortseingang
end)
