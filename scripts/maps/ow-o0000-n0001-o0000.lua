----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2011 The Invertika Development Team                        --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/sign"

require "scripts/libs/warp"

atinit(function()
  create_inter_map_warp_trigger(61, 67, 57, 1) --- Intermap warp
  
  sign_entrance = "Selphi Timlet"
  sign.create_sign(110, 11, sign_entrance) --- Schild Ortseingang
  sign.create_sign(118, 11, sign_entrance) --- Schild Ortseingang
  
  sign_west = "<-- Roststock 400 Amoti"
  sign.create_sign(119, 65, sign_west)
  sign.create_sign(52, 67, sign_west)
  sign.create_sign(45, 40, sign_west)
  sign.create_sign(12, 67, sign_west)
end)
