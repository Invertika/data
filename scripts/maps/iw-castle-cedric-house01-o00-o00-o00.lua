﻿----------------------------------------------------------------------------------
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
require "scripts/libs/invertika"


local function ormylt_talk(npc, ch)
    npc_message(npc, ch, "Ich bin die Frau von Graf Cedric")
end
atinit(function()
    npc_create("Ormylt", 12, GENDER_UNSPECIFIED, 44 * TILESIZE + 16, 28 * TILESIZE + 16, ormylt_talk, nil)
end)
