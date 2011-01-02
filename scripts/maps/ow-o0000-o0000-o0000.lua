----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                         --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/ivklibs/datetime"
require "scripts/ivklibs/invertika"
require "scripts/ivklibs/nethek"
require "scripts/ivklibs/seller"

dofile("data/scripts/ivklibs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(62, 72, 56, 6) --- Intermap warp
 nethek.create_netheksaeule(181 * TILESIZE, 125 * TILESIZE + 16) --- Netheksäule

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
 
 ---Weihnachten
 --create_npc("Rentier", 74, 177 * TILESIZE + 16, 185 * TILESIZE + 16, rentier_talk, nil) --- Rentier
 --create_npc("Weihnachtsmann", 9, 184 * TILESIZE + 16, 185 * TILESIZE + 16, weihnachtsmann_talk, nil) --- Weihnachtsman
 
 ---Neujahr
 ---create_npc("Feuerwerker", 139, 177 * TILESIZE + 16, 185 * TILESIZE + 16, fireworker_talk, npclib.walkaround_small)
end)

--Zeitabhägige Events
-- Weihnachten
function weihnachtsmann_talk(npc, ch)
	-- quest init
	if tonumber(get_quest_var(ch, "selphi_timlet_santa_clause")) == nil then
	  mana.chr_set_quest(ch, "selphi_timlet_santa_clause", 0)
	end
  
	-- quest get/set functions
	function get_qstatus() return tonumber(get_quest_var(ch, "selphi_timlet_santa_clause")) end
	function set_qstatus(x) mana.chr_set_quest(ch, "selphi_timlet_santa_clause", tonumber(x)) end
  
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
	    mana.chr_inv_change(ch, 40013, -count13)
	    mana.chr_inv_change(ch, 40014, -count14)
	    mana.chr_inv_change(ch, 40015, -count15)
	    
	    --Belohnung
	    mana.chr_inv_change(ch, 20010, 1) --Santa Clause Mütze
	    mana.chr_inv_change(ch, 30021, 10) --Zuckerstange
	    mana.chr_inv_change(ch, 30022, 10) --Weihnachtskuchen
	    mana.chr_inv_change(ch, 30023, 10) --Lebkuchenmänchen
	    mana.chr_inv_change(ch, 40020, 1) --5000 Aki Scheck
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
   if (mana.being_type(ch) ~= TYPE_MONSTER) then --- Nur Player durchlassen
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
			mana.npc_trade(npc, ch, false, { {10001, 10, 20}, {10002, 10, 1495}, {20001, 10, 30}, {20002, 10, 50} })
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
  if tonumber(get_quest_var(ch, "selphi_timlet_bruce_quest")) == nil then
    mana.chr_set_quest(ch, "selphi_timlet_bruce_quest", 0)
  end
  -- quest get/set functions
  function get_qstatus() return tonumber(get_quest_var(ch, "selphi_timlet_bruce_quest")) end
  function set_qstatus(x) mana.chr_set_quest(ch, "selphi_timlet_bruce_quest", tonumber(x)) end
  
	if get_qstatus()==0 then
		mana.chr_money_change(ch, 1000)
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
    mana.chr_inv_change(ch, 40005, -20)
    mana.chr_give_exp(ch, 100, 750)
    mana.chatmessage(ch, "Du hast 750 Exp im unbewaffneten Kampf erhalten!")
    set_qstatus(4)
  elseif get_qstatus()==4 then
    do_message(npc, ch, "In der Spielothek findet Danielas Geburtstagsparty statt. Bist du so nett, und bringst ihr mein Geschenk? Ich habe dort Hausverbot, weil ich meine Spielschulden nicht bezahlt habe.")
    set_qstatus(do_choice(npc, ch, "Nein.","Ja.")+3)
    if get_qstatus()==5 then
      mana.chr_inv_change(ch, 40015, 1)
      do_message(npc, ch, "Sehr nett von dir. Die Spielothek ist im süd-westlichen Teil der Stadt. Gib Daniela das Geschenk.")
    end
  elseif get_qstatus()==5 then
    do_message(npc, ch, "Die Spielothek ist im süd-westlichen Teil der Stadt. Gib Daniela das Geschenk.")
  elseif get_qstatus()==6 then
    do_message(npc, ch, "Sie hat sich über ihr Geschenk gefreut? Danke, du hast mir sehr geholfen! Nimm diese Flasche Pangalaktischen Donnergurgler als Dank.")
    mana.chr_inv_change(ch, 30008, 1)
    set_qstatus(7)
  elseif get_qstatus()==7 then
    do_message(npc, ch, "Lust auf eine neue Herausforderung?")
    mana.chr_inv_change(ch, 40002, 1)
    set_qstatus(do_choice(npc, ch, "Nein.","Ja.")+6)
    if get_qstatus()==8 then
      do_message(npc, ch, "Ich brauche 50 Skorpionstachel, um ein Faß Wurzelhans zu brauen. Lass dich nicht stechen.")
    end
  elseif get_qstatus()==8 then
    if mana.chr_inv_count(ch, 40004) >= 50 then
      do_message(npc, ch, "Das hast du gut gemacht! Nimm diesen Hut als Dank!")
      mana.chr_inv_change(ch, 40004, -50)
      mana.chr_inv_change(ch, 20004, 1)
      set_qstatus(9)
    else
      do_message(npc, ch, "Ich brauche 50 Skorpionstachel. Nicht mehr, und nicht weniger!")
    end
  elseif get_qstatus()>=9 then
    do_message(npc, ch, "Ich habe momentan keine Aufgabe für dich.")
  end

  do_npc_close(npc, ch)
