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

atinit(function()
    create_npc("Rezeptionist", 20, 24 * TILESIZE + 16, 37 * TILESIZE + 16, rezeptionist_talk, nil)
end)
function rezeptionist_talk(npc, ch)
   do_message(npc, ch, "Bald werden wir das erste Höhlenhotel Invertikas eröffnen!")
   do_npc_close(npc, ch)
end
