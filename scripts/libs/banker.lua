-- Modul banker
-- http://wiki.invertika.org/Banker (Lua Modul)

module("banker", package.seeall)

require "scripts/lua/npclib"

-- Konstanten
INTEREST_PER_SECOND = 0.00004 -- Zinsen pro Sekunde
INTEREST_PER_YEAR = 4 -- Zinsen pro Jahr (in Prozent)

-- Die Funktion dient der Abfrage des Kontostandes. Dabei wird beachtet ob die entsprechende Variable existiert. Ist dies nicht der Fall so wird sie angelegt.
-- @param ch Zeiger auf den Charakter
function bank_get_account_balance(ch)	
	local acc_bal = get_quest_var(ch, "bank_account_balance")
	
	if acc_bal=="" then
		mana.chr_set_quest(ch, "bank_account_balance", 0)
		return 0
	else
		return tonumber(acc_bal)
	end
end

-- Die Funktion berechnet die Zinsen des Bankguthabens in Abhängikeit der verstrichenden Zeit.
-- @param ch Zeiger auf den Charakter
function bank_calc_interest(ch)
 local currentTime = os.time(t)
 local lastTime = get_quest_var(ch, "bank_last_visit")
 
 local acc_bal = get_quest_var(ch, "bank_account_balance")
 
 if acc_bal ~= 0 then
	 if lastTime ~= "" then
	   local timeDifference=currentTime-lastTime
	    
	   if timeDifference ~=  0 then	  
	      local percents=(INTEREST_PER_YEAR/100)+1
		  local yearLength=(timeDifference*3.16887646E10-8); -- Sekunden in Jahre umrechnen
	      acc_bal = acc_bal * (z-percents^yearLength); -- Betrag mit Zinseszins berechnen
		  mana.chr_set_quest(ch, "bank_account_balance", acc_bal)		  
	   end
	 end
 end
 
 mana.chr_set_quest(ch, "bank_last_visit",  currentTime)
 return newMoney
end

-- Diese Funktion liefert einen Dialog mit dem momentanen Guthaben zurück.
-- @param npc Zeiger auf den NPC
-- @param ch Zeiger auf den Charakter
function bank_get_account_balance_dlg(npc, ch)
	local newMoney = bank_calc_interest(ch)
	local acc_bal = bank_get_account_balance(ch)
	do_message(npc, ch, "Dein Guthaben beläuft sich auf "..tostring(acc_bal).." Aki. Seit dem letzten Mal hast du "..tostring(newMoney).." Aki an Zinsen erhalten.")
	do_npc_close(npc, ch)
end

-- Diese Funktion liefert einen Dialog zum Einzahlen von Geld auf das Bankkonto.
-- @param npc Zeiger auf den NPC
-- @param ch Zeiger auf den Charakter
-- @param money Geldsumme welche eingezahlt werden soll
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

-- Diese Funktion liefert einen Dialog zum Auszahlen von Geld vom Bankkonto.
-- @param npc Zeiger auf den NPC
-- @param ch Zeiger auf den Charakter
-- @param money Geldsumme welche ausgezahlt werden soll
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

