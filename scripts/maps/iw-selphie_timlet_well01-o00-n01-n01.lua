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
require "scripts/ivklibs/invertika"

atinit(function()
 npc = create_npc("Ta No Test", 89, 35 * TILESIZE + 16, 44 * TILESIZE + 16, elmo_talk, npclib.walkaround_wide) --- Elmo
end)

function elmo_talk(npc, ch)
    
end
