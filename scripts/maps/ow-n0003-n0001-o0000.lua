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

require "scripts/libs/warp"

atinit(function()
  create_inter_map_warp_trigger(28, 12, 24, 34) --- Intermap warp
  nethek.create_netheksaeule(96 * TILESIZE, 102 * TILESIZE + 16) --- Netheksäule
  sign_well = "Benutzung des Brunnens auf eigene Gefahr\n\nEs ist strengstens verboten, Handtücher in den Brunnen zu werfen! Ein solches Vergehen wird mit harter Strafe geahndet."
  sign.create_sign(70, 103, sign_well)
  
  --- TODO: Geschichte der Stadt auf das Schild schreiben
  sign_history = "Roststock"
  sign.create_sign(97, 103, sign_history)
end)
