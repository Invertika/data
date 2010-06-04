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
require "scripts/ivklibs/banker"
require "scripts/ivklibs/slotmachine"

atinit(function() 
 create_npc("Brecht", 117, 20 * TILESIZE + 16, 15 * TILESIZE + 16, brecht_talk, nil) --- Brecht
end)

function brecht_talk(npc, ch)
	do_message(npc, ch, "Ich sehe schon du bist durstig. Was möchtest du?")
	mana.npc_trade(npc, ch, false, { {30006, 10, 25}, {30007, 10, 60}, {30008, 10, 450} })
	do_message(npc, ch, "Lass es dir schmecken.")
	do_npc_close(npc, ch)
end