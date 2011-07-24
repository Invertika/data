----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2010 by Invertika Project                                  --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"

dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(19002, 19002, 19002, 19002) --- Intermap warp
 
 --- Erster Start
 mana.trigger_create(115 * TILESIZE, 15 * TILESIZE, 50 * TILESIZE, 23 * TILESIZE, "firststart_trigger", 0, true) --- Erste Meldung
 
 -- Zelan
 create_npc("Zelan", 58, 132 * TILESIZE + 16, 21 * TILESIZE + 16, zelan_talk, nil) --- Zelan
 
 -- Zeitungsjunge
 create_npc("Jack", 34, 159 * TILESIZE + 16, 31 * TILESIZE + 16, jack_talk, nil) --- Jack
 
 -- Zaun NPC 
 create_npc("Ancoise", 25, 137 * TILESIZE + 16, 41 * TILESIZE + 16, ancoise_talk, nil) --- Ancoise

 -- Kampf NPC
 create_npc("Kolbert", 30, 156 * TILESIZE + 16, 66 * TILESIZE + 16, kolbert_talk, nil) --- Kolbert
 
 -- Levelup NPC
 create_npc("Syntyche", 25, 142 * TILESIZE + 16, 110 * TILESIZE + 16, syntyche_talk, nil) --- Syntyche
 
 -- Handel Valaia 
 create_npc("Valaia", 60, 102 * TILESIZE + 16, 83 * TILESIZE + 16, valaia_talk, nil) --- Valaia
 
 -- Regeln Asam 
 create_npc("Asam", 72, 66 * TILESIZE + 16, 130 * TILESIZE + 16, asam_talk, nil) --- Asam
 
 -- Leben und Sterben Corona  
 create_npc("Corona ", 12, 89 * TILESIZE + 16, 135 * TILESIZE + 16, corona_talk, nil) --- Corona 
 
 -- Verlassen des Vacare
 create_npc("Vacare", 1, 103 * TILESIZE, 139 * TILESIZE + 16, vacare_talk, nil) --- Vacare
end)

--- Erster Start
 function firststart_trigger(ch, id)
     ---local first = get_quest_var(ch, "vacare_first_start")
        
     ---if first=="" then
     ---mana.chatmessage(ch, "ch id:."..tostring(ch))
     mana.chatmessage(ch, "Willkommen bei Invertika.")
     mana.chatmessage(ch, "Zum Bewegen benutze bitte die Cursortasten.")
     mana.chatmessage(ch, "Um mit NPCs zu reden, klicke mit der rechten Maustaste auf sie.") 
         mana.chatmessage(ch, "Das Spiel kann auch mit der Maus gesteuert werden.") 
         mana.chatmessage(ch, "Folge dem Weg und du wirst das Vacare finden.") 
         ---mana.chr_set_quest(ch, "vacare_first_start", 1)
     ---end
 end

function zelan_talk(npc, ch)
    do_message(npc, ch, "Du möchtest wissen wo du bist? Das hier ist das Vacare. Jeder neue kommt hier her bevor es raus geht in die große Welt. Also pass auf dich auf.")
	do_npc_close(npc, ch)
end

function jack_talk(npc, ch)
    do_message(npc, ch, "Ich bin Jack und verkaufe Zeitungen. Möchtest du eine?")
	
	while true do 
	  local v = do_choice(npc, ch, "Ja.", "Nein.")
								   
	  if v == 1 then
		do_message(npc, ch, "Du hast leider kein Geld dabei. Tut mir leid.")
		break;
	  elseif v == 2 then
		do_message(npc, ch, "Naja später vielleicht.")
		break;
	  end
	end
	do_npc_close(npc, ch)
end
 