end

function felix_talk(npc, ch)
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
	  do_npc_close(npc, ch)
end

function saria_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Die Wueste ist riesig, drum bleib ich hier.",
	  "Hüte dich vor der Wüste. Dort treiben rote Skropione ihr Unwesen.",
	  "Ey da nicht anfassen, da habe ich einen Sonnenbrand.",
	  "Alle meine Skorpione, sind in der Wüste.",
	  "Ich liebe Staedte mit Mauern.",
	  "Ich würde mal gerne zum Meer."))
	  do_npc_close(npc, ch)
end

function nobur_talk(npc, ch)
	do_message(npc, ch, "Ich brauche Skorpionstachel. Eine ganze Menge, so zwei Dutzend oder drei, vielleicht auch vier Dutzend. Das wird eine leckere Suppe.")
	
	local count = mana.chr_inv_count(ch, 40004) 
	
	if count > 0 then
	  do_message(npc, ch, "Ich sehe du hast ein paar Stachel. Magst du sie mir geben?")
	  
	  	while true do 
		local v = do_choice(npc, ch, "Ja",
								     "Nein")
								   
		if v == 1 then
			if (get_quest_var(ch, "selphi_timlet_norbur_scorpion_stingers")=="") then
			  mana.chr_set_quest(ch, "selphi_timlet_norbur_scorpion_stingers", count)
			else
			  local dbcount = get_quest_var(ch, "selphi_timlet_norbur_scorpion_stingers");
			  dbcount = dbcount + count
			  mana.chr_set_quest(ch, "selphi_timlet_norbur_scorpion_stingers", dbcount)
			  
			  if dbcount > 200 then
			    do_message(npc, ch, "Also wenn ich es mir recht überlege, habe ich schon genug Stachel. Trotzdem danke.")
				break;
			  end
			end
			
			mana.chr_inv_change(ch, 40004, -count)
		
			if count < 10 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  mana.chr_money_change(ch, 50) 
			  break;
			elseif count < 20 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  mana.chr_money_change(ch, 150) 
			  break;
			elseif count < 30 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  mana.chr_money_change(ch, 350) 
			  break;
			elseif count < 40 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  mana.chr_money_change(ch, 500) 
			  break;
			elseif count < 150 then
			  do_message(npc, ch, "Nimm diesen lustigen Hut als Dankeschön.")
			  mana.chr_inv_change(ch, 20004, 1)
			  break;
			elseif count >= 150 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  mana.chr_money_change(ch, 2500) 
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
	do_message(npc, ch, invertika.get_random_element("Der Chef der Palastwache vergibt die königlichen Passierscheine. Zumindestens behauptet Worel das.",
	  "Ich mag den Innenhof, es ist so schön ruhig und man kann sich entspannen.",
	  "Ich sollte mal wieder ein bisschen tranieren, schließlich gibt es da draußen eine Menge Monster.",
	  "Überall Palmen und keine einzige Kokusnuss. Seltsam.",
	  "Paradoxien und Kokusnüsse. Mmmmm darüber sollte ich nachdenken...",
	  "Ich glaube ich habe eine Lösung für das Kokusnussproblem.",
	  "Ich möchte wissen wo Worel hin wollte. Er ist nun schon eine Ewigkeit weg.",
	  "Ich entspanne mich hier nur ein wenig."))
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
	do_message(npc, ch, invertika.get_random_element("Ich verkaufe nichts.",
	  "Hier gibt es nichts zu sehen.",
	  "Ich kann dir nicht helfen.",
	  "Geh weg.",
	  "Ich kenne dich nicht, also will ich auch nix mit dir zu tun haben.",
	  "Nein, nein, nein und nochmal nein."))
	  do_npc_close(npc, ch)
