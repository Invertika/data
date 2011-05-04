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
require "scripts/libs/datetime"

dofile("data/scripts/libs/warp.lua")

atinit(function()
  create_inter_map_warp_trigger(85, 95, 83, 73) --- Intermap warp
 
  if(datetime.is_current_day(1,4)) then -- Prüft, ob der 1. April ist
    sign.create_sign(99, 65, "SW: Selphi Timlet 11 km")
    sign.create_sign(98, 65, "NO: Narva 7 km")
  else
    sign.create_sign(98, 65, "SW: Selphi Timlet 11 km")
    sign.create_sign(99, 65, "NO: Narva 7 km")
  end
end)
