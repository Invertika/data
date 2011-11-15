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
require "scripts/libs/nethek"

dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(69, 81, 71, 59) --- Intermap warp
 nethek.create_netheksaeule(97 * TILESIZE, 155 * TILESIZE + 16) ---Netheksäule
 
  -- NPCs
 create_npc("Asgard", 47, 139 * TILESIZE + 16, 96 * TILESIZE + 16, asgard_talk, nil) --- Asgard
end)

function asgard_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Noch nie war jemmand in diesem Turm.",
        "Was sich im inneren des Turmes befinden mag?",
        "Es gibt eine Legende, die besagt das der Turm sich eines Tages öffnen wird.",
        "Viele haben versucht in den Turm einzudringen, aber niemand hat es je geschafft."))
    do_npc_close(npc, ch)
end