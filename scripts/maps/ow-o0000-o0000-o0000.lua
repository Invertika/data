-- Externe Map Skripting Datei
-- In dieser Datei stehen die entsprechenden externen NPCs, Trigger und anderer Dinge.
--
-- © 2008-2011 by The Invertika Development Team
--
-- This file is part of Invertika. Invertika is free software; you can redistribute 
-- it and/or modify it under the terms of the GNU General  Public License as published 
-- by the Free Software Foundation; either version 3 of the License, or any later version.

require "scripts/lua/npclib"
require "scripts/libs/datetime"
require "scripts/libs/invertika"
require "scripts/libs/nethek"
require "scripts/libs/seller"
require "scripts/libs/sign"

dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(62, 72, 56, 6) --- Intermap warp
 nethek.create_netheksaeule(181 * TILESIZE, 125 * TILESIZE + 16) --- Netheksäule
 mana.trigger_create(41 * TILESIZE + 8, 105 * TILESIZE + 8, 1.5 * TILESIZE, 1.5 * TILESIZE, "warp_escape_tunnel", 0, true) --- Warp zum Fluchttunnel
 
 --Schilder
 sign.create_sign(113, 84, "Frisörsalon Umet\
Schneiden, Färben, Waschen, Perücken und mehr.") -- Schild vor dem Friseur
 sign.create_sign(131, 82, "Feinste Waffen zu günstigen Preisen\
Wir müssen darauf hinweisen, dass bei Diebstahl ein Ladenverbot verhängt wird sowie die Hand als Entschädigung dabehalten wird.") -- Schild vor dem Waffenladen
 sign.create_sign(43, 107, "Kein Trinkwasser!") -- Schild vor dem Brunnen
 sign.create_sign(146, 160, "Baden und Angeln verboten!") -- Schild vor dem Wasserloch

 -- NPCs
 create_npc("Elmo", 7, 176 * TILESIZE + 16, 154 * TILESIZE + 16, elmo_talk, nil) --- Elmo
 create_npc("Sam", 7, 183 * TILESIZE + 16, 154 * TILESIZE + 16, sam_talk, nil) --- Sam
 create_npc("Julia", 10, 170 * TILESIZE + 16, 152 * TILESIZE + 16, julia_talk, nil) --- Julia
 create_npc("Jane", 12, 182 * TILESIZE + 16, 145 * TILESIZE + 16, jane_talk, nil) --- Jane
 create_npc("Bruce", 7, 190 * TILESIZE + 16, 160 * TILESIZE + 16, bruce_talk, nil) --- Bruce
 create_npc("Felix", 42, 187 * TILESIZE + 16, 94 * TILESIZE + 16, felix_talk, nil) --- Felix
 create_npc("Saria", 10, 42 * TILESIZE + 16, 100 * TILESIZE + 16, saria_talk, nil) --- Saria
 create_npc("Nobur", 17, 186 * TILESIZE + 16, 179 * TILESIZE + 16, nobur_talk, nil) --- Nobur
 create_npc("Alex", 24, 76 * TILESIZE + 16, 10 * TILESIZE + 16, alex_talk, nil) --- Alex
 create_npc("Inard", 61, 74 * TILESIZE + 16, 142 * TILESIZE + 16, inard_talk, nil) --- Inard
 create_npc("Belart", 41, 108 * TILESIZE + 16, 132 * TILESIZE + 16, belart_talk, nil) --- Belart
 create_npc("Imangi", 67, 138 * TILESIZE + 16, 157 * TILESIZE + 16, imangi_talk, nil) --- Imangi
 create_npc("Ortana", 8, 97 * TILESIZE + 16, 49 * TILESIZE + 16, ortana_talk, nil) --- Ortana
 create_npc("Tonver", 8, 17 * TILESIZE + 16, 181 * TILESIZE + 16, tonver_talk, nil) --- Tonver
 create_npc("Elmes", 46, 114 * TILESIZE + 16, 180 * TILESIZE + 16, elmes_talk, nil) --- Elmes
 create_npc("Nepuret", 30, 90 * TILESIZE + 16, 185 * TILESIZE + 16, nepuret_talk, nil) --- Nepuret 
 create_npc("Nero", 24, 162 * TILESIZE + 16, 175 * TILESIZE + 16, nero_talk, nil) --- Nero
 create_npc("Bernie", 40, 13 * TILESIZE + 16, 9 * TILESIZE + 16, bernie_talk, nil) --- Bernie
 create_npc("Valeria", 10, 26 * TILESIZE + 16, 49 * TILESIZE + 16, valeria_talk, nil) --- Valeria
 
 create_npc("Alaria", 79, 170 * TILESIZE + 16, 182 * TILESIZE + 16, seller.seller_talk, nil) --- Verkäufer
 create_npc("Lidi", 71, 171 * TILESIZE + 16, 79 * TILESIZE + 16, lidi_talk, nil) -- Lidi
 
 create_npc("Wache", 25, 39 * TILESIZE + 16, 51 * TILESIZE + 16, colloseumwache_talk, nil) --- Colloseumwache
 create_npc("Wache", 25, 44 * TILESIZE + 16, 51 * TILESIZE + 16, colloseumwache_talk, nil) --- Colloseumwache
 
 create_npc("Wache", 29, 26 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 create_npc("Wache", 29, 31 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 create_npc("Wache", 29, 45 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 create_npc("Wache", 29, 49 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 
 create_npc("Stadtwache", 27, 110 * TILESIZE + 16, 196 * TILESIZE + 16, stadtwache_talk, nil) --- Stadtwache
 create_npc("Stadtwache", 27, 117 * TILESIZE + 16, 196 * TILESIZE + 16, stadtwache_talk, nil) --- Stadtwache
 
 wache1 = create_npc("Palastwache", 27, 143 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 create_npc("Palastwache", 27, 150 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 wache2 = create_npc("Palastwache", 27, 181 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 create_npc("Palastwache", 27, 188 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 
 --- Trigger für die Überwachung des Torbereiches
 mana.trigger_create(145 * TILESIZE, 17 * TILESIZE, 5 * TILESIZE, 52 * TILESIZE, "wache_trigger", 1, true) --- Trigger Tor 1
 mana.trigger_create(183 * TILESIZE, 17 * TILESIZE, 5 * TILESIZE, 52 * TILESIZE, "wache_trigger", 2, true) --- Trigger Tor 2

 --- Trigger für den Amulet-quest.
 mana.trigger_create(54 * TILESIZE, 10 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 1, true)
 mana.trigger_create(104 * TILESIZE, 82 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 2, true)
 mana.trigger_create(43 * TILESIZE, 116 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 3, true)
 mana.trigger_create(9 * TILESIZE, 79 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 4, true)
 mana.trigger_create(7 * TILESIZE, 60 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 5, true)
 mana.trigger_create(61 * TILESIZE, 152 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 6, true)
 mana.trigger_create(49 * TILESIZE, 182 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 7, true)
 mana.trigger_create(191 * TILESIZE, 119 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 8, true)
 mana.trigger_create(102 * TILESIZE, 141 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 9, true)
 mana.trigger_create(87 * TILESIZE, 151 * TILESIZE, TILESIZE, TILESIZE, "amulet_trigger", 10, true)
 
 ---Weihnachten
 --create_npc("Rentier", 74, 177 * TILESIZE + 16, 185 * TILESIZE + 16, rentier_talk, nil) --- Rentier
 --create_npc("Weihnachtsmann", 9, 184 * TILESIZE + 16, 185 * TILESIZE + 16, weihnachtsmann_talk, nil) --- Weihnachtsman
 
 ---Neujahr
 ---create_npc("Feuerwerker", 139, 177 * TILESIZE + 16, 185 * TILESIZE + 16, fireworker_talk, npclib.walkaround_small)
end)

--Zeitabhägige Events
-- Weihnachten
function weihnachtsmann_talk(npc, ch)
	invertika.init_quest_status(ch, "selphi_timlet_santa_clause")
  
	-- quest get/set functions
	function get_qstatus() return invertika.get_quest_status(ch, "selphi_timlet_santa_clause") end
	function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_santa_clause", x) end
  
	if get_qstatus()==0 then
	  do_message(npc, ch, "Ho Ho Ho. Ich bin der Weihnachtsmann. Meine Geschenke sind schon wieder überall verteilt. Diese Weihnachtsschleime rauben mir den letzten Nerv. Magst du mir helfen sie wieder einzusammeln?")
	
	  while true do 
	  	  local v = do_choice(npc, ch, "Ja.", "Nein.")
								   
		  if v == 1 then
			do_message(npc, ch, "Das ist super ich denke so 25 Stück sollten mir reichen. Ich warte dann hier auf dich.")
			set_qstatus(1)
			break
		  elseif v == 2 then
			do_message(npc, ch, "Schade, dann halt nicht...")
			break
		  end
	  end
	elseif get_qstatus()==1 then
	  local count13 = mana.chr_inv_count(ch, 40013)
	  local count14 = mana.chr_inv_count(ch, 40014)
	  local count15 = mana.chr_inv_count(ch, 40015)
	  
	  local countAll=count13+count14+count15;
	  
	  if countAll >= 25 then
	    --Nachricht
	    do_message(npc, ch, "Du hast es wirklich geschafft. Ich danke dir. Na das schreit ja geradezu nach einer Belohnung. Da habe ich doch einige Sachen für dich.")
	    
	    --Weihnachtsgeschenke entfernen
	    invertika.add_items(ch, 40013, -count13, "grünes Geschenk")
	    invertika.add_items(ch, 40014, -count14, "blaues Geschenk")
	    invertika.add_items(ch, 40015, -count15, "lila Geschank")
	    
	    --Belohnung
	    invertika.add_items(ch, 20010, 1, "Santa Clause Mütze")
	    invertika.add_items(ch, 30021, 10, "Zuckerstange")
	    invertika.add_items(ch, 30022, 10, "Weihnachtskuchen")
	    invertika.add_items(ch, 30023, 10, "Lebkuchenmänchen")
	    invertika.add_items(ch, 40020, 1, "5000 Aki Scheck")
	    set_qstatus(2)
	  else
	    do_message(npc, ch, invertika.get_random_element("Na ein paar Geschenke fehlen da noch.",
	     "Ich brauche mindestens 25 Geschenke.",
	     "Ein paar Weihnachtsschleime wirst du schon noch erledigen müssen."))
	  end
	elseif get_qstatus()==2 then
	  do_message(npc, ch, invertika.get_random_element("Danke für deine Hilfe. Wir sehen uns dann nächstes Jahr wieder.",
	  "So alle Geschenke wieder sicher verstaut.",
	  "Schön das du es den Weihnachtsschleimen mal gezeigt hast.",
	  "Nun habe ich für dieses Jahr wieder meine Ruhe.",
	  "Jetzt muss ich die Geschenke nur noch verteilen.",
	  "Danke für deine großartige Hilfe."))
	end
	
	do_npc_close(npc, ch)
end

function rentier_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Mmmmmpppfh.",
	    "Bsssss.",
	    "Brrrrrr.",
	    "Schnauf."))
	do_npc_close(npc, ch)
end

-- Silvester
function fireworker_talk(npc, ch)
  do_message(npc, ch, "Willst du ein wenig Feuerwerk sehen?")
  local answer = do_choice(npc, ch, "Juhuu! Feuerwerk!", "Nee, danke.")
  if answer == 1 then
    local x = mana.posX(npc)
    local y = mana.posY(npc)
      for c = 0, 25 do
        schedule_in (c, function()
          mana.effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          mana.effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          mana.effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          mana.effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          mana.effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          mana.effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
        end)
      end
  end
  do_npc_close(npc, ch)
end

-- Normale Events
 function get_wache_say()
   	 return invertika.get_random_element("Ohne Passierschein geht es hier nicht durch!",
	  "Durchgang nur mit Passierschein!",
	  "Du hast keinen Passierschein. Deshalb darfst du den Palast nicht betreten!",
	  "Halt, du benötigst einen Passierschein!")
 end

 function wache_trigger(ch, id)
   if (mana.being_type(ch) == TYPE_CHARACTER) then --- Nur Player durchlassen
	 local count = mana.chr_inv_count(ch, 40009)
	 
	 if count == 0 then
	   local x = mana.posX(ch)
	   local y = mana.posY(ch)
	   mana.chr_warp(ch, mana.get_map_id(), x, 70 * TILESIZE) 
	   
	   if (id == 1) then
	     mana.being_say(wache1, get_wache_say())
	   elseif (id == 2) then
	     mana.being_say(wache2, get_wache_say())
	   end
	 end
  end
 end
 
function elmo_talk(npc, ch)
	do_message(npc, ch, "Willkommen in Selphi Timlet, der Stadt in der Wüste. Sei nett zu den anderen und habe viel Spaß!")
	do_npc_close(npc, ch)
end

function sam_talk(npc, ch)
	do_message(npc, ch, "Hi ich bin Sam und ich bin auf der Suche nach der Antwort...")
	do_npc_close(npc, ch)
end

function julia_talk(npc, ch)
	do_message(npc, ch, "Hi, was kann ich für dich tun?")
	
	while true do 
		local v = do_choice(npc, ch, "Kaufen.",
					     "Verkaufen.",
					     "Nichts. Danke.")
								   
		if v == 1 then
			mana.npc_trade(npc, ch, false, { {10001, 10, 19}, {10013, 10, 159}, {10002, 10, 997}, {20001, 10, 30}, {20002, 10, 50}, {20011, 10, 30}, {20012, 10, 30}, {20013, 10, 30}, {20014, 10, 30}, {20015, 10, 50}, {20016, 10, 50}, {20017, 10, 50}, {20018, 10, 50}  })
			break
		elseif v == 2 then
			mana.npc_trade(npc, ch, true)
			break
		elseif v == 3 then
			do_message(npc, ch, "Ich wünsche dir noch viel Spaß!")
			break
		end
	end
	do_npc_close(npc, ch)
end

function jane_talk(npc, ch)
	do_message(npc, ch, string.format("Wie spät es ist? Ähm es ist %s Uhr. Und bevor du fragst, heute ist der %s im übrigen ist das ein %s.", datetime.get_current_time(), datetime.get_current_date(), datetime.get_current_weekday()))
	do_npc_close(npc, ch)
end

function bruce_talk(npc, ch)
  -- quest init
  invertika.init_quest_status(ch, "selphi_timlet_bruce_quest")
  -- quest get/set functions
  function get_qstatus() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_bruce_quest")) end
  function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_bruce_quest", tonumber(x)) end
  
	if get_qstatus()==0 then
		invertika.add_money(ch, 1000)
		set_qstatus(1)
		do_message(npc, ch, "Ahhh ich verstehe, du bist neu hier. Hier ein paar Münzen fuer den Anfang...")		
	elseif get_qstatus()==1 then
    do_message(npc, ch, "Siehst du die Maden auf den Straßen? Die reinste Plage! Dieses gefräßige Ungeziefer vernichtet das letzte bisschen Vegetation in der Stadt! Willst du uns helfen, unsere schöne Stadt von diesen ekelhaften Würmern zu befreien?")
    set_qstatus(do_choice(npc, ch, "Nein.","Ja."))
  end
  if get_qstatus()==2 then
    do_message(npc, ch, "Bring mir 20 Madenschleim als Beleg für deine Arbeit, dann werde ich dich belohnen.")
    set_qstatus(3)
  elseif get_qstatus()==3 and mana.chr_inv_count(ch, 40005) < 20 then
    do_message(npc, ch, "Bring mir 20 Madenschleim als Beleg für deine Arbeit, dann werde ich dich belohnen.")
  elseif get_qstatus()==3 and mana.chr_inv_count(ch, 40005) >= 20 then
    do_message(npc, ch, "Fabelhaft, du hast 20 Madenschleim gesammelt! Danke für deine Hilfe.")
    invertika.add_items(ch, 40005, -20, "Madenschleim")
    mana.chr_give_exp(ch, 100, 750)
    mana.chatmessage(ch, "Du hast 750 Exp im unbewaffneten Kampf erhalten!")
    set_qstatus(4)
  elseif get_qstatus()==4 then
    do_message(npc, ch, "In der Spielothek findet Danielas Geburtstagsparty statt. Bist du so nett, und bringst ihr mein Geschenk? Ich habe dort Hausverbot, weil ich meine Spielschulden nicht bezahlt habe.")
    set_qstatus(do_choice(npc, ch, "Nein.","Ja.")+3)
    if get_qstatus()==5 then
      invertika.add_items(ch, 40015, 1, "Geschenk")
      do_message(npc, ch, "Sehr nett von dir. Die Spielothek ist im süd-westlichen Teil der Stadt. Gib Daniela das Geschenk.")
    end
  elseif get_qstatus()==5 then
    do_message(npc, ch, "Die Spielothek ist im süd-westlichen Teil der Stadt. Gib Daniela das Geschenk.")
  elseif get_qstatus()==6 then
    do_message(npc, ch, "Sie hat sich über ihr Geschenk gefreut? Danke, du hast mir sehr geholfen! Nimm diese Flasche Pangalaktischen Donnergurgler als Dank.")
    invertika.add_items(ch, 30008, 1, "Flasche Pangalaktischen Donnergurgler")
    set_qstatus(7)
  elseif get_qstatus()==7 then
    do_message(npc, ch, "Lust auf eine neue Herausforderung?")
    invertika.add_items(ch, 40002, 1, "IP-Paket")
    set_qstatus(8)
    do_message(npc, ch, "Ich brauche 50 Skorpionstachel, um ein Faß Wurzelhans zu brauen. Lass dich nicht stechen.")
  elseif get_qstatus()==8 then
    if mana.chr_inv_count(ch, 40004) >= 50 then
      do_message(npc, ch, "Das hast du gut gemacht! Nimm diesen Hut als Dank!")
      invertika.add_items(ch, 40004, -50, "Skorpionstachel")
      invertika.add_items(ch, 20004, 1, "Hut")
      set_qstatus(9)
    else
      do_message(npc, ch, "Ich brauche 50 Skorpionstachel. Nicht mehr, und nicht weniger!")
    end
  elseif get_qstatus() == 9 then
    do_message(npc, ch, "*hust* *hust* *räusper*")
    do_message(npc, ch, "Mir geht es nicht so gut.")
    do_message(npc, ch, "Ich muss mir wohl hier in der prallen Hitze eine Erkältung eingefangen haben...")
    do_message(npc, ch, "Wäre nett wenn du mir ein paar Tabletten besorgen könntest.")
    do_message(npc, ch, "Diese Energetia sollten ihre Aufgabe tun.")
    do_message(npc, ch, "Besorg mir doch bitte ein paar von ihnen.")
    set_qstatus(10)
  elseif get_qstatus() == 10 then
    local count = mana.chr_inv_count(ch, 30018)
    if count >= 3 then
        do_message(npc, ch, "Du hast die Tabletten gegen meinen Husten.")
        do_message(npc, ch, "Gibst du sie mir?")
        while true do
            local v = do_choice(npc, ch, "Ja.", "Nein.")
            if v == 1 then
                if invertika.add_items(ch, 30018, -3, "Energetia") then
                    set_qstatus(11)
                    do_message(npc, ch, "Danke. Das wird meinem Husten helfen.")
                    do_message(npc, ch, "Nimm dies als Unkostenerstattung.")
                    invertika.add_money(ch, 700)
                end
                break
            else
                do_message(npc, ch, "Schade.")
                break
            end
        end
    elseif count > 0 then
        do_message(npc, ch, "Mit so wenigen Tabletten komme ich nicht weit. *Hust*")
    else
        do_message(npc, ch, "*Hust* *räusper* Hol mir doch bitte ein paar *hust* Tabeletten gegen meinen Husten.")
        do_message(npc, ch, "Diese Energetia sollten es tun.")
    end
  elseif get_qstatus()>=11 then
    do_message(npc, ch, "Ich habe momentan keine Aufgabe für dich.")
  end

  do_npc_close(npc, ch)
end

function felix_talk(npc, ch)
    local quest_string = "selphi_timlet_felix_quest"
    invertika.init_quest_status(ch, quest_string)
    local get_qstatus = function() return invertika.get_quest_status(ch, quest_string) end
    local set_qstatus = function(x) invertika.set_quest_status(ch, quest_string, x) end
    
    if get_qstatus() == 0 then
        do_message(npc, ch, invertika.get_random_element("Hallo Reisender.", "Guten Tag.", "Hallo.", "Schönes Wetter nicht?"))
        do_message(npc, ch, "Hättest du Lust für mich etwas zu erledigen?")
        while true do
            local v = do_choice(npc, ch, "Ja.", "Nein.")
            if v == 1 then
                do_message(npc, ch, "Ich habe einen alten Freund. Er ist Statiker in Alexia und berechnet Häuser. Sein Name ist Vektor.")
                do_message(npc, ch, "Er ist zwar nicht der beste aber andere kann ich nicht bezahlen. Er soll das Haus meines Bruders berechnen.")
                do_message(npc, ch, "Falls du mal nach Alexia kommst kannst du ihm mal Bescheid sagen.")
                do_message(npc, ch, "Wobei ich die Statik total überbewertet finde.")
                do_message(npc, ch, "Alles muss genau passen...")
                do_message(npc, ch, "Dabei interressiert mich reichlich wenig ob ich weiß, dass mein Haus bei 1kg Schnee pro m² zusammenbricht oder nicht. Wann gibt es hier in der Wüste mal Schnee?")
                do_message(npc, ch, "Völlig überbezahlt der Beruf!")
                do_message(npc, ch, "Ja, so ist das wohl.")
                do_message(npc, ch, "Was stehst du hier noch? Du wolltest doch nach Alexia, oder?")
                set_qstatus(1)
                break
            elseif v == 2 then
                break
            end
        end
    elseif get_qstatus() == 1 then
        do_message(npc, ch, "Wolltest du nicht nach Alexia?")
    elseif get_qstatus() == 2 then
        do_message(npc, ch, "Danke, dass du Vektor Bescheid gesagt hast.")
        do_message(npc, ch, "Ich habe hier ein wenig Porzellan Geschirr von Übersee.")
        do_message(npc, ch, "Nix Wert das Zeug. Nimm du es.")
        invertika.add_items(ch, 40039, 27, "Teller aus Porzellan")
        set_qstatus(3)
    else
	    do_message(npc, ch, invertika.get_random_element("Ja so ist das wohl.",
	      "Ich weiß nicht, so schönes Wetter.",
	      "Ein Königreich für einen Keks.",
	      "Mmm was mache ich jetzt bloß ohne Regenschirm.",
	      "Ich muss es tun, jetzt sofort.",
	      "Die da du di da?",
	      "Wie bitte?",
	      "Nicht zu fassen. Überall diese Dingsbums.",
	      "Kommt der Sommer schnell und heiß, ähm dann weiß ich auch nicht.",
	      "Invertika, ja da war was.",
	      "Kann schon sein, muss aber nicht.",
	      "Es könnte sein das es stimmt, dann müsste der Fakt das es nicht stimmt aber eine große Rolle spielen da es ja stimmt und gleichzeitig nicht stimmt. Mhn... aber was wäre wenn...",
	      "Ich bin Felix und wer bist du?",
	      "Mus mus mus. Jaaaaa. Biene fliegt rückwärts.",
	      "Mein Kontrabass ist kaputt, aber es lag nicht am Backofen.",
	      "Durch die Sonne scheint es immer hell.",
	      "Es ist groß und grün.",
	      "Je gelber das Telefon desto Hallo. Doch was ist ein Telefon?",
	      "Der Frosch wurde rot, denn er war tot.",
	      "Fische füttern fördert den Verstand."))
    end
	  do_npc_close(npc, ch)
end

function saria_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Die Wüste ist riesig, drum bleib ich hier.",
	  "Hüte dich vor der Wüste. Dort treiben rote Skorpione ihr Unwesen.",
	  "Ey da nicht anfassen, da habe ich einen Sonnenbrand.",
	  "Alle meine Skorpione, sind in der Wüste.",
	  "Ich liebe Städte mit Mauern.",
	  "Ich würde mal gerne zum Meer."))
	  do_npc_close(npc, ch)
end

function nobur_talk(npc, ch)
        invertika.init_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers")

	do_message(npc, ch, "Ich brauche Skorpionstachel. Eine ganze Menge, so zwei Dutzend oder drei, vielleicht auch vier Dutzend. Das wird eine leckere Suppe.")
	
	local count = mana.chr_inv_count(ch, 40004) 
	
	if count > 0 then
	  do_message(npc, ch, "Ich sehe du hast ein paar Stachel. Magst du sie mir geben?")
	  
	  	while true do 
		local v = do_choice(npc, ch, "Ja",
								     "Nein")
								   
		if v == 1 then
			if (invertika.get_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers") == 0) then
			  invertika.set_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers", count)
			else
			  local dbcount = invertika.get_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers");
			  dbcount = dbcount + count
			  invertika.set_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers", dbcount)
			  
			  if dbcount > 200 then
			    do_message(npc, ch, "Also wenn ich es mir recht überlege, habe ich schon genug Stachel. Trotzdem danke.")
				break;
			  end
			end
			
			invertika.add_items(ch, 40004, -count, "Skorpionstachel")
		
			if count < 10 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  invertika.add_money(ch, 50) 
			  break;
			elseif count < 20 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  invertika.add_money(ch, 150) 
			  break;
			elseif count < 30 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  invertika.add_money(ch, 350) 
			  break;
			elseif count < 40 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  invertika.add_money(ch, 500) 
			  break;
			elseif count < 150 then
			  do_message(npc, ch, "Nimm diesen lustigen Hut als Dankeschön.")
			  invertika.add_items(ch, 20004, 1, "lustiger Hut")
			  break;
			elseif count >= 150 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  invertika.add_money(ch, 2500) 
			  break;
			end
			
			break
		elseif v == 2 then
			do_message(npc, ch, "Okay dann muss ich weiter suchen.")
			break
		end
	end
	  
	end
	do_npc_close(npc, ch)
end

function alex_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Siehst du ihn? Ist er hier irgendwo? Nicht das es mich findet, also pssst!",
	  "Was machst du hier? Nicht das du ihn zu mir führst...",
	  "Wenn ich meine? Na Bahamut.",
	  "Ich halte es nicht mehr aus, aber hier bin ich sicher.",
	  "Siehst du ihn? Ich sehe ihn überall, hinter jeder Ecke.",
	  "Gehörst du zu ihm? Wenn ja dann verschwinde!"))
	  do_npc_close(npc, ch)
end

function inard_talk(npc, ch)
    invertika.init_quest_status(ch, "selphi_timlet_inard_training");
	invertika.init_quest_status(ch, "selphi_timlet_orkana_feierabend");
 
    -- quest get/set functions
    function get_qstatus() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_inard_training")) end
    function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_inard_training", tonumber(x)) end
	
	function get_feierabend() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_orkana_feierabend")) end

    if get_qstatus() == 0 then
        do_message(npc, ch, "Ahhh. Was ein herrlicher Tag und ich hänge hier im Innenhof rum! Wie gerne würde ich mal wieder eine Stunde trainieren!")
        while true do
            local v = do_choice(npc, ch, "Ich könnte mit dir trainieren.", "Auf Wiedersehen")
            if v == 1 then
                do_message(npc, ch, "Du? Dich kenne ich doch kaum. Aber du könntest zu Ortana laufen und ihn fragen wann er mal Zeit hat.")
                while true do
                    v2 = do_choice(npc, ch, "Mach ich!", "Da habe ich grade keine Zeit für.")
                    if v2 == 1 then
                        do_message(npc, ch, "Danke. Du findest ihn bei der Arena.")
                        set_qstatus(1)
                        break
                    elseif v2 == 2 then
                        do_message(npc, ch, "Schade.")
                        break
                    end
                end
                break
            elseif v == 2 then
                do_message(npc, ch, "Schönen Tag noch.")
                break
            end
        end
    elseif get_qstatus() == 1 then
        do_message(npc, ch, invertika.get_random_element("Wolltest du nicht zu Ortana und ihn fragen ob er Lust hat mit mir zu trainieren?",
                                                         "Ortana findest du an der Arena beim Besuchereingang."))
    elseif get_qstatus() == 2 then
        do_message(npc, ch, "Ortana weiß nicht wann er frei hat? Dann frag seinen Chef, Estech. Du findest ihn vermutlich im VIP-Bereich der Arena.")
    elseif get_qstatus() == 3 then
        do_message(npc, ch, "Das du weißt wann er frei hat bringt mir nicht viel. Geh zu ihn und frag ihn ob es ihm passt.")
    elseif get_qstatus() == 4 then
        do_message(npc, ch, "Und wann hat er Zeit?")
        while true do
            local v = do_choice(npc, ch, "Um 10 Uhr.", "Um 15 Uhr.", "Um 20 Uhr.")
            if v == get_feierabend() then
                do_message(npc, ch, "Ok. Danke. Hier nimm diesen Ring als Dank.")
                invertika.add_items(ch, 20005, 1, "Ring der Stärke")
                set_qstatus(5)
                break
            else
                do_message(npc, ch, "Das glaube ich nicht! Ortana hat nie zu dieser Zeit frei. Frag am besten nochmal nach.")
                break
            end
        end
    else
        do_message(npc, ch, invertika.get_random_element("Ach ja... Ich mach erstmal ne Pause.", "Danke für die Hilfe.", "Genug trainiert."))
    end
    do_npc_close(npc, ch)
end

function belart_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Ich komme aus Narva. Es ist schön dort. Ich vermisse es ein wenig.",
	  "Hast du schonmal Unbal getrunken? Es ist köstlich.",
	  "Ich hatte mal eine wunderschöne Rüstung. Leider musste ich sie verkaufen.",
	  "Du siehst aus als wenn du neu hier bist. Willkommen in Selphi Timlet.",
	  "Ich kannte mal jemanden der sah fast so aus wie du. Aber das ist lange her.",
	  "Mein Name ist Belart und ich komme aus Narva. Und du?"))
	  do_npc_close(npc, ch)
