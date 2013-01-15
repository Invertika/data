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
require "scripts/libs/dice"
require "scripts/libs/slotmachine"
require "scripts/libs/roulette"


local function daniel_talk(npc, ch)
    npc_message(npc, ch, "Moin. Was wollen sie?")
    while true do
        local v = npc_choice(npc, ch,
          "Kaufen.",
          "Nichts. Danke.")
        if v == 1 then
            npc_trade(npc, ch, false,
              {{30001, 25, 300},
              {30006, 400, 200},
              {30007, 300, 200}})
            break
        elseif v == 2 then
            npc_message(npc, ch, "Tschüß.")
            break
        end
    end
end

atinit(function()
    npc_create("Daniel", 63, GENDER_UNSPECIFIED, 19 * TILESIZE + 16, 27 * TILESIZE + 16 , daniel_talk, nil)

    npc_create("Würfeltisch", 1, GENDER_UNSPECIFIED, 27 * TILESIZE + 16, 26 * TILESIZE + 16, dice.dicemanager_talk, nil)
    npc_create("Würfeltisch", 1, GENDER_UNSPECIFIED, 27 * TILESIZE + 16, 29 * TILESIZE + 16, dice.dicemanager_talk, nil)
    
    npc_create("Slotmaschine", 1, GENDER_UNSPECIFIED, 39 * TILESIZE + 16, 27 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    npc_create("Slotmaschine", 1, GENDER_UNSPECIFIED, 39 * TILESIZE + 16, 30 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)

    npc_create("Roulette", 1, GENDER_UNSPECIFIED, 31 * TILESIZE + 16, 26 * TILESIZE + 16, roulette.roulette_talk, nil)
    npc_create("Roulette", 1, GENDER_UNSPECIFIED, 31 * TILESIZE + 16, 29 * TILESIZE + 16, roulette.roulette_talk, nil)
end)
