----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2011 The Invertika Development Team                          --
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
 create_inter_map_warp_trigger(19, 7, 17, 29) --- Intermap warp
 nethek.create_netheksaeule(161 * TILESIZE, 25 * TILESIZE + 16) --- Netheksäule
  
 create_npc("Gabriel", 46, 59 * TILESIZE + 16, 160 * TILESIZE + 16, gabriel_talk, nil) --- Gabriel
 create_npc("Patrick", 46, 59 * TILESIZE + 16, 160 * TILESIZE + 16, patrick_talk, nil) --- kevin
end)

function gabriel_talk(npc, ch)
	do_message(npc, ch, "Ich bin Totengräber und habe schon lange keine neuen Aufträge mehr bekommen. Warum mussten auch die Untoten über die Stadt kommen. Mir tun sie komischerweise nichts. Villeicht, weil ich Ihre Gräber schon seit langem Pflege. Manchmal habe ich das gefühl, sie wollen mit mir sprechen, aber wenn ich zu ihnen geheund versuche ihnen zuzuhören, stammeln sie nur unverständliches Gemurmel.")
	do_npc_close(npc, ch)
end

function patrick_talk(npc, ch)

	do_message(npc, ch, "Hallo Fremder, sei vorsichtig in der Umgebung dieser Stadt. Die Untoten reagieren Fremden gegenüber nicht sehr freundlich. Solltest du den Mut haben in die Stadt zu gehen, sei noch vorsichtiger. Auch wenn sie schon gestorben sind, haben sie etwas dagegen, wenn die Gräber von unbekannten Personen besucht werden.")
	do_npc_close(npc, ch)
end