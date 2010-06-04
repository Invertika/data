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
require "scripts/ivklibs/banker"

atinit(function() 
 create_npc("Banker", 107, 45 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 107, 53 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 107, 60 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 107, 67 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 107, 75 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
end)