function ancoise_talk(npc, ch)
    local quest_string = "vacare_fence"
    invertika.init_quest_status(ch, quest_string)
	if invertika.get_quest_status(ch, quest_string) == 0 then
      do_message(npc, ch, "Na soll ich dir über den Zaun helfen?")
	
	  while true do 
		  local v = do_choice(npc, ch, "Ja.", 
		                               "Nein.")
								   
		  if v == 1 then
			  invertika.set_quest_status(ch, quest_string, 1)
			  mana.chr_warp(ch,  19002, 141 * TILESIZE, 42 * TILESIZE) 
			  do_message(npc, ch, "Bitteschön.")
			  break;
	      elseif v == 2 then
			  do_message(npc, ch, invertika.get_random_element("Dann halt nicht.",
	  "Wer nicht will der hat schon.",
	  "Dann kommst du halt später wieder."))
			  break;
		  end
	  end
	else
	 do_message(npc, ch, "Willkommen auf der anderen Seite.")
	end
	do_npc_close(npc, ch)
end

function kolbert_talk(npc, ch)
    local quest_string = "vacare_first_weapon"
    invertika.init_quest_status(ch, quest_string)
       
    if invertika.get_quest_status(ch, quest_string) == 0 then
      
      do_message(npc, ch, "Du willst kämpfen? Nun gut zum Kämpfen benötigst du erst einmal eine Waffe.")
      
      invertika.add_items(ch, 10001, 1, "Dolch")
           
      do_message(npc, ch, "So hier hast du einen kleinen Dolch. Nun gehe in das Inventar und rüste ihn aus.")
	  do_message(npc, ch, "Anschließend begib dich in die Nähe eines Gegners und drücke A. Dadurch wird der Gegner anvisiert.")
	  do_message(npc, ch, "Nun musst du in seiner Nähe die Strg Taste drücken und schon greifst du ihn an.")
	  do_message(npc, ch, "Du kannst ihn aber auch nur mittels der X Taste angreifen.")
	  do_message(npc, ch, "Viel Erfolg.")
	  
      invertika.set_quest_status(ch, quest_string, 1)
    else
	  do_message(npc, ch, "Du schon wieder. Du weist doch. Zum Gegner, A drücken und dann Strg um zum Angriff überzugehen. Oder einfach X drücken. Einfach oder?")
	  do_message(npc, ch, "Noch ein kleiner Tipp. Mit Z kannst du Gegenstände aufheben die ein Gegner verliert.")
    end
    
    do_npc_close(npc, ch)
end

function syntyche_talk(npc, ch)
    do_message(npc, ch, "Ich sehe du bist fleißig am Kämpfen. Durch das Erlegen von Monstern bekommst du übrigens Erfahrungspunkte. Wenn du genügend Erfahrungspunkte gesammelt hast, steigst du um ein Level auf. Mit jedem Level erhälst du dann sogenannte Charakterpunkte und Korrekturpunkte.")

    do_message(npc, ch, "Mit den Charakterpunkten kannst du deine Statuswerte verbessern. Dazu musst du auf Status klicken. Unten stehen deine vorhandene Anzahl an Charakterpunkten und Korrekturpunkten. Nun kannst du diese Punkte auf die Statuswerte verteilen. Wenn du denkst das du bei der Verteilung der Punkte einen Fehler gemacht hast so kannst du die Änderung zurücknehmen, solange du genug Korrekturpunkte hast.")
	
    do_message(npc, ch, "Also achte darauf das du die du deine Charakterpunkte auf die richtigen Werte verteilst.")
	do_npc_close(npc, ch)
end

