----------------------------------------------------------------------------------
-- Datetime Bibliothek                                                          --
--                                                                              --
-- Die DateTime Bibliothek stellt Funktionen zur Zeit                           --
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

module("datetime", package.seeall)

require "scripts/lua/npclib"

--- Konstanten
YEAR_ZERO_REALITY = 2008;
YEAR_ZERO_GAME = 12480;

--- Aktuelles Spiele Jahr zurückgeben
function get_current_year()	
	local currentTime = os.date('*t')
	return YEAR_ZERO_GAME + (currentTime.year-YEAR_ZERO_REALITY)
end

--- Aktuelles Spiele Zeit zurückkgeben
function get_current_time()	
	local currentTime = os.date('*t')
	return string.format("%02d:%02d", currentTime.hour, currentTime.min)
end

--- Aktuelles Spiele Datum zurückkgeben
function get_current_date()	
	local currentTime = os.date('*t')
	return string.format("%02d.%02d.%04d", currentTime.day, currentTime.month, get_current_year())
end

---Aktuelles Spieledatum als DateTime Objekt
function get_current_datetime()	
	return os.date('*t')
end

--- Aktuellen Spiele Wochentag zurückkgeben
function get_current_weekday()	
	local currentTime = os.date('*t')
	
	if(currentTime.wday==1) then
	  return "Sonntag"
	elseif(currentTime.wday==2) then
	  return "Montag"
	elseif(currentTime.wday==3) then
	  return "Dienstag"
	elseif(currentTime.wday==4) then
	  return "Mittwoch"
	elseif(currentTime.wday==5) then
	  return "Donnerstag"
	elseif(currentTime.wday==6) then
	  return "Freitag"
	elseif(currentTime.wday==7) then
	  return "Samstag"
	end
end

--- Prüfen, ob der day-te Tag des Monats month ist
function is_current_day(day, month)
	local currentTime = os.date('*t')
	if((currentTime.day==day) and (currentTime.month==month)) then
	  return true
	else
	  return false
	end
end
