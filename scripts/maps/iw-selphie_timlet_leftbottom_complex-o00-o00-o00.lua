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

require "scripts/libs/npclib"
require "scripts/ivklibs/banker"
require "scripts/ivklibs/slotmachine"

atinit(function() 
 create_npc("Banker", 107, 45 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 107, 60 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 107, 75 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Brecht", 117, 118 * TILESIZE + 16, 47 * TILESIZE + 16, brecht_talk, nil) --- Brecht
 
 create_npc("Slotmaschine", 20001, 125 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 127 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 129 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 131 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 133 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 135 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
end)

function brecht_talk(npc, ch)
	do_message(npc, ch, "Ich sehe schon du bist durstig. Was möchtest du?")
	mana.npc_trade(npc, ch, false, { {30006, 10, 25}, {30007, 10, 60}, {30008, 10, 450} })
	do_message(npc, ch, "Lass es dir schmecken.")
	do_npc_close(npc, ch)
end