end

function imangi_talk(npc, ch)
    invertika.init_quest_status(ch, "twin_house_quest")
    local q_status = invertika.get_quest_status(ch, "twin_house_quest")
    if q_status == 3 then
        if mana.chr_inv_count(ch, 20019) > 0 then
            do_message(npc, ch, "Möchtest du mir etwas sagen?")
            while true do
                local v = do_choice(npc, ch, "Ich habe hier einen Ring für dich.", "Nein. nichts.")
                if v == 1 then
                    invertika.set_quest_status(ch, "twin_house_quest", 4)
                    invertika.add_items(ch, 20019, -1, "Imangis's Verlobungsring")
                    do_message(npc, ch, "Wie... ein Ring...?")
                    do_message(npc, ch, "Er möchte mich Heiraten?")
                    do_message(npc, ch, "ich... ich...")
                    do_message(npc, ch, "*nach Luft schnapp*")
                    do_message(npc, ch, "muss nachdanken!")
                    do_message(npc, ch, "Bitte sag ihm das...")
                    do_message(npc, ch, "Nimm diese Äpfel als Dank.")
                    invertika.add_items(ch, 30012, 10, "Äpfel")
                    break
                elseif v == 2 then
                    break
                end
            end
        end
    elseif (q_status == 4) or (q_status == 5) then
        do_message(npc, ch, "Ich freue mich schon ihn zu treffen.")
    else
	    do_message(npc, ch, invertika.get_random_element("Ich verkaufe nichts.",
	    "Hier gibt es nichts zu sehen.",
	    "Ich kann dir nicht helfen.",
	    "Geh weg.",
	    "Ich kenne dich nicht, also will ich auch nix mit dir zu tun haben.",
	    "Nein, nein, nein und nochmal nein."))
    end
	  do_npc_close(npc, ch)
