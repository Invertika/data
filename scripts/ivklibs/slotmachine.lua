----------------------------------------------------------------------------------
-- Games - Slot Machine                                                         --
--                                                                              --
-- Einarmiger Bandit							                                --
-- zur Verfügung                                                                --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008, 2009 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("slotmachine", package.seeall)

require "scripts/lua/npclib"

--- Konstanten
SLOT_MACHINE_FIELDS = { "7", "Kirsche", "Banane", "Pfirsich", "Kiwi", "Schatztruhe"}; --- Felder der Slotmaschine

--- NPC Talk Funktion
function slotmachine_talk(npc, ch)
  do_message(npc, ch, "Eine Slotmaschine. Wie viel Geld möchtest du setzen?")
  
 while true do 
	local v = do_choice(npc, ch, "5 Aki",
							   "10 Aki",
							   "50 Aki",
							   "100 Aki",
							   "500 Aki",
							   "1000 Aki",
							   "2000 Aki",
							   "Keines, ich möchte aufhören.")
							  
	local money = 0						  
	if v == 1 then money=5
	elseif v == 2 then money=10
	elseif v == 3 then money=50
	elseif v == 4 then money=100
	elseif v == 5 then money=500
	elseif v == 6 then money=1000
	elseif v == 7 then money=2000
	elseif v == 8 then break
	end
	
	local PlayerMoney=mana.chr_money(ch)
	if PlayerMoney >= money then
	  mana.chr_money_change(ch, -money)
	
	  local arrayCount = table.getn( SLOT_MACHINE_FIELDS ) -- Anzahl der Elemente  ermitteln
	  local r1 = math.random(1, arrayCount)
	  local r2 = math.random(1, arrayCount)
	  local r3 = math.random(1, arrayCount)
	
	  if(r1 == r2 and r2 == r3) then
	    do_message(npc, ch, string.format("%s - %s - %s\nOh Gratulation du hast gewonnen :)", SLOT_MACHINE_FIELDS[r1], SLOT_MACHINE_FIELDS[r2], SLOT_MACHINE_FIELDS[r3]))	
		mana.chr_money_change(ch, money*10) --- TODO Jackpot Variable
	  else
	    do_message(npc, ch, string.format("%s - %s - %s\nMmm du hast leider verloren.", SLOT_MACHINE_FIELDS[r1], SLOT_MACHINE_FIELDS[r2], SLOT_MACHINE_FIELDS[r3]))	
	  end	
	else
	  do_message(npc, ch, "Soviel Geld hast du leider nicht.")
	end
  end ---while true do 
  do_npc_close(npc, ch)
end