----------------------------------------------------------------------------------
-- Death Skript                                                                 --
--                                                                              --
-- Dieses Modull stellt Funktionen für den Tod der Spielfigur zur Verfügung     --
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

module("death", package.seeall)

require "scripts/lua/npclib"
require "scripts/ivklibs/nethek"

--- Konstanten
PERCENT_MONEY_REDUCE_PER_DEATH = 15 --- Prozent des Bargeldes welches abgezogen wird beim Tod

--- Zählt die Anzahl der Tode
function increase_death_counter(ch)
	local death_counter = get_quest_var(ch, "death_counter")
	
	if death_counter=="" then
		mana.chr_set_quest(ch, "death_counter", 1)
	else
		death_counter = death_counter+1
		mana.chr_set_quest(ch, "death_counter", death_counter)
	end
end

--- Gibt die Anzahl der Tode zurück
function get_death_counter(ch)
	local death_counter = get_quest_var(ch, "death_counter")

	if death_counter=="" then
		return 0
	else
		return tonumber(death_counter)
	end
end

--- Berechnet eine bestimmte Menge Geld für den Tod
--- und zieht sie dem Spieler ab
function pay_death_price(ch)
	local PlayerMoney=mana.chr_money(ch)
	local DeathPay=PlayerMoney / 100 * PERCENT_MONEY_REDUCE_PER_DEATH
    mana.chr_money_change(ch, -DeathPay)
end