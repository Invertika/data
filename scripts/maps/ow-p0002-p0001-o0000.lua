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
require "scripts/libs/datetime"

require "scripts/libs/warp"

atinit(function()
  create_inter_map_warp_trigger(85, 95, 83, 73) --- Intermap warp
 
  if(datetime.is_current_day(1,4)) then -- Prüft, ob der 1. April ist
    sign.create_sign(99, 65, "SW: Selphi Timlet 300 Amoti")
    sign.create_sign(98, 65, "NO: Narva 250 Amoti")
  else
    sign.create_sign(98, 65, "SW: Selphi Timlet 300 Amoti")
    sign.create_sign(99, 65, "NO: Narva 250 Amoti")
  end
end)
