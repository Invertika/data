----------------------------------------------------------------------------------
-- Ghost Skript                                                                 --
--                                                                              --
-- Dieses Modull stellt Funktionen für das Spawnen von Geistern zur Verfügung   --
--                                                                              --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2011 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("death", package.seeall)

--- Chance fuer einen Geist beim Tod (1 = immer, 0 = nie)
CHANCE_GHOST_SPAWNS=0.5
--- ID des Geists
GHOST_ID=22

--- Spawnt einen Geist mit einer bestimmten Chance
function death_spawn_ghost(ch)
    if math.random() < CHANCE_GHOST_SPAWNS then
        --- Geist wird gespawnt
        local x = mana.posX(ch)
        local y = mana.posY(ch)
        mana.monster_create(GHOST_ID, x, y)
    end
end