end

function ortana_talk(npc, ch)
	invertika.init_quest_status(ch, "selphi_timlet_inard_training");
	invertika.init_quest_status(ch, "selphi_timlet_orkana_feierabend");
	
    function get_qstatus() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_inard_training")) end
    function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_inard_training", tonumber(x)) end
    function get_feierabend() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_orkana_feierabend")) end

    if get_qstatus() == 1 then
        do_message(npc, ch, "Inard möchte mit mir trainieren? Hm. Sicher hab ich Lust. Ich weiß nur nicht wann ich frei bekomme. Frag doch bitte mal meinen Chef Estech. Du findest ihn in der Arena, vermutlich im VIP-Bereich.")
        set_qstatus(2)
    elseif get_qstatus() == 2 then
        do_message(npc, ch, "Frag meinen Chef Estech. Der kann dir sagen wann ich frei habe. Du findest ihn in der Arena.")
    elseif get_qstatus() == 3 then
        do_message(npc, ch, "Und was meinte er wann ich gehen dürfte?")
        while true do
            local v = do_choice(npc, ch, "Um 10 Uhr.", "Um 15 Uhr.", "Um 20 Uhr.")
            if v == get_feierabend() then
                do_message(npc, ch, "Danke. Sag Inard das ich komme.")
                set_qstatus(4)
                break
            else
                do_message(npc, ch, "Das glaube ich nicht! Ich habe nie zu dieser Zeit frei. Frag am besten nochmal nach.")
                break
            end
        end
    elseif get_qstatus() == 4 then
        local zeit = nil
        if get_feierabend() == 1 then
            zeit = "10"
        elseif get_feierabend() == 2 then
            zeit = "15"
        else
            zeit = "20"
        end
        do_message(npc, ch, string.format("Wann war das nochmal? Ach genau %s Uhr.", zeit))
    elseif get_qstatus() == 5 then
        do_message(npc, ch, "Inard freut sich? Ich hoffe die ganze Aufregung hat dir nicht zu viel ausgemacht.")
        set_qstatus(6)
    else
        do_message(npc, ch, invertika.get_random_element("Ich kämpfe ab und zu in der Arena.",
           "Nichts ist so bedeutsam wie der nächste Kampf.",
           "Früher wollte ich Magier werden, aber naja so ist das Leben.",
           "Mein Schwert ist ein Unikat. Es stammt aus der Schmiede von Bolux van Nar.",
           "Schwerthieb auf Schwerthieb, und dann sah ich wie er seine Deckung fallen ließ und nutzte meine Chance. Ein toller Kampf war das.",
           "Das erste Mal sah ich das Colloseum vor 6 Jahren. Das war kurz nachdem es mich nach Selphi Timlet zog."))
    end

    do_npc_close(npc, ch)
