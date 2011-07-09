----------------------------------------------------------------------------------
-- Warp Skript                                                                  --
--                                                                              --
-- Dieses Skript stellt die Warpfunktionalität zur Verfügung                    --
-- zur Verfügung                                                                --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

function create_inter_map_warp_trigger(MapUp, MapRight, MapDown, MapLeft)
 mana.trigger_create(0 * TILESIZE, 0 * TILESIZE, 200 * TILESIZE, 2 * TILESIZE, "warp_up", MapUp, true) ---Obere Warplinie
 mana.trigger_create(198 * TILESIZE, 1 * TILESIZE, 2 * TILESIZE, 198 * TILESIZE, "warp_right", MapRight, true) ---Rechte Warplinie
 mana.trigger_create(0 * TILESIZE, 198 * TILESIZE, 200 * TILESIZE, 2 * TILESIZE, "warp_down", MapDown, true) ---Untere Warplinie
 mana.trigger_create(0 * TILESIZE, 1 * TILESIZE, 2 * TILESIZE, 198 * TILESIZE, "warp_left", MapLeft, true) ---Linke Warplinie
end

function warp_up(obj, id)
    if(mana.being_type(obj)==TYPE_CHARACTER) then
	  local x = mana.posX(obj)
	  mana.chr_warp(obj, id, x, 197 * TILESIZE + 16) 
	end
end

function warp_right(obj, id)
    if(mana.being_type(obj)==TYPE_CHARACTER) then
	  local y = mana.posY(obj)
	  mana.chr_warp(obj, id, TILESIZE + 16, y) 
	end
end

function warp_down(obj, id)
    if(mana.being_type(obj)==TYPE_CHARACTER) then
	  local x = mana.posX(obj)
	  mana.chr_warp(obj, id, x, TILESIZE + 16) 
	end
end

function warp_left(obj, id)
    if(mana.being_type(obj)==TYPE_CHARACTER) then
	  local y = mana.posY(obj)
	  mana.chr_warp(obj, id, 198 * TILESIZE + 16, y) 
	end
end
