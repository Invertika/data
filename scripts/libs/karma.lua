----------------------------------------------------------------------------------
-- Karma Skript                                                                 --
--                                                                              --
-- Das Karmaskript stellt die Karma Funktionen                                  --
-- zur Verfügung                                                                --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2009 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("karma", package.seeall)

require "scripts/lua/npclib"

--- Konstanten
KARMA_DEVIL = -666
KARMA_BAD = -250
KARMA_NEUTRAL = 0
KARMA_GOOD = 250
KARMA_ANGEL = 666

--- Karma Wert abfragen
function get_karma_score(ch)	
	local karma_score = get_quest_var(ch, "karma_score")
	
	if karma_score=="" then
		chr_set_quest(ch, "karma_score", 0)
		return 0
	else
		return tonumber(karma_score)
	end
end

--- Erhöht den Karmawert
function increase_karma_score(ch, value)	
	local karma_score = get_karma_score(ch)
	chr_set_quest(ch, "karma_score", karma_score+value)
end

--- Senkt den Karmawert
function decrease_karma_score(ch, value)	
	local karma_score = get_karma_score(ch)
	chr_set_quest(ch, "karma_score", karma_score-value)
end