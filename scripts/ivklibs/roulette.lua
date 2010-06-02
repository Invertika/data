----------------------------------------------------------------------------------
-- Games - Roulette                                                    			    --
--                                                                              --
-- 					                           																		      --
--                                                             								  --
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

module("roulette", package.seeall)

require "scripts/lua/npclib"


--- Check ob Zahl rot ist
function roulette_is_red(num)
  local roulette_red_numbers = {1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36} --- Rote Zahlen
	for i=1,table.getn(roulette_red_numbers) do
		if num == roulette_red_numbers[i] then
      return true
    end
  end
	return false
end

--- NPC Talk Funktion
function roulette_talk(npc, ch)
  do_message(npc, ch, "Ein Roulettespiel. Wie viel Geld möchtest du setzen?")
	
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
		if PlayerMoney < money then
			do_message(npc, ch, "Soviel Geld hast du leider nicht.")
      break
    else
      mana.chr_money_change(ch, -money)
		end

    do_message(npc, ch, "Auf was möchtest du setzen?")
    local v = do_choice(npc, ch,"Farbe",
                                "Gleich/Ungleich",
                                "Zahl")
    local w = 0
    if v == 1 then w = do_choice(npc, ch,"Rot","Schwarz")
    elseif v == 2 then w = do_choice(npc, ch,"Gleich","Ungleich")
    elseif v == 3 then w = do_choice(npc, ch,
      "Grün","1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", 
      "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", 
      "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36")
    w = w - 1
    end
    
    local random_number = math.random(0, 36)
    local text_win = "Die Zahl ist: " .. tostring(random_number) .. ". Du hast "
    local text_loose =  "Die Zahl ist: " .. tostring(random_number) .. ". Du hast verloren!"
    if v == 1 and w == 1 then ---Farbe rot
      if roulette_is_red(random_number) then
        do_message(npc, ch, text_win .. tostring(1*money) .. " Aki gewonnen")
        mana.chr_money_change(ch, 2*money)
      else
        do_message(npc, ch, text_loose)
      end
    elseif v == 1 and w == 2 then ---Farbe schwarz
      if roulette_is_red(random_number) == false then
        do_message(npc, ch, text_win .. tostring(1*money) .. " Aki gewonnen")
        mana.chr_money_change(ch, 2*money)
      else
        do_message(npc, ch, text_loose)
      end
    elseif v == 2 and w == 1 then ---Zahl gleich
      if random_number%2 == 0 then
        do_message(npc, ch, text_win .. tostring(1*money) .. " Aki gewonnen")
        mana.chr_money_change(ch, 2*money)
      else
        do_message(npc, ch, text_loose)
      end
    elseif v == 2 and w == 2 then ---Zahl ungleich
      if random_number%2 == 1 then
        do_message(npc, ch, text_win .. tostring(1*money) .. " Aki gewonnen")
        mana.chr_money_change(ch, 2*money)
      else
        do_message(npc, ch, text_loose)
      end
    elseif v == 3 then  ---Zahl gleich Zufallszahl?
      if w == random_number then
        do_message(npc, ch, text_win .. tostring(36*money) .. " Aki gewonnen")
        mana.chr_money_change(ch, 37*money)
      else
        do_message(npc, ch, text_loose)
      end
    end

  end ---while true do
  do_npc_close(npc, ch)
end