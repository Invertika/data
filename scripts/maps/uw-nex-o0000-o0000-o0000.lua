----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
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

require "scripts/lua/npclib"
require "scripts/libs/death"
require "scripts/libs/invertika"

dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(19001, 19001, 19001, 19001) --- Intermap warp
 create_npc("Nethek", 1, 36 * TILESIZE, 154 * TILESIZE + 16, nethek_talk, nil) --- Nethek
 create_npc("Monty", 49, 107 * TILESIZE + 16, 92 * TILESIZE + 16, monty_talk, nil) --- Monty
 
 -- Scheudle
   schedule_every(3, function()
    ShowNextMessageForTherapy()
  end)
 
  -- NPCs
 annabell=create_npc("Annabell", 23, 140 * TILESIZE + 16, 39 * TILESIZE + 16, annabell_talk, nil) --- Annabell
 herbert=create_npc("Herbert", 61, 143 * TILESIZE + 16, 41 * TILESIZE + 16, herbert_talk, nil) --- Herbert
 miriam=create_npc("Miriam", 79, 137 * TILESIZE + 16, 42 * TILESIZE + 16, miriam_talk, nil) --- Miriam
 ben=create_npc("Ben", 86, 136 * TILESIZE + 16, 46 * TILESIZE + 16, ben_talk, nil) --- Ben
end)

therapyState=0;

function ShowNextMessageForTherapy()
  if therapyState==0 then
    mana.being_say(annabell, "Hallo, ich bin Annabell und leite diese Sitzung der anonymen PvP Killer. Am besten wir stellen uns erstmal vor. Fängst du bitte an Herbert?")
  elseif therapyState==1 then
    mana.being_say(herbert, "Ja ich bin der Herbert und PvP Killing süchtig.")
  elseif therapyState==2 then
    mana.being_say(annabell, "Hallo Herbert.")
    mana.being_say(miriam, "Hallo Herbert.")
    mana.being_say(ben, "Hallo Herbert.")
  elseif therapyState==3 then
    mana.being_say(herbert, "Ich bin jetzt schon seit 40 Tagen clean.")
  elseif therapyState==4 then
    mana.being_say(annabell, "Super.")
    mana.being_say(miriam, "Großartig.")
    mana.being_say(ben, "Toll.")
  elseif therapyState==5 then
    mana.being_say(herbert, "Ja das war es so zu mir.")
  elseif therapyState==6 then
    mana.being_say(annabell, "Toll Herbert. Kommen wir nun zu dir Miriam.")
  elseif therapyState==7 then
    mana.being_say(miriam, "Ich bin Miriam und schon seit meiner Kindheit PvP Killer.")
  elseif therapyState==8 then
    mana.being_say(annabell, "Hallo Miriam.")
    mana.being_say(herbert, "Hallo Miriam.")
    mana.being_say(ben, "Hallo Miriam.")
  elseif therapyState==9 then
    mana.being_say(miriam, "Ich bin mittlerweile wieder seit 4 Monaten clean, habe allerdings ab und an mit Rückfällen zu kämpfen.")
  elseif therapyState==11 then
    mana.being_say(annabell, "Rückfälle sind bei PvP Killern nicht selten, man muss einfach lernen damit umzugehen und aus den Rückfällen neue Kraft schöpfen.")
  elseif therapyState==13 then
    mana.being_say(miriam, "Ich hoffe meine Sucht eines Tages überwinden zu können.")
  elseif therapyState==14 then
    mana.being_say(annabell, "Danke Miriam. Neu in unserer heutigen Runde ist Ben.")
  elseif therapyState==15 then
    mana.being_say(ben, "Ja ich bin der Ben und wie gesagt neu hier.")
  elseif therapyState==16 then
    mana.being_say(annabell, "Hallo Ben.")
    mana.being_say(herbert, "Hallo Ben.")
    mana.being_say(miriam, "Hallo Ben.")
  elseif therapyState==17 then
    mana.being_say(ben, "Ich wollte es erst gar nicht wahrhaben das ich PvP Killig süchtig bin. Selbst hier habe ich meinen Bogen mit dabei.")
  elseif therapyState==19 then
    mana.being_say(annabell, "Ja besonders am Anfang braucht man eine Menge Unterstützung und deshalb freue ich mich auch das du den Weg zu uns gefunden hast.")
  elseif therapyState==21 then
    mana.being_say(ben, "Ja ich hatte die Anzeige an diesem Pinboard gesehen und dachte mir, das ich es ja mal probieren könnte.")
  elseif therapyState==23 then
    mana.being_say(miriam, "Wie lange bist du schon clean?")
  elseif therapyState==24 then
    mana.being_say(ben, "Den heutigen Tag mitgerechnet fünf Tage.")
  elseif therapyState==25 then
    mana.being_say(annabell, "Das ist ein sehr guter Anfang. Auch die längste Reise beginnt mit dem ersten Schritt, Ben.")
  elseif therapyState==27 then
    mana.being_say(ben, "Früher habe ich auch immer versucht nur stärkere Spieler ins Nex zu bringen doch irgendwann fing ich auch mit schwächeren Spielern an.")
  elseif therapyState==29 then
    mana.being_say(annabell, "Und da hast du gemerkt das du etwas falsches tust?")
  elseif therapyState==30 then
    mana.being_say(ben, "Ja, da fing es an.")
  elseif therapyState > 30 then
    therapyState=-1
  end
  
  therapyState=therapyState+1
end

