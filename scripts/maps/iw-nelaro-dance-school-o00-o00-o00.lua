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



local function irucia_talk(npc, ch)
    --TODO: Irgendetwas besseres hier einbauen
    npc_message(npc, ch, "Die Tanzschule hat noch geschlossen.")
end
atinit(function()
    npc_create("Irucia", 79, GENDER_UNSPECIFIED, 33 * TILESIZE + 16, 37 * TILESIZE + 16, irucia_talk, nil)
end)
