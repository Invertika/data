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
require "scripts/libs/invertika"



local function mosris_talk(npc, ch)
    npc_message(npc, ch, "Ich sehe, dass du etwas zu trinken kaufen werden willst.")
    npc_trade(npc, ch, false, { {30006, 999, 25}, {30007, 999, 60}, {30008, 999, 450} })
    npc_message(npc, ch, "Trinke es mit Verstand.")
end
atinit(function()
    npc_create("mosris", 44, GENDER_UNSPECIFIED, 29 * TILESIZE + 16, 35 * TILESIZE + 16, mosris_talk, nil)
end)