end

function tonver_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Oh nein, ich habe schon wieder alles verspielt.",
	  "Ich lasse viel zu viel Geld in diesem Laden.",
	  "Nur noch 47 Aki. Naja das muss reichen.",
	  "Das nächste Mal gewinne ich ganz bestimmt.",
	  "Wenn ich 5 Aki setze und gewinne dann habe ich danach ein paar Aki mehr. Glaube ich...",
	  "Alles weg... Schon wieder... Aber beim nächsten mal... Da gewinne ich..."))
	  do_npc_close(npc, ch)
end

function elmes_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Manche Leute rennen im Kreis durch diese Bögen. Warum auch immer sie dies tun.",
	  "Ich genieße die Sonne. Deshalb der Hut.",
	  "Früher als ich noch jung war, da hatte ich mal einen Kater. Doch er ward eines Tages verschwunden. Er hieß Effendi. Wo er wohl sein wird?",
	  "Man erzählt sich von einem Schatz in der Wüste, verborgen in einer Höhle welche tief unter die Erde führt. Oder war die Höhle in der grünen Ebene? Ich weiß es nicht mehr genau.",
	  "Das letze mal als es regnete versank ich im Sand. Ich konnte mich erst nach 4 Stunden befreien.",
	  "Sei vorsichtig wenn du dich durch die große Wüste begibst."))
	  do_npc_close(npc, ch)
