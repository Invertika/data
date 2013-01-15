----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------


require "scripts/lua/npclib"
require "scripts/libs/invertika"

local function rezeptionist_talk(npc, ch)
   npc_message(npc, ch, "Bald werden wir das erste Höhlenhotel Invertikas eröffnen!")
end

atinit(function()
    npc_create("Rezeptionist", 20, GENDER_UNSPECIFIED, 24 * TILESIZE + 16, 37 * TILESIZE + 16, rezeptionist_talk, nil)
end)
