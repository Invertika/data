----------------------------------------------------------------------------------
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



local function tom_talk(npc, ch)
    npc_message(npc, ch, "Die Bar hat noch nicht geöffnet.")
end
atinit(function()
     npc_create("Tom", 138, GENDER_UNSPECIFIED, 25 * TILESIZE, 10 * TILESIZE + 16, tom_talk, nil) --- Tom 
end)
