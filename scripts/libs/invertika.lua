----------------------------------------------------------------------------------
-- Invertika Modul - Grundfunktionen                                            --
--                                                                              --
-- Dieses Modul stellt Grundfunktionen zur Verfügung					        --
--                                                                              --
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

module("invertika", package.seeall)

require "scripts/lua/npclib"

--- Gibt ein zufällig eines der übergebenen Argumente zurück
function get_random_element(...)
  local arrayCount = table.getn( arg ) -- Anzahl der Elemente  ermitteln
  local r = math.random(1, arrayCount)
  return arg[r]
end

-- Initialisisert einen Queststatus
function init_quest_status(ch, questname)
    if tonumber(get_quest_var(ch, questname)) == nil then
        mana.chr_set_quest(ch, questname, 0)
    end
end

-- Setzt einen Queststatus
function set_quest_status(ch, questname, value)
    mana.chr_set_quest(ch, questname, tonumber(value))
end

-- Gibt einen Queststatus zurück
function get_quest_status(ch, questname)
  return tonumber(get_quest_var(ch, questname))
end
