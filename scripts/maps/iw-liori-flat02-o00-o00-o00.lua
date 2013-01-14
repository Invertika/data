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
require "scripts/libs/invertika"


local function hatsuli_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Immer muss ich das gleiche sagen.",
      "Niemand fragt mich warum. Alle denken das muss so.",
      "Ja und das nur wegen diesem Spinat."))
end

local function eldachi_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Früher wollte ich immer eines von diesen Telefonen haben.",
      "Ach hätte ich doch nur ein Klavier.",
      "Irgendwoher kenne ich dich..."))
end

atinit(function()
    npc_create("Hatsuli", 141, GENDER_UNSPECIFIED, 12 * TILESIZE + 16, 22 * TILESIZE + 16, hatsuli_talk, nil) --- Hatsuli
    npc_create("Eldachi", 142, GENDER_UNSPECIFIED, 13 * TILESIZE + 16, 22 * TILESIZE + 16, eldachi_talk, nil) --- Eldachi
end)
