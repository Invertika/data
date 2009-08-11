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
 tmw.trigger_create(0 * TILESIZE, 0 * TILESIZE, 200 * TILESIZE, 2 * TILESIZE, "warp_up", MapUp, true) ---Obere Warplinie
 tmw.trigger_create(198 * TILESIZE, 1 * TILESIZE, 2 * TILESIZE, 198 * TILESIZE, "warp_right", MapRight, true) ---Rechte Warplinie
 tmw.trigger_create(0 * TILESIZE, 198 * TILESIZE, 200 * TILESIZE, 2 * TILESIZE, "warp_down", MapDown, true) ---Untere Warplinie
 tmw.trigger_create(0 * TILESIZE, 1 * TILESIZE, 2 * TILESIZE, 198 * TILESIZE, "warp_left", MapLeft, true) ---Linke Warplinie
end

function warp_up(obj, id)
    if(tmw.being_type(obj)==TYPE_CHARACTER) then
	  local x = tmw.posX(obj)
	  tmw.chr_warp(obj, id, x, 197 * TILESIZE) 
	end
end

function warp_right(obj, id)
    if(tmw.being_type(obj)==TYPE_CHARACTER) then
	  local y = tmw.posY(obj)
	  tmw.chr_warp(obj, id, 2 * TILESIZE, y) 
	end
end

function warp_down(obj, id)
    if(tmw.being_type(obj)==TYPE_CHARACTER) then
	  local x = tmw.posX(obj)
	  tmw.chr_warp(obj, id, x, 2 * TILESIZE) 
	end
end

function warp_left(obj, id)
    if(tmw.being_type(obj)==TYPE_CHARACTER) then
	  local y = tmw.posY(obj)
	  tmw.chr_warp(obj, id, 197 * TILESIZE, y) 
	end
end