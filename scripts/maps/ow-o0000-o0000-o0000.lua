----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008, 2009 The Invertika Development Team                         --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "data/scripts/libs/npclib"
require "data/scripts/ivklibs/datetime"
require "data/scripts/ivklibs/invertika"
require "data/scripts/ivklibs/nethek"

dofile("data/scripts/ivklibs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(62, 72, 56, 6) --- Intermap warp
 nethek.create_netheksaeule(180 * TILESIZE + 16, 125 * TILESIZE + 16) --- Netheksäule

 create_npc("Elmo", 103, 176 * TILESIZE + 16, 154 * TILESIZE + 16, elmo_talk, nil) --- Elmo
 create_npc("Sam", 103, 183 * TILESIZE + 16, 154 * TILESIZE + 16, sam_talk, nil) --- Sam
 create_npc("Julia", 106, 170 * TILESIZE + 16, 152 * TILESIZE + 16, julia_talk, nil) --- Julia
 create_npc("Jane", 108, 182 * TILESIZE + 16, 145 * TILESIZE + 16, jane_talk, nil) --- Jane
 create_npc("Bruce", 103, 190 * TILESIZE + 16, 160 * TILESIZE + 16, bruce_talk, nil) --- Bruce
 create_npc("Felix", 138, 187 * TILESIZE + 16, 94 * TILESIZE + 16, felix_talk, nil) --- Felix
 create_npc("Saria", 108, 42 * TILESIZE + 16, 100 * TILESIZE + 16, saria_talk, nil) --- Saria
 create_npc("Nobur", 113, 186 * TILESIZE + 16, 179 * TILESIZE + 16, nobur_talk, nil) --- Nobur
 create_npc("Alex", 120, 76 * TILESIZE + 16, 10 * TILESIZE + 16, alex_talk, nil) --- Alex
 create_npc("Inard", 157, 74 * TILESIZE + 16, 142 * TILESIZE + 16, inard_talk, nil) --- Inard
 create_npc("Belart", 137, 108 * TILESIZE + 16, 132 * TILESIZE + 16, belart_talk, nil) --- Belart
 create_npc("Imangi", 163, 138 * TILESIZE + 16, 157 * TILESIZE + 16, imangi_talk, nil) --- Imangi
 create_npc("Ortana", 104, 97 * TILESIZE + 16, 49 * TILESIZE + 16, ortana_talk, nil) --- Ortana
 create_npc("Tonver", 104, 17 * TILESIZE + 16, 181 * TILESIZE + 16, tonver_talk, nil) --- Tonver
 create_npc("Elmes", 142, 114 * TILESIZE + 16, 180 * TILESIZE + 16, elmes_talk, nil) --- Elmes
 create_npc("Nepuret", 126, 90 * TILESIZE + 16, 185 * TILESIZE + 16, nepuret_talk, nil) --- Nepuret 
 
 create_npc("Wache", 121, 39 * TILESIZE + 16, 51 * TILESIZE + 16, colloseumwache_talk, nil) --- Colloseumwache
 create_npc("Wache", 121, 44 * TILESIZE + 16, 51 * TILESIZE + 16, colloseumwache_talk, nil) --- Colloseumwache
 
 create_npc("Wache", 125, 26 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 create_npc("Wache", 125, 31 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 create_npc("Wache", 125, 45 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 create_npc("Wache", 125, 49 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 
 create_npc("Stadtwache", 123, 110 * TILESIZE + 16, 196 * TILESIZE + 16, stadtwache_talk, nil) --- Stadtwache
 create_npc("Stadtwache", 123, 117 * TILESIZE + 16, 196 * TILESIZE + 16, stadtwache_talk, nil) --- Stadtwache
 
 wache1 = create_npc("Palastwache", 123, 143 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 create_npc("Palastwache", 123, 150 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 wache2 = create_npc("Palastwache", 123, 181 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 create_npc("Palastwache", 123, 188 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 
 --- Trigger für die Überwachung des Torbereiches
 tmw.trigger_create(145 * TILESIZE, 17 * TILESIZE, 5 * TILESIZE, 52 * TILESIZE, "wache_trigger", 1, true) --- Trigger Tor 1
 tmw.trigger_create(183 * TILESIZE, 17 * TILESIZE, 5 * TILESIZE, 52 * TILESIZE, "wache_trigger", 2, true) --- Trigger Tor 2 
end)

 function get_wache_say()
   	 return invertika.get_random_element("Ohne Passierschein geht es hier nicht durch!",
	  "Durchgang nur mit Passierschein!",
	  "Du hast keinen Passierschein. Deshalb darfst du den Palast nicht betreten!",
	  "Halt, du benötigst einen Passierschein!")
 end

 function wache_trigger(ch, id)
   if (tmw.being_type(ch) ~= TYPE_MONSTER) then --- Nur Player durchlassen
	 local count = tmw.chr_inv_count(ch, 40009)
	 
	 if count == 0 then
	   local x = tmw.posX(ch)
	   local y = tmw.posY(ch)
	   tmw.chr_warp(ch, tmw.get_map_id(), x, 70 * TILESIZE) 
	   
	   if (id == 1) then
	     tmw.being_say(wache1, get_wache_say())
	   elseif (id == 2) then
	     tmw.being_say(wache2, get_wache_say())
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
			tmw.npc_trade(npc, ch, false, { {10001, 10, 20}, {20001, 10, 30}, {20002, 10, 50} })
			break
		elseif v == 2 then
			tmw.npc_trade(npc, ch, true, { {10001, 10, 20}, {20001, 10, 30}, {20002, 10, 50} })
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
	local firstVisit = get_quest_var(ch, "selphi_timlet_bruce_first_time")
	
	if firstVisit~="false" then
		tmw.chr_money_change(ch, 1000)
		tmw.chr_set_quest(ch, "selphi_timlet_bruce_first_time", "false")
		do_message(npc, ch, "Ahhh ich verstehe, du bist neu hier. Hier ein paar Münzen fuer den Anfang...")		
	else
		do_message(npc, ch, "Hi, schön dich wieder zu sehen.")
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
	  "Huete dich vor der Wueste. Dort treiben rote Skropione ihr Unwesen.",
	  "Ey da nicht anfassen, da habe ich einen Sonnenbrand.",
	  "Alle meine Skorpione, sind in der Wüste.",
	  "Ich liebe Staedte mit Mauern.",
	  "Ich würde mal gerne zum Meer."))
	  do_npc_close(npc, ch)
end

function nobur_talk(npc, ch)
	do_message(npc, ch, "Ich brauche Skorpionstachel. Eine ganze Menge, so zwei Dutzend oder drei, vielleicht auch vier Dutzend. Das wird eine leckere Suppe.")
	
	local count = tmw.chr_inv_count(ch, 40004) 
	
	if count > 0 then
	  do_message(npc, ch, "Ich sehe du hast ein paar Stachel. Magst du sie mir geben?")
	  
	  	while true do 
		local v = do_choice(npc, ch, "Ja",
								     "Nein")
								   
		if v == 1 then
			if (get_quest_var(ch, "selphi_timlet_norbur_scorpion_stingers")=="") then
			  tmw.chr_set_quest(ch, "selphi_timlet_norbur_scorpion_stingers", count)
			else
			  local dbcount = get_quest_var(ch, "selphi_timlet_norbur_scorpion_stingers");
			  dbcount = dbcount + count
			  tmw.chr_set_quest(ch, "selphi_timlet_norbur_scorpion_stingers", dbcount)
			  
			  if dbcount > 200 then
			    do_message(npc, ch, "Also wenn ich es mir recht überlege, habe ich schon genug Stachel. Trotzdem danke.")
				break;
			  end
			end
			
			tmw.chr_inv_change(ch, 40004, -count)
		
			if count < 10 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  tmw.chr_money_change(ch, 50) 
			  break;
			elseif count < 20 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  tmw.chr_money_change(ch, 150) 
			  break;
			elseif count < 30 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  tmw.chr_money_change(ch, 350) 
			  break;
			elseif count < 40 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  tmw.chr_money_change(ch, 500) 
			  break;
			elseif count < 150 then
			  do_message(npc, ch, "Nimm diesen lustigen Hut als Dankeschön.")
			  tmw.chr_inv_change(ch, 20004, 1)
			  break;
			elseif count >= 150 then
			  do_message(npc, ch, "Nimm diese Münzen als Dank.")
			  tmw.chr_money_change(ch, 2500) 
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
	  "Man erzählt sich von einem Schatz in der Wüste, verborgen in einer Höhle welche tief unter die Erde führt. Oder war die Höhle in der grünen Ebene. Ich weiß es nicht mehr genau.",
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

function colloseumwache_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Das ist das Colloseum auch die Arena genannt.",
	  "In der Arena finden Kämpfe statt, manchmal zumindestens.",
	  "Aergius war ein großer Kämpfer, bis er fort ging.",
	  "Achte auf deine Deckung, sonst kann es dich ganz böse erwischen.",
	  "Du siehst stark aus, vieleicht könntest du ein Kämpfer werden?"))
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
	  "Sei vorsichtig wenn du die Stadt verlässt."))
	  do_npc_close(npc, ch)
end

function palastwache_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Zutritt nur mit königlichen Passierschein!",
	  "Du benötigst einen königlichen Passierschein um den Palast zu betreten.",
	  "Ohne königlichen Passierschein kein Zutritt!"))
	  do_npc_close(npc, ch)
end