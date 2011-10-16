----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"
require "scripts/libs/dice"
require "scripts/libs/slotmachine"
require "scripts/libs/roulette"

atinit(function()
    create_npc("Daniel", 63, 20 * TILESIZE + 16, 27 * TILESIZE + 16 , daniel_talk, nil)

    create_npc("Würfeltisch", 1, 30 * TILESIZE + 16, 26 * TILESIZE + 16, dice.dicemanager_talk, nil)
    create_npc("Würfeltisch", 1, 27 * TILESIZE + 16, 29 * TILESIZE + 16, dice.dicemanager_talk, nil)
	
    create_npc("Slotmaschine", 1, 39 * TILESIZE + 16, 27 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    create_npc("Slotmaschine", 1, 39 * TILESIZE + 16, 30 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)

    create_npc("Roulette", 1, 31 * TILESIZE + 16, 26 * TILESIZE + 16, roulette.roulette_talk, nil)
    create_npc("Roulette", 1, 31 * TILESIZE + 16, 29 * TILESIZE + 16, roulette.roulette_talk, nil)
end)

function daniel_talk(npc, ch)
    do_message(npc, ch, "Hmmm.")
    do_npc_close(npc, ch)
end