end

function nepuret_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Ich bin Nepuret.",
	  "Das ist das Haus von Averin, dem Chef der königlichen Palastwache.",
	  "Ich bewache dieses Haus.",
	  "Nein, ich stehe hier nicht zum Spaß. Ich achte darauf das niemand gefährliches sich diesem Haus nähert.",
	  "Man muss immer achtsam sein, sonst ist man plötzlich weg vom Fenster.",
	  "Ich diene bereits seit vielen Jahren als persönliche Wache von Averin."))
	  do_npc_close(npc, ch)
end

function nero_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Wo man den königlichen Passierschein bekommt? Ja das weiss ich *kicher*.",
	  "Averin vergibt die königlichen Passierscheine.",
	  "Ja, ich habe einen königlichen Passierschein! Ob du ihn bekommst? Nein, besorge dir selber einen!",
	  "Averin... la la la - Frag dort!",
	  "Ich habe es mit dem Feuer... ich kann nicht von ihm lassen.",
	  "Averin ist die Person mit der du reden solltest, nicht ich!"))
	  do_npc_close(npc, ch)
end

function colloseumwache_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Das ist das Colloseum auch die Arena genannt.",
	  "In der Arena finden Kämpfe statt, manchmal zumindestens.",
	  "Aergius war ein großer Kämpfer, bis er fort ging.",
	  "Achte auf deine Deckung, sonst kann es dich ganz böse erwischen.",
	  "Du siehst stark aus, vielleicht könntest du ein Kämpfer werden?"))
	  do_npc_close(npc, ch)