-- Diese Funktion liefert einen Dialog plus NPC namens Banker welcher die Bankgeschäfte mit dem Spieler abwickelt.
-- @param npc Zeiger auf den NPC
-- @param ch Zeiger auf den Charakter
function banker_talk(npc, ch)
  do_message(npc, ch, "Willkommen bei der Zentralbank von Amoneus. Was kann ich für dich tun?")
  
 while true do 
	local v = do_choice(npc, ch, "Kontostand abfragen.",
							   "Geld auf das Konto einzahlen.",
							   "Geld vom Konto abheben.",
							   "Einen Kredit aufnehmen.",
							   "Einen Kredit abbezahlen.",
                 "Scheck einlösen.",
                 "Scheck ausstellen.",
							   "Was bringt mir die Bank?",
							   "Auf Wiedersehen.")
							  

	if v == 1 then --- Kontostand abfragen
		bank_get_account_balance_dlg(npc, ch)
	elseif v == 2 then --- Geld auf Konto einzahlen  
		local v2 = do_choice(npc, ch, "Nichts", "500", "1000", "2000", "5000", "10000", "25000", "50000", "Alles")
		if v2 == 2 then --- 500
			bank_pay_money_to_account_dlg(npc, ch, 500)
		elseif v2 == 3 then --- 1000
			bank_pay_money_to_account_dlg(npc, ch, 1000)
		elseif v2 == 4 then --- 2000
			bank_pay_money_to_account_dlg(npc, ch, 2000)
		elseif v2 == 5 then --- 5000
			bank_pay_money_to_account_dlg(npc, ch, 5000)
		elseif v2 == 6 then --- 10000
			bank_pay_money_to_account_dlg(npc, ch, 10000)
		elseif v2 == 7 then --- 25000
			bank_pay_money_to_account_dlg(npc, ch, 25000)
		elseif v2 == 8 then --- 50000
			bank_pay_money_to_account_dlg(npc, ch, 50000)
		elseif v2 == 9 then --- 50000
			bank_pay_money_to_account_dlg(npc, ch, mana.chr_money(ch))
		end
	elseif v == 3 then --- Geld von Konto abheben
		local v2 = do_choice(npc, ch, "Nichts", "500", "1000", "2000", "5000", "10000", "25000", "50000", "Alles")
		if v2 == 2 then --- 500
			bank_get_money_from_account_dlg(npc, ch, 500)
		elseif v2 == 3 then --- 1000
			bank_get_money_from_account_dlg(npc, ch, 1000)
		elseif v2 == 4 then --- 2000
			bank_get_money_from_account_dlg(npc, ch, 2000)
		elseif v2 == 5 then --- 5000
			bank_get_money_from_account_dlg(npc, ch, 5000)
		elseif v2 == 6 then --- 10000
			bank_get_money_from_account_dlg(npc, ch, 10000)
		elseif v2 == 7 then --- 25000
			bank_get_money_from_account_dlg(npc, ch, 25000)
		elseif v2 == 8 then --- 50000
			bank_get_money_from_account_dlg(npc, ch, 50000)
		elseif v2 == 9 then --- Alles
			bank_get_money_from_account_dlg(npc, ch, bank_get_account_balance(ch))
		end
	elseif v == 4 then --- Kredit aufnehmen
		do_message(npc, ch, "Kredite werden noch nicht vergeben!")
	elseif v == 5 then --- Kredit abbezahlen
		do_message(npc, ch, "Du hast keinen Kredit!")
	elseif v == 6 then --- Scheck einlösen
		do_message(npc, ch, "Scheck mit welchem Wert einlösen?")
		local v2 = do_choice(npc, ch, "500", "1000", "2000", "5000", "10000", "25000", "50000","Abbrechen")
    local acc_bal = bank_get_account_balance(ch)
    if v2 == 1 then --- 500
      if mana.chr_inv_count(ch, 40017) >= 1 then
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal+500)
        mana.chr_inv_change(ch, 40017, -1)
        do_message(npc, ch, "Das Geld befindet sich jetzt auf deinem Konto.")
      else
        do_message(npc, ch, "Du hast keinen solchen Scheck!")
      end
		elseif v2 == 2 then --- 1000
      if mana.chr_inv_count(ch, 40018) >= 1 then
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal+1000)
        mana.chr_inv_change(ch, 40018, -1)
        do_message(npc, ch, "Das Geld befindet sich jetzt auf deinem Konto.")
      else
        do_message(npc, ch, "Du hast keinen solchen Scheck!")
      end
		elseif v2 == 3 then --- 2000
      if mana.chr_inv_count(ch, 40019) >= 1 then
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal+2000)
        mana.chr_inv_change(ch, 40019, -1)
        do_message(npc, ch, "Das Geld befindet sich jetzt auf deinem Konto.")
      else
        do_message(npc, ch, "Du hast keinen solchen Scheck!")
      end
		elseif v2 == 4 then --- 5000
      if mana.chr_inv_count(ch, 40020) >= 1 then
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal+5000)
        mana.chr_inv_change(ch, 40020, -1)
        do_message(npc, ch, "Das Geld befindet sich jetzt auf deinem Konto.")
      else
        do_message(npc, ch, "Du hast keinen solchen Scheck!")
      end
		elseif v2 == 5 then --- 10000
      if mana.chr_inv_count(ch, 40021) >= 1 then
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal+10000)
        mana.chr_inv_change(ch, 40021, -1)
        do_message(npc, ch, "Das Geld befindet sich jetzt auf deinem Konto.")
      else
        do_message(npc, ch, "Du hast keinen solchen Scheck!")
      end
		elseif v2 == 6 then --- 25000
      if mana.chr_inv_count(ch, 40022) >= 1 then
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal+25000)
        mana.chr_inv_change(ch, 40022, -1)
        do_message(npc, ch, "Das Geld befindet sich jetzt auf deinem Konto.")
      else
        do_message(npc, ch, "Du hast keinen solchen Scheck!")
      end
		elseif v2 == 7 then --- 50000
      if mana.chr_inv_count(ch, 40023) >= 1 then
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal+50000)
        mana.chr_inv_change(ch, 40023, -1)
        do_message(npc, ch, "Das Geld befindet sich jetzt auf deinem Konto.")
      else
        do_message(npc, ch, "Du hast keinen solchen Scheck!")
      end
    elseif v2 == 8 then
      --- abbrechen
		end
	elseif v == 7 then --- Scheck ausstellen
		do_message(npc, ch, "Scheck mit welchem Wert ausstellen?")
		local v2 = do_choice(npc, ch, "500", "1000", "2000", "5000", "10000", "25000", "50000", "Abbrechen")
    local acc_bal = bank_get_account_balance(ch)
    if v2 == 1 then --- 500
      if acc_bal >= 500 then
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal-500)
        mana.chr_inv_change(ch, 40017, 1)
        do_message(npc, ch, "Bitte sehr, hier ist dein Scheck.")
      else
        do_message(npc, ch, "Dein Bankguthaben reicht dafür nicht aus!")
      end
    elseif v2 == 2 then
		  if acc_bal >= 1000 then --- 1000
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal-1000)
        mana.chr_inv_change(ch, 40018, 1)
        do_message(npc, ch, "Bittesehr, hier ist dein Scheck.")
      else
        do_message(npc, ch, "Dein Bankguthaben reicht dafür nicht aus!")
      end
    elseif v2 == 3 then
		  if acc_bal >= 2000 then --- 2000
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal-2000)
        mana.chr_inv_change(ch, 40019, 1)
        do_message(npc, ch, "Bitte sehr, hier ist dein Scheck.")
      else
        do_message(npc, ch, "Dein Bankguthaben reicht dafür nicht aus!")
      end
    elseif v2 == 4 then
		  if acc_bal >= 5000 then --- 5000
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal-5000)
        mana.chr_inv_change(ch, 40020, 1)
        do_message(npc, ch, "Bitte sehr, hier ist dein Scheck.")
      else
        do_message(npc, ch, "Dein Bankguthaben reicht dafür nicht aus!")
      end
    elseif v2 == 5 then
		  if acc_bal >= 10000 then --- 10000
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal-10000)
        mana.chr_inv_change(ch, 40021, 1)
        do_message(npc, ch, "Bittesehr, hier ist dein Scheck.")
      else
        do_message(npc, ch, "Dein Bankguthaben reicht dafür nicht aus!")
      end
    elseif v2 == 6 then
		  if acc_bal >= 25000 then --- 25000
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal-25000)
        mana.chr_inv_change(ch, 40022, 1)
        do_message(npc, ch, "Bitte sehr, hier ist dein Scheck.")
      else
        do_message(npc, ch, "Dein Bankguthaben reicht dafür nicht aus!")
      end
    elseif v2 == 7 then
		  if acc_bal >= 50000 then --- 50000
        mana.chr_set_quest(ch, "bank_account_balance", acc_bal-50000)
        mana.chr_inv_change(ch, 40023, 1)
        do_message(npc, ch, "Bitte sehr, hier ist dein Scheck.")
      else
        do_message(npc, ch, "Dein Bankguthaben reicht dafür nicht aus!")
      end
    elseif v2 == 8 then
      --- abbrechen
		end
	elseif v == 8 then --- Was bringt mir die Bank
		do_message(npc, ch, "In der Zentralbank von Amoneus kannst du Geld einzahlen und es von uns aufbewahren lassen. Auf das eingezahlte Geld erhälst du Zinsen.")
	elseif v == 9 then --- Auf Wiedersehen.
		do_message(npc, ch, "Einen schönen Tag noch.")
		break
	end
  end
  do_npc_close(npc, ch)
end
