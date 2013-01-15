----------------------------------------------------------------------------------
-- Netek Säulenskrpt                                                            --
--                                                                              --
-- Dieses Modul stellt Funktionen für die Netheksäulen zur Verfügung            --
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

module("nethek", package.seeall)

require "scripts/lua/npclib"

--- Konstanten
DEFAULT_MAP = 61 --- Defaulkarte
DEFAULT_X = 5728;
DEFAULT_Y = 4832;

--- Setzt die Warp Map
function set_nethek_warp_map(ch, mapID)
	chr_set_quest(ch, "nethek_warp_map", mapID)
end

--- Gibt die Warp Map zurück
function get_nethek_warp_map(ch)
	local mapID = get_quest_var(ch, "nethek_warp_map")
	if mapID=="" then
	   return DEFAULT_MAP
	else
	   return mapID
	end
end

--- Setzt die Warp Position X in Pixel
function set_nethek_warp_x(ch, posX)
	chr_set_quest(ch, "nethek_warp_x", posX)
end

--- Gibt die Warpposition X in Pixel zurück
function get_nethek_warp_x(ch)
	local posX = get_quest_var(ch, "nethek_warp_x")
	if posX=="" then
	   return DEFAULT_X
	else
	   return posX
	end
end

--- Setzt die Warp Position Y in Pixel
function set_nethek_warp_y(ch, posY)
	chr_set_quest(ch, "nethek_warp_y", posY)
end

--- Gibt die Warpposition Y in Pixel zurück
function get_nethek_warp_y(ch)
	local posY = get_quest_var(ch, "nethek_warp_y")
	if posY=="" then
	   return DEFAULT_Y
	else
	   return posY
	end
end

--- Geopfertes Geld abfragen
function get_oblation_money(ch)	
	local acc_bal = get_quest_var(ch, "nethek_oblation_money")
	
	if acc_bal=="" then
		chr_set_quest(ch, "nethek_oblation_money", 0)
		return 0
	else
		return tonumber(acc_bal)
	end
end

--- Geld opfern
function immolate_money(npc, ch, money)
	local PlayerMoney=chr_money(ch)
	
	if PlayerMoney >= money then
		chr_money_change(ch, -money)
		local acc_bal = get_oblation_money(ch)
		chr_set_quest(ch, "nethek_oblation_money", acc_bal+money)
		npc_message(npc, ch, "Dein Opfer wurde angenommen!")
	else
		npc_message(npc, ch, "Soviel Geld hast du nicht!")	
	end
end


--- Talkfunktion für die Netheksäuke
function netheksaeule_talk(npc, ch) --- NPC für die Netheksäule
	npc_message(npc, ch, "Was moechtest du?")
	
	while true do
		local v = npc_choice(npc, ch, "Deinen Segen.",
								     "Geld opfern.",
								     "Nichts. Danke.")
								
		if v == 1 then
		    local x = posX(npc)
			local y = posY(npc) + 64
			
			set_nethek_warp_x(ch, x)
			set_nethek_warp_y(ch, y)
			set_nethek_warp_map(ch, get_map_id())
			
			npc_message(npc, ch, "Xenti Taree. Mein Segen.")
			
			break;
		elseif v == 2 then
			local v2 = npc_choice(npc, ch, "500", "1000", "2000", "5000", "10000", "25000", "50000","Nichts opfern")
					if v2 == 1 then --- 500
						immolate_money(npc, ch, 500)
					elseif v2 == 2 then --- 1000
						immolate_money(npc, ch, 1000)
					elseif v2 == 3 then --- 2000
						immolate_money(npc, ch, 2000)
					elseif v2 == 4 then --- 5000
						immolate_money(npc, ch, 5000)
					elseif v2 == 5 then --- 10000
						immolate_money(npc, ch, 10000)
					elseif v2 == 6 then --- 25000
						immolate_money(npc, ch, 25000)
					elseif v2 == 7 then --- 50000
						immolate_money(npc, ch, 50000)
					elseif v2 == 8 then --- Nichts opfern
						---
					end
			break;
		elseif v == 3 then
			npc_message(npc, ch, "Gehe deinen Weg, Wanderer der Äonen.")
			break
		end
	end
	
end

--- Erzeugt einen NPC für die Netheksäule
function create_netheksaeule(xpos, ypos)
	npc_create("Netheksäule", 1, GENDER_UNSPECIFIED, xpos, ypos, netheksaeule_talk, nil) --- Netheksäule
end
