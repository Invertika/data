----------------------------------------------------------------------------------
-- Walking NPC Skript                                                           --
--                                                                              --
-- Dieses Modul stellt Funktionen für sich selbstständig bewegende NPCs         --
-- zur Verfügung                                                                --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008, 2009 The Invertika Development Team                         --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("walking", package.seeall)

require "scripts/lua/npclib"

--- Erzeugt einen sich bewegenden NPC
function make_npc_walking(walkingnpc)
    schedule_every(2, function(walkingnpc)
        xpos = mana.posX(walkingnpc) + math.random(-1,1)
        ypos = mana.posY(walkingnpc) + math.random(-1,1)
        mana.being_walk(walkingnpc, xpos, ypos, 1)
    end, walkingnpc)
end
