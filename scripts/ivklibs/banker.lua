----------------------------------------------------------------------------------
-- Banker Skript                                                                --
--                                                                              --
-- Das Bankerskript stellt die Bankerfunktion zur Verfügung                     --
-- (Kontoverwaltung etc.)                                                       --
----------------------------------------------------------------------------------
--  Copyright 2008 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("banker", package.seeall)

require "scripts/lua/npclib"

--- Konstanten
INTEREST_PER_SECOND = 0.00004 --- Zinsen pro Sekunde

--- Kontostand abfragen
function bank_get_account_balance(ch)	
	local acc_bal = get_quest_var(ch, "bank_account_balance")
	
	if acc_bal=="" then
		mana.chr_set_quest(ch, "bank_account_balance", 0)
		return 0
	else
		return tonumber(acc_bal)
	end
end

--- Zinsen in Abhängikeit der Zeit aufrechnen
function bank_calc_interest(ch)
 local currentTime = os.time(t)
 local lastTime = get_quest_var(ch, "bank_last_visit")
 local acc_bal = get_quest_var(ch, "bank_account_balance")
 local newMoney=0
 if acc_bal ~= 0 then
	 if lastTime ~= "" then
	   local timeDifference=currentTime-lastTime
	   
	   if timeDifference ~=  0 then	  
		  newMoney = math.floor(INTEREST_PER_SECOND * timeDifference)
		  mana.chr_set_quest(ch, "bank_account_balance", acc_bal+newMoney)		  
	   end
	 end
 end
 
 mana.chr_set_quest(ch, "bank_last_visit",  currentTime)
 return newMoney
end

--- Kontostand abfragen / Dialog
function bank_get_account_balance_dlg(npc, ch)
	local newMoney = bank_calc_interest(ch)
	local acc_bal = bank_get_account_balance(ch)
	do_message(npc, ch, "Dein Guthaben beläuft sich auf "..tostring(acc_bal).." GM. Seit dem letzten Mal hast du "..tostring(newMoney).." GM an Zinsen erhalten.")
	do_npc_close(npc, ch)
end

--- Geld auf Konto einzahlen / Dialog
function bank_pay_money_to_account_dlg(npc, ch, money)
	bank_calc_interest(ch)
	local PlayerMoney=mana.chr_money(ch)
	
	if PlayerMoney >= money then
		mana.chr_money_change(ch, -money)
		local acc_bal = bank_get_account_balance(ch) 
		mana.chr_set_quest(ch, "bank_account_balance", acc_bal+money)
		do_message(npc, ch, "Das Geld wurde auf dein Konto eingezahlt!")
	else
		do_message(npc, ch, "Soviel Geld hast du nicht!")	
	end
	do_npc_close(npc, ch)
end

--- Geld von Konto abheben
function bank_get_money_from_account_dlg(npc, ch, money)
	bank_calc_interest(ch)
	local acc_bal = bank_get_account_balance(ch)
	if acc_bal >= money then
		mana.chr_money_change(ch, money)
		local new_money=acc_bal-money
		mana.chr_set_quest(ch, "bank_account_balance",  new_money)
		do_message(npc, ch, "Das Geld wurde dir ausgezahlt!")
	else
		do_message(npc, ch, "Soviel Guthaben hast du nicht!")
	end
	do_npc_close(npc, ch)
end

--- NPC Talk Funktion
function banker_talk(npc, ch)
  do_message(npc, ch, "Willkommen bei der Zentralbank von Amoneus. Was kann ich für dich tun?")
  
 while true do 
	local v = do_choice(npc, ch, "Kontostand abfragen.",
							   "Geld auf das Konto einzahlen.",
							   "Geld vom Konto abheben.",
							   "Einen Kredit aufnehmen.",
							   "Einen Kredit abbezahlen.",
							   "Was bringt mir die Bank?",
							   "Auf Wiedersehen.")
							  

	if v == 1 then --- Kontostand abfragen
		bank_get_account_balance_dlg(npc, ch)
	elseif v == 2 then --- Geld auf Konto einzahlen  
		local v2 = do_choice(npc, ch, "500", "1000", "2000", "5000", "10000", "25000", "50000", "Alles")
		if v2 == 1 then --- 500
			bank_pay_money_to_account_dlg(npc, ch, 500)
		elseif v2 == 2 then --- 1000
			bank_pay_money_to_account_dlg(npc, ch, 1000)
		elseif v2 == 3 then --- 2000
			bank_pay_money_to_account_dlg(npc, ch, 2000)
		elseif v2 == 4 then --- 5000
			bank_pay_money_to_account_dlg(npc, ch, 5000)
		elseif v2 == 5 then --- 10000
			bank_pay_money_to_account_dlg(npc, ch, 10000)
		elseif v2 == 6 then --- 25000
			bank_pay_money_to_account_dlg(npc, ch, 25000)
		elseif v2 == 7 then --- 50000
			bank_pay_money_to_account_dlg(npc, ch, 50000)
		elseif v2 == 8 then --- 50000
			bank_pay_money_to_account_dlg(npc, ch, mana.chr_money(ch))
		end
	elseif v == 3 then --- Geld von Konto abheben
		local v2 = do_choice(npc, ch, "500", "1000", "2000", "5000", "10000", "25000", "50000", "Alles")
		if v2 == 1 then --- 500
			bank_get_money_from_account_dlg(npc, ch, 500)
		elseif v2 == 2 then --- 1000
			bank_get_money_from_account_dlg(npc, ch, 1000)
		elseif v2 == 3 then --- 2000
			bank_get_money_from_account_dlg(npc, ch, 2000)
		elseif v2 == 4 then --- 5000
			bank_get_money_from_account_dlg(npc, ch, 5000)
		elseif v2 == 5 then --- 10000
			bank_get_money_from_account_dlg(npc, ch, 10000)
		elseif v2 == 6 then --- 25000
			bank_get_money_from_account_dlg(npc, ch, 25000)
		elseif v2 == 7 then --- 50000
			bank_get_money_from_account_dlg(npc, ch, 50000)
		elseif v2 == 8 then --- 50000
			bank_pay_money_to_account_dlg(npc, ch, bank_get_account_balance(ch))
		end
	elseif v == 4 then --- Kredit aufnehmen
		do_message(npc, ch, "Kredite werden noch nicht vergeben!")
	elseif v == 5 then --- Kredit abbezahlen
		do_message(npc, ch, "Du hast keinen Kredit!")
	elseif v == 6 then --- Was bringt mir die Bank
		do_message(npc, ch, "In der Zentralbank von Amoneus kannst du Geld einzahlen und es von uns aufbewahren lassen. Auf das eingezahlte Geld erhälst du Zinsen.")
	elseif v == 7 then --- Auf Wiedersehen.
		do_message(npc, ch, "Einen schönen Tag noch.")
		break
	end
  end
  do_npc_close(npc, ch)
end