end

function bankwache_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Wir bewachen den die Zentralbank.",
	  "Dies ist die Zentralbank. Hier wird eine Menge Geld gelagert.",
	  "Wir passen auf das niemand in die Bank einbricht.",
	  "Dank uns gab es noch nie einen Einbruch in der Zentralbank.",
	  "Denk immer daran: Wir behalten dich im Auge."))
	  do_npc_close(npc, ch)
end

function stadtwache_talk(npc, ch)
    local quest_string_number = "selphi_timlet_guards_hunt_number"
    local quest_string_monsterid = "selphi_timlet_guards_hunt_monsterid"
    local quest_string_monster_name = "selphi_timlet_guards_hunt_monstername"
    local quest_string_kills = "selphi_timlet_guards_hunt_kills"
    invertika.init_quest_status(ch, quest_string_number)
    invertika.init_quest_status(ch, quest_string_kills)
    local number_of_jobs = invertika.get_quest_status(ch, quest_string_number)
    local new_job = false
    if number_of_jobs == 0 then
        do_message(npc, ch, "Wir garantieren hier die Sicherheit der Stadt.")
        do_message(npc, ch, "Übrigens. Der König zahlt regelmäßig Prämien wenn Ungeziefer tötest.")
        do_message(npc, ch, "Was zur Zeit getötet werden soll erfährst du bei uns.")
        do_message(npc, ch, "Auch die Belohnungen verteilen wir.")
        new_job = true
    end
    local required_kills = invertika.get_quest_status(ch, quest_string_kills)
    if required_kills ~= 0 then
        local kills = mana.chr_get_kill_count(ch, invertika.get_quest_status(ch, quest_string_monsterid))
        if kills >= required_kills then
            number_of_jobs = number_of_jobs + 1
            invertika.set_quest_status(ch, quest_string_number, number_of_jobs)
            do_message(npc, ch, "Danke, dass du die Monster getötet hast. Die Viecher wurden eine echte Plage!")
            invertika.add_money(ch, number_of_jobs * 100)
            new_job = true
        else
            do_message(npc, ch, string.format("Du musst noch %s %s töten bevor es eine Belohnung gibt.", required_kills - kills, invertika.get_quest_status_string(ch, quest_string_monster_name)))
        end
    end
    if new_job then
        local monster = nil
        if number_of_jobs < 5 then
            monster = { {id=2, name="Maden", factor=10},
              {id=3, name="Skorpione", factor=10},
              {id=6, name="rote Skorpione", factor=2}}
        elseif number_of_jobs < 10 then
            monster = { {id=7, name="schwarze Skorpione", factor=3},
              {id=12, name="Ameistenlöwen", factor=1}}
        else
            monster = { {id=11, name="Zombies", factor=4},
              {id=20, name="Terraniten", factor=5}}
        end
        local monster_data = monster[math.random(1, #monster)]
        invertika.set_quest_status(ch, quest_string_monsterid, monster_data.id)
        required_kills = monster_data.factor * (number_of_jobs + 1)
        local kills = mana.chr_get_kill_count(ch, invertika.get_quest_status(ch, quest_string_monsterid))
        invertika.set_quest_status(ch, quest_string_kills, required_kills + kills)
        invertika.set_quest_status_string(ch, quest_string_monster_name, monster_data.name)
        do_message(npc, ch, string.format(
                   "Als nächstes sollst du %s %s töten.", required_kills, monster_data.name)
                   )
    end
	do_npc_close(npc, ch)
end

function palastwache_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Zutritt nur mit königlichen Passierschein!",
	  "Du benötigst einen königlichen Passierschein um den Palast zu betreten.",
	  "Ohne königlichen Passierschein kein Zutritt!"))
	  do_npc_close(npc, ch)
