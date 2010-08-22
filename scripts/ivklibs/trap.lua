----------------------------------------------------------------------------------
-- trap.lua                                                                     --
-- Dieses Skript implementiert einen Hinterhalt                                 --
--                                                                              --
--                                                                              --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/ivklibs/invertika"

module("trap", package.seeall)

-- EXPERIMENTAL FUNCTION. MAY CAUSE SERVER SEGFAULTS
-- see: http://bugs.manasource.org/view.php?id=205
--
-- Usage:
-- ------------
-- trap_activate(ch, chance, radius, monster_ids)
--
-- Parameters:
-- ------------
-- ch: character handle
-- chance: 0-100, probability of the trap
-- radius: radius in which the monsters spawn
-- monster_ids: array of monster ids
--
-- Example:
-- ------------
-- monster_ids={4,10,10,4,10,10}
-- trap.trap_activate(ch, 25, 4*TILESIZE, monster_ids)
--
function trap_activate(ch, chance, radius, monster_ids)
 if (mana.being_type(ch) ~= TYPE_MONSTER) and math.random(1, 100) <= chance then -- Player activates trap by chance
   mana.chatmessage(ch, "Du bist in einen Hinterhalt geraten!")
   local num, phi, x, y, dx, dy, i
   x = mana.posX(ch)
   y = mana.posY(ch)
   num=table.getn(monster_ids)
   phi=2.0*math.pi/num
   for i = 1,num,1 do  --- circle of monsters
     dx = radius*math.cos(i*phi)
     dy = radius*math.sin(i*phi)
     mana.monster_create(monster_ids[i], x+dx, y+dy)
   end
 end
end