end

function ortana_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Ich kämpfe ab und zu in der Arena.",
	  "Nichts ist so bedeutsam wie der nächste Kampf.",
	  "Früher wollte ich Magier werden, aber naja so ist das Leben.",
	  "Mein Schwert ist ein Unikat. Es stammt aus der Schmiede von Bolux van Nar.",
	  "Schwerthieb auf Schwerthieb, und dann sah ich wie er seine Deckung fallen ließ und nutzte meine Chance. Ein toller Kampf war das.",
	  "Das erste Mal sah ich das Colloseum vor 6 Jahren. Das war kurz nachdem es mich nach Selphi Timlet zog."))
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
	do_message(npc, ch, invertika.get_random_element("Wir bewachen den Eingang zur Stadt.",
	  "Wir sichern die Stadtgrenze vor feindlichen Mächten.",
	  "Sei vorsichtig, wenn du die Stadt verlässt."))
	  do_npc_close(npc, ch)
end

function palastwache_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Zutritt nur mit königlichen Passierschein!",
	  "Du benötigst einen königlichen Passierschein um den Palast zu betreten.",
	  "Ohne königlichen Passierschein kein Zutritt!"))
	  do_npc_close(npc, ch)
end

function bernie_talk(npc, ch)
	do_message(npc, ch, "Hey du, du brauchst ihn doch bestimmt, den Niedermetzler 3000. Das ist genau das richtige für dich, da kannst du garnicht widerstehen. Komm schon für nur 99999 Aki gehört er dir?")
	
	while true do 
		local v = do_choice(npc, ch, "Her damit!",
								     "Lieber nicht...")
								   
		if v == 1 then
		    local PlayerMoney=mana.chr_money(ch)
		    if PlayerMoney >= 99999 then
			mana.chr_money_change(ch, -99999)
			mana.chr_inv_change(ch, 10005, 1)
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
			do_message(npc, ch, invertika.get_random_element("Dann halt nicht. Aber vielleicht später?",
	  "Wer nicht will der hat schon...",
	  "Okay, ein ander Mal vielleicht."))
			break
		end
	end
	do_npc_close(npc, ch)
end

function valeria_talk(npc, ch)
	do_message(npc, ch, "Soll ich dich heilen?")

	while true do 
		local v = do_choice(npc, ch, "Alles heilen (1000 Aki)", "Nur 1000 HP (kostenlos)", "Nein ich brauche keine Heilung")
								   
		if v == 1 then
		    local PlayerMoney=mana.chr_money(ch)
		    if PlayerMoney >= 1000 then
			mana.chr_money_change(ch, -1000)
			mana.being_heal(ch);
			do_message(npc, ch, invertika.get_random_element("Du  bist vollständig geheilt.",
	  "Fertig. Du kannst wieder deines Weges gehen."))
		    else
		      do_message(npc, ch, invertika.get_random_element("Du benötigst mehr Aki.",
	  "Du hast keine 1000 Aki."))
		    end
		elseif v == 2 then
			mana.being_heal(ch, 1000)
			do_message(npc, ch, invertika.get_random_element("Ich habe dir 1000 HP geschenkt.",
	  "Du siehst wieder frisch aus."))
			break
		elseif v == 3 then
			do_message(npc, ch, invertika.get_random_element("Wie du wünscht.",
	  "Entschuldigung, ich wollte mich dir nicht aufdrängen."))
			break
		end
	end
	do_npc_close(npc, ch)
end
