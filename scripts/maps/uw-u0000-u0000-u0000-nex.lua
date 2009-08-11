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

require "data/scripts/libs/npclib"
require "data/scripts/ivklibs/death"
require "data/scripts/ivklibs/invertika"

dofile("data/scripts/ivklibs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(19001, 19001, 19001, 19001) --- Intermap warp
 create_npc("Nethek", 20001, 36 * TILESIZE + 16, 154 * TILESIZE + 16, nethek_talk, nil) --- Nethek
 create_npc("Monty", 145, 107 * TILESIZE + 16, 92 * TILESIZE + 16, monty_talk, nil) --- Monty
end)

function nethek_talk(npc, ch)
    do_message(npc, ch, "Du moechtest den Nex verlassen?")
	
	while true do 
		local v = do_choice(npc, ch, "Ja.",
								     "Nein.")
								   
		if v == 1 then
			death.increase_death_counter(ch)
			death.pay_death_price(ch)
			local mapID = nethek.get_nethek_warp_map(ch)
			local x = nethek.get_nethek_warp_x(ch)
			local y = nethek.get_nethek_warp_y(ch)
			tmw.chr_warp(ch, mapID, x, y) 
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
	   do_message(npc, ch, "Du bist nun schon ziemlich oft tot gewesen. Vielleicht hilft dir ein bischen Geld darüber hinweg.")
	   tmw.chr_money_change(ch, 50000)
	   do_npc_close(npc, ch)
	   return
	elseif deathCount == 5000 then
	   do_message(npc, ch, "Du stirbst wohl extra wegen dem Geld oder? Naja ich gebs dir, ich brauch kein Geld mehr.")
	   tmw.chr_money_change(ch, 150000)
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
	   "3, 2, 1, Tod.",
	   "Nichts ist so grün wie der Tod, nicht wahr Frischling?",
	   "Dem Godmode Spieler konnte nur noch ein Avatarspieler etwas entgegensetzen. Zum Glück passiert es nur sehr selten. Gibt immer so viele Tote...",
	   "Dich hab ich aber jetzt nicht erwartet. Ich dachte der Postbote ist schneller.",
	   "Wer sich in Gefahr begibt, kommt darin um.",
	   "Mmmm Totensteuer... Gute Idee.",
	   "Lass mich raten. Du sucht ein Zimmer.",
	   "Du erinnerst mich an Joe aus dem Film das Milchtütenmasaker.",
	   "Messer, Gabel, Licht sind für kleine Kinder nicht.",
	   "Lange nicht gesehen.",
	   "Ja ja der süße Tod.",
	   "Der letze Godmode Spieler löste eine Katastrophe aus..."))
	   do_npc_close(npc, ch)
	   return
	end
end