end

function bernie_talk(npc, ch)
	do_message(npc, ch, "Hey du, du brauchst ihn doch bestimmt, den Niedermetzler 3000. Das ist genau das richtige für dich, da kannst du garnicht widerstehen. Komm schon für nur 99999 Aki gehört er dir? Oder eine Sonnenbrille? Neuste Mode? 12500 Aki! Ein besonderes Modell!")
	
	while true do 
		local v = do_choice(npc, ch, "Her mit dem Niedermetzler!",
                                     "Ich will die Sonnenbrille!",
								     "Lieber nicht...")
								   
		if v == 1 then
		    local PlayerMoney=mana.chr_money(ch)
		    if PlayerMoney >= 99999 then
			invertika.add_money(ch, -99999)
			invertika.add_items(ch, 10005, 1, "Niedermetzler 3000")
			do_message(npc, ch, invertika.get_random_element("Viel Spaß mit deinem Niedermetzler 3000.",
	  "Nun hast du ihn, den Niedermetzler 3000.",
	  "Bitteschön, der Niedermetzler 3000, die ultimative Waffe."))
		      break;
		    else
		      do_message(npc, ch, invertika.get_random_element("Du hast nicht genug Geld, komm später wieder.",
	  "So nicht, das Geld benötigst du schon.",
	  "Ne ne ne. Kram erstmal das Geld zusammen!"))
		      break;
		    end
        elseif v == 2 then
            if mana.chr_money(ch) >= 12500 then
                invertika.add_money(ch, -12500)
                invertika.add_items(ch, 20023, 1, "Sonnenbrille")
                do_message(npc, ch, "Da. Nimm Sie. Willst du auch einen Niedermetzler 3000?")
            else

		      do_message(npc, ch, invertika.get_random_element("Du hast nicht genug Geld, komm später wieder.",
	  "So nicht, das Geld benötigst du schon.",
	  "Ne ne ne. Kram erstmal das Geld zusammen!"))
            end
		elseif v == 3 then
			do_message(npc, ch, invertika.get_random_element("Dann halt nicht. Aber vielleicht später?",
	  "Wer nicht will der hat schon...",
	  "Okay, ein ander Mal vielleicht."))
			break
		end
	end
	do_npc_close(npc, ch)
