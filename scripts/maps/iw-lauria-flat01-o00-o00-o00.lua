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




local function ansdan_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Willkommen!",
      "Dies ist mein Bescheidenes Heim.",
      "Möge Invertika euch beschützen."))
end

atinit(function()
    npc_create("Ansdan", 60, GENDER_UNSPECIFIED, 25 * TILESIZE + 16, 39 * TILESIZE + 16, ansdan_talk, nil) --- Ansdan
end)