function nethek_talk(npc, ch)
    do_message(npc, ch, "Du moechtest den Nex verlassen?")
	
	while true do 
		local v = do_choice(npc, ch, "Ja.", "Nein.")
								   
		if v == 1 then
			local mapID = nethek.get_nethek_warp_map(ch)
			local x = nethek.get_nethek_warp_x(ch)
			local y = nethek.get_nethek_warp_y(ch)
			mana.chr_warp(ch, mapID, x, y) 
			break;
		elseif v == 2 then
			break;
		end
	end
	do_npc_close(npc, ch)
end

function monty_talk(npc, ch)
    local deathCount = death.get_death_counter(ch)

	---Spezielle Abfragen auf bestimmte Werte
	if deathCount == 100 then
	   do_message(npc, ch, "Gratulation du bist zum 100ten Mal gestorben. Das gibt eine Party.")
	   do_npc_close(npc, ch)
	   return
	elseif deathCount == 1000 then
	   do_message(npc, ch, "Du bist 1000 mal gestorben. Man man ich bin begeistert.")
	   do_npc_close(npc, ch)
	   return
	elseif deathCount == 2500 then
	   do_message(npc, ch, "Du bist nun schon ziemlich oft tot gewesen. Vielleicht hilft dir ein bisschen Geld darüber hinweg.")
	   mana.chr_money_change(ch, 50000)
	   do_npc_close(npc, ch)
	   return
	elseif deathCount == 5000 then
	   do_message(npc, ch, "Du stirbst wohl extra wegen dem Geld oder? Naja ich gebs dir, ich brauch kein Geld mehr.")
	   mana.chr_money_change(ch, 150000)
	   do_npc_close(npc, ch)
	   return
	end
	
	---Normale Abfragen
	if deathCount < 5 then
	   do_message(npc, ch, "Willkommen im Nex, dem Reich des Toten. Wenn du es verlassen möchtest musst du mit Nethek reden. Und rede ab und an mit mir wenn du hier bist...")
	   do_npc_close(npc, ch)
	   return
	elseif deathCount < 50 then
	   do_message(npc, ch, invertika.get_random_element("Erfrische dich ab und zu um deine HP aufzufüllen.",
	   "Lege ab und zu eine Pause ein, dies füllt deine HP auf.",
	   "Lege dich nur mit Gegnern an denen du dich gewachsen fühlst.",
	   "Verbünde dich mit anderen Spielern. In einer Gruppe seid ihr stark."))
	   do_npc_close(npc, ch)
	   return
	else
	   do_message(npc, ch, invertika.get_random_element("Schon wieder gestorben? Das ging ja schnell.",
	   "Oh, schon wieder da? Vermisst du mich so sehr?",
	   "Ich merke schon du bist gerne hier...",
	   "Oh bringst du mir ein Geschenk?",
	   "Warum aktivierst du nicht einfach den God Mode Cheat?",
	   "God Mode, da war doch was mit @godmode...",
	   "Alle Extraleben sind aufgebraucht, das wars wohl...",
	   "Ist das ein Talent von dir oder musst du dafür täglich üben?",
	   "Hast du noch andere Hobbys? Ich würde dir ein anderes, nicht so schmerzhaftes Hobby empfehlen.",
	   "Scheint heute nicht wirklich dein Tag zu sein, oder?",
	   "Hui, was für eine Überraschung. Du hier?",
	   "Ja ja, wer länger stirbt ist früher tot.",
	   "Ich sehe Tote wandeln. Aber du bist mein Favorit.",
	   "Sterben ist dein Hobby, oder?",
	   "Du bist ja schon wieder da...",
	   "3, 2, 1, Tod.",
	   "Man du must aufpassen wenn du da draußen bist...",
	   "Nichts ist so grün wie der Tod, nicht wahr Frischling?",
	   "Dem Godmode Spieler konnte nur noch ein Avatarspieler etwas entgegensetzen. Zum Glück passiert es nur sehr selten. Gibt immer so viele Tote...",
	   "Dich hab ich aber jetzt nicht erwartet. Ich dachte der Postbote ist schneller.",
	   "Wer sich in Gefahr begibt, kommt darin um.",
	   "Mmmm Totensteuer... Gute Idee.",
	   "Lass mich raten. Du sucht ein Zimmer.",
	   "Du erinnerst mich an Joe aus dem Film das Milchtütenmasaker.",
	   "Messer, Gabel, Licht sind für kleine Kinder nicht.",
	   "Lange nicht gesehen.",
	   "Du versuchst dem Sinn des Lebens auf den Grund zu gehen oder wie soll ich das verstehen?",
	   "Ja ja der süße Tod.",
	   "Der letze Godmode Spieler löste eine Katastrophe aus..."))
	   do_npc_close(npc, ch)
	   return
	end
end

function annabell_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("PvP Killing ist ein ernstes Krankheitsbild.",
	  "Eine Therapie kann helfen, andere Spieler in Ruhe zu lassen.",
	  "Ich bin ausgebildete Therapeutin für PvP Killing.",
	  "PvP Killing ist glücklicherweise therapierbar.",
	  "Wir bekommen das hin, die anerkannte MA-NA Methode hilft bei der PvP Killing Therapie."))
	  do_npc_close(npc, ch)
end

function herbert_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Ich bin PvP Killing süchtig.",
	  "Ich hoffe diese Therapie kann mir helfen."))
	  do_npc_close(npc, ch)
end

function miriam_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Früher musste jeder dran glauben der mir über den Weg lief.",
	  "Dank der anonymen PvP Killer Gruppe geht es mir schon viel besser."))
	  do_npc_close(npc, ch)
end

function ben_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Nicht mal hier kann ich meinen Bogen weglegen.",
	  "Ich muss noch hart an mir arbeiten."))
	  do_npc_close(npc, ch)
end