end

function valeria_talk(npc, ch)
	
	invertika.init_quest_status(ch, "selphi_timlet_valeria_letzteHeilung")
	local letzteHeilung = invertika.get_quest_status(ch, "selphi_timlet_valeria_letzteHeilung")

	do_message(npc, ch, "Soll ich dich heilen?")

	while true do 
		local v = do_choice(npc, ch, "Alles heilen (1000 Aki)", "Nur 1000 HP (kostenlos)", "Nein ich brauche keine Heilung")
								   
		if v == 1 then
		    local PlayerMoney=mana.chr_money(ch)
		    if PlayerMoney >= 1000 then
			invertika.add_money(ch, -1000)
			mana.being_heal(ch);
			do_message(npc, ch, invertika.get_random_element("Du bist vollständig geheilt.",
	  "Fertig. Du kannst wieder deines Weges gehen."))
		    else
		      do_message(npc, ch, invertika.get_random_element("Du benötigst mehr Aki.",
	  "Du hast keine 1000 Aki."))
		    end
		elseif v == 2 then
			if letzteHeilung + (60 * 60 * 2) > os.time(t) then 
				do_message(npc, ch, "Nein. Ich heile dich nicht alle paar Minuten kostenlos. Komm doch später vielleicht nochmal vorbei")
				break
			else
				mana.being_heal(ch, 1000)
				do_message(npc, ch, invertika.get_random_element("Ich habe dir 1000 HP geschenkt.",
		  "Du siehst wieder frisch aus."))
				i = os.time(t)
				invertika.set_quest_status(ch, "selphi_timlet_valeria_letzteHeilung", i)
				break
			end
		elseif v == 3 then
			do_message(npc, ch, invertika.get_random_element("Wie du wünschst.",
	  "Entschuldigung, ich wollte mich dir nicht aufdrängen."))
			break
		end
	end
	do_npc_close(npc, ch)
end

function amulet_trigger(ch, args)
  if (mana.being_type(ch) == TYPE_CHARACTER) then --- Nur Player durchlassen
    local quest_string = string.format("selphi_timlet_amulet_quest_%s", args)
    invertika.init_quest_status(ch, quest_string)

    function get_qstatus() return tonumber(invertika.get_quest_status(ch, quest_string)) end
    function set_qstatus(x) invertika.set_quest_status(ch, quest_string, tonumber(x)) end

    if get_qstatus() == 0 then
        set_qstatus(1)
        invertika.add_items(ch, 40029, 1, "ein Stück eines zerbrochen Amuletts")
    end
  end
end

function lidi_talk(npc, ch)
    local queststring = "selphi_timlet_lidi_sunglasses"
    invertika.init_quest_status(ch, queststring)
    local get_qstatus = function()
        return invertika.get_quest_status(ch, queststring)
    end
    local set_qstatus = function(x)
        invertika.set_quest_Status(ch, queststring, x)
    end
    
    if get_qstatus() == 0 then
        if mana.chr_inv_count(ch, 20023) > 0 then
            do_message(npc, ch, "Oh Gott du hast SIE. Ich brauche diese Brille, gibst du sie mir?")
            while true do
                local v = do_choice(npc, ch, "Ja.", "Nein.")
                if v == 1 then
                    invertika.add_items(ch, 20023, -1, "Sonnenbrille")
                    invertika.add_items(ch, invertika.get_random_element(40030, 40031, 40032, 40033), 1, "Garn")
                    do_message(npc, ch, "Danke, danke, danke. Hier nimm das als Dankeschön.")
                    set_qstatus(1)
                    break
                elseif v == 2 then 
                    do_message(npc, ch, "Pffffff, dann nicht...")
                    break
                end
            end
        else
            do_message(npc, ch, "Boah diese Sonnenbrille ist der reinste Wahnsinn. Ich brauche diese, genau diese Brille.")
        end
    elseif get_qstatus() == 1 then
        do_message(npc, ch, "Sehe ich nicht total fesch mit dieser Brille aus?")
    end
    do_npc_close(npc, ch)
end

function warp_escape_tunnel(obj, blubb)
    if(mana.being_type(obj)==TYPE_CHARACTER) then
        mana.chr_warp(obj, 20146, 35 * TILESIZE, 35 * TILESIZE + 16) 
    end
end