function valaia_talk(npc, ch)
    do_message(npc, ch, "Du sieht aus wie jemand der Handeln möchte. Mmmh was gibt es denn da zu erzählen. Also es gibt zwei Arten zu handeln, einmal mit NPCs und einmal mit deinen Mitspielern.")
	
    local quest_string = "vacare_first_trade"
    invertika.init_quest_status(ch, quest_string)
	if invertika.get_quest_status(ch, quest_string) == 0 then
      do_message(npc, ch, "Ich sehe du hast gar kein Geld bei dir. Nun ja ich will mal nicht so sein, nimm ein bischen von meinem.")
      invertika.add_money(ch, 500)
      invertika.set_quest_status(ch, quest_string, 1)
    end
	
    do_message(npc, ch, "Also fangen wir am besten mit dem Handel zwischen dir und einem NPC. Du kannst bei einem NPC Dinge kaufen und auch verkaufen. Was du kaufen kannst und was nicht legt der NPC fest. Was möchtest du tun?")
	
	while true do 
		local v = do_choice(npc, ch, "Kaufen",
								     "Verkaufen",
									 "Nichts danke.")
								   
		if v == 1 then
			mana.npc_trade(npc, ch, false, { {10001, 10, 20} })
		elseif v == 2 then
			mana.npc_trade(npc, ch, true, { {10001, 10, 20} })
		elseif v == 3 then
			break
		end
	end
	
    do_message(npc, ch, "Gut du hast genug gehandelt. Neben dem NPC Handel gibt es noch den Handel mit anderen Spielern. Um mit einem Spieler zu handeln klicke mit der rechten Maustaste auf ihn und wähle Handeln aus dem Menü aus.")
	
    do_message(npc, ch, "Daraufhin öffnet sich ein Fenster. Zusätzlich solltest du das Inventarfenster öffnen. Wähle nun ein Item im aus und drücke im Handelsfenster auf Hinzufügen. Dadurch wird das Item dem Handel hinzugefügt. Wenn du denn Handel beenden möchtest so klicke auf Vorschlagen und dann auf Bestätigen. Der Handel ist damit abgeschlossen.")
	
    do_message(npc, ch, "Ja das wars auch schon zum Thema Handel.")
	do_npc_close(npc, ch)
end

function asam_talk(npc, ch)
    do_message(npc, ch, "Die erste Devise von Invertika ist, das es so wenige Regeln wie möglich geben soll. Ganz einfach aus dem Grund das wir der Meinung sind das jede Regel doch eine gewisse Einschränkung darstellt. Doch gibt es einige Empfehlungen: ")

	do_message(npc, ch, "Nummero 1: Seid nett zueinander.")
	
	do_message(npc, ch, "Nummero 2: Kein SPAM!")
	
	do_message(npc, ch, "Nummero 3: Die Spielsprache ist Deutsch. Dies bezieht sich nur auf den offnen Chat (im Fenster Allgemein). In Gildenchats darf natürlich jede andere Sprache gesprochen werden.")
	
    do_message(npc, ch, "Wie gesagt sind dies Empfehlungen, aber wer weiß was die anderen Spieler machen wenn sie euch beim Spammen erwischen :) Ich wünsche dir viel Spaß.")
	do_npc_close(npc, ch)
end

function corona_talk(npc, ch)
    do_message(npc, ch, "Wo du bist nachdem du gestorben bist? Das kann ich dir sagen. Jeder der stirbt findet sich im Nex wieder. Es ist ein Ort voller Frieden, wie das Vacare. Allerdings gibt es ein paar Dinge zu beachten.")
	
    do_message(npc, ch, "Jedes Mal wenn du stirbst verlierst du ein Drittel deines Bargeldes. Deshalb darfst du nie zu viel Bargeld mit dir herum schleppen. Du kannst dein überschüssiges Geld aber zur Bank bringen. Dort wird es sogar verzinst. Und wenn du stirbst ist es dort sicher.")
	
    do_message(npc, ch, "Also hüte dich und kämpfe keinen ausichtslosen Kampf...")
	
	do_message(npc, ch, "Eine Sache noch: Wenn du das Reich der Toten verlässt wirst du zu der Netheksäule gebracht, bei welcher du zuletzt um den Segen gebeten hast, also halte Ausschau nach Ihnen.")
	do_npc_close(npc, ch)
end

function vacare_talk(npc, ch)
    do_message(npc, ch, "Bist du bereit für das große Abenteuer?")
	
	while true do 
		local v = do_choice(npc, ch, "Ja.",
								     "Nein.")
								   
		if v == 1 then
			mana.chr_warp(ch,  61, 179 * TILESIZE, 151 * TILESIZE) 
			do_message(npc, ch, "Willkommen in Selphi Timlet. Das Abenteuer beginnt...")
			break;
		elseif v == 2 then
			do_message(npc, ch, "Gut, dann übe noch ein wenig.")
			break;
		end
	end
	do_npc_close(npc, ch)
end
