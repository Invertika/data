----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2010 by Invertika Project                                  --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/ivklibs/invertika"
---require "scripts/ivklibs/trap"

dofile("data/scripts/ivklibs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(19003, 19003, 19003, 19003) --- Intermap warp
 create_npc("Zelan", 58, 132 * TILESIZE + 16, 21 * TILESIZE + 16, zelan_talk, nil) --- Zelan
 mana.trigger_create(20 * TILESIZE, 20 * TILESIZE, 22 * TILESIZE, 22 * TILESIZE, "trap_trigger_skorpions", 0, true) --- Trigger Trap
end)

function zelan_talk(npc, ch)
    do_message(npc, ch, "Wo du bist? Im Vacare. Jeder neue kommt hier her bevor es raus geht in die große Welt. Also pass auf dich auf.")
	do_npc_close(npc, ch)
end


--- Falle auslösen
function trap_trigger_skorpions(ch, id)
  trap(ch, 21*TILESIZE, 21*TILESIZE,TILESIZE,TILESIZE,10)--- Bibliotheksfunktion
end

--- Bibliotheksfunktion
function trap(ch, x, y, width, height, monsterid)
  if (mana.being_type(ch) ~= TYPE_MONSTER) then --- Nur Player löst Falle aus
   local x1 = x - width/2
   local y1 = y - height/2
   local x2 = x + width/2
   local y2 = y + height/2
   local currentTime = os.time(t)
   local lastTime = get_quest_var(ch, "trap_last_activated")

   if (lastTime == nil) or (lastTime == "") then
     mana.chr_set_quest(ch, "trap_last_activated", currentTime)      
     print("trap case1: trap triggered for first time")
   elseif math.floor(currentTime-lastTime) > 20 then
     mana.chr_set_quest(ch, "trap_last_activated", currentTime)      
     --local spawned_monster = mana.monster_create(monsterid, x, y)
     --mana.being_say(spawned_monster,"Du bist in einen Hinterhalt geraten!")
     print("trap case2: create monster")
   else
     print("trap case3: be patient")
     --- nichts passiert
   end

 end
end
