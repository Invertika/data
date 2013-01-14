----------------------------------------------------------------------------------
-- Würfel Skript                                                                --
----------------------------------------------------------------------------------
--  Copyright 2009 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("dice", package.seeall)

require "scripts/lua/npclib"

-- Konstanten
DICE_ID = 40042
DICE_NUMBER_OF_SIDES = 6

function dicemanager_talk(npc, ch)
    if chr_inv_count(ch, DICE_ID) < 1 then
        npc_message(npc, ch, "Du benötigst einen Würfel um mitzuspielen.")
        return
    end
    while true do
        local v = npc_choice(npc, ch, "Würfeln.", "Tschüss.")
        if v == 1 then
            being_say(npc, string.format("%s würfelt %d Augen", being_get_name(ch), get_new_dice_value()))
            break
        elseif v == 2 then
            break
        end
    end
end

function get_new_dice_value()
    return math.random(1, DICE_NUMBER_OF_SIDES)
end
