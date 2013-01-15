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

require "scripts/libs/warp"


--- Erster Start
 local function firststart_trigger(ch, id)
     ---local first = get_quest_var(ch, "vacare_first_start")
        
     ---if first=="" then
     ---chat_message(ch, "ch id:."..tostring(ch))
     chat_message(ch, "Willkommen bei Invertika.")
     chat_message(ch, "Zum Bewegen benutze bitte die Cursortasten.")
     chat_message(ch, "Um mit NPCs zu reden, klicke mit der rechten Maustaste auf sie.") 
         chat_message(ch, "Das Spiel kann auch mit der Maus gesteuert werden.") 
         chat_message(ch, "Folge dem Weg und du wirst das Vacare finden.") 
         ---chr_set_quest(ch, "vacare_first_start", 1)
     ---end
 end

local function zelan_talk(npc, ch)
    npc_message(npc, ch, "Du möchtest wissen wo du bist? Das hier ist das Vacare. Jeder neue kommt hier her bevor es raus geht in die große Welt. Also pass auf dich auf.")
end

local function jack_talk(npc, ch)
    npc_message(npc, ch, "Ich bin Jack und verkaufe Zeitungen. Möchtest du eine?")
    
    while true do 
      local v = npc_choice(npc, ch, "Ja.", "Nein.")
                                   
      if v == 1 then
        npc_message(npc, ch, "Du hast leider kein Geld dabei. Tut mir leid.")
        break;
      elseif v == 2 then
        npc_message(npc, ch, "Naja später vielleicht.")
        break;
      end
    end
end
 
local function ancoise_talk(npc, ch)
    local quest_string = "vacare_fence"
    invertika.init_quest_status(ch, quest_string)
    if invertika.get_quest_status(ch, quest_string) == 0 then
      npc_message(npc, ch, "Na soll ich dir über den Zaun helfen?")
    
      while true do 
          local v = npc_choice(npc, ch, "Ja.", 
                                       "Nein.")
                                   
          if v == 1 then
              invertika.set_quest_status(ch, quest_string, 1)
              chr_warp(ch,  19002, 141 * TILESIZE, 42 * TILESIZE) 
              npc_message(npc, ch, "Bitteschön.")
              break;
          elseif v == 2 then
              npc_message(npc, ch, invertika.get_random_element("Dann halt nicht.",
      "Wer nicht will der hat schon.",
      "Dann kommst du halt später wieder."))
              break;
          end
      end
    else
     npc_message(npc, ch, "Willkommen auf der anderen Seite.")
    end
end

local function kolbert_talk(npc, ch)
    local quest_string = "vacare_first_weapon"
    invertika.init_quest_status(ch, quest_string)
       
    if invertika.get_quest_status(ch, quest_string) == 0 then
      
      npc_message(npc, ch, "Du willst kämpfen? Nun gut zum Kämpfen benötigst du erst einmal eine Waffe.")
      
      invertika.add_items(ch, 10001, 1, "Dolch")
           
      npc_message(npc, ch, "So hier hast du einen kleinen Dolch. Nun gehe in das Inventar und rüste ihn aus.")
      npc_message(npc, ch, "Anschließend begib dich in die Nähe eines Gegners und drücke A. Dadurch wird der Gegner anvisiert.")
      npc_message(npc, ch, "Nun musst du in seiner Nähe die Strg Taste drücken und schon greifst du ihn an.")
      npc_message(npc, ch, "Du kannst ihn aber auch nur mittels der X Taste angreifen.")
      npc_message(npc, ch, "Viel Erfolg.")
      
      invertika.set_quest_status(ch, quest_string, 1)
    else
      npc_message(npc, ch, "Du schon wieder. Du weist doch. Zum Gegner, A drücken und dann Strg um zum Angriff überzugehen. Oder einfach X drücken. Einfach oder?")
      npc_message(npc, ch, "Noch ein kleiner Tipp. Mit Z kannst du Gegenstände aufheben die ein Gegner verliert.")
    end
    
end

local function syntyche_talk(npc, ch)
    npc_message(npc, ch, "Ich sehe du bist fleißig am Kämpfen. Durch das Erlegen von Monstern bekommst du übrigens Erfahrungspunkte. Wenn du genügend Erfahrungspunkte gesammelt hast, steigst du um ein Level auf. Mit jedem Level erhälst du dann sogenannte Charakterpunkte und Korrekturpunkte.")

    npc_message(npc, ch, "Mit den Charakterpunkten kannst du deine Statuswerte verbessern. Dazu musst du auf Status klicken. Unten stehen deine vorhandene Anzahl an Charakterpunkten und Korrekturpunkten. Nun kannst du diese Punkte auf die Statuswerte verteilen. Wenn du denkst das du bei der Verteilung der Punkte einen Fehler gemacht hast so kannst du die Änderung zurücknehmen, solange du genug Korrekturpunkte hast.")
    
    npc_message(npc, ch, "Also achte darauf, dass du deine Charakterpunkte auf die richtigen Werte verteilst.")
end

local function valaia_talk(npc, ch)
    npc_message(npc, ch, "Du sieht aus wie jemand der Handeln möchte. Mmmh was gibt es denn da zu erzählen. Also es gibt zwei Arten zu handeln, einmal mit NPCs und einmal mit deinen Mitspielern.")
    
    local quest_string = "vacare_first_trade"
    invertika.init_quest_status(ch, quest_string)
    if invertika.get_quest_status(ch, quest_string) == 0 then
      npc_message(npc, ch, "Ich sehe du hast gar kein Geld bei dir. Nun ja ich will mal nicht so sein, nimm ein bischen von meinem.")
      invertika.add_money(ch, 500)
      invertika.set_quest_status(ch, quest_string, 1)
    end
    
    npc_message(npc, ch, "Also fangen wir am besten mit dem Handel zwischen dir und einem NPC an. Du kannst bei einem NPC Dinge kaufen und auch verkaufen. Was du kaufen kannst und was nicht legt der NPC fest. Was möchtest du tun?")
    
    while true do 
        local v = npc_choice(npc, ch, "Kaufen",
                                     "Verkaufen",
                                     "Nichts danke.")
                                   
        if v == 1 then
            npc_trade(npc, ch, false, { {10001, 10, 20}, {30001, 999, 300}, {40028, 999, 500}, {40005, 999, 30} })
        elseif v == 2 then
            npc_trade(npc, ch, true, { {10001, 10, 20}, {30001, 999, 30}, {40028, 999, 50}, {40005, 999, 30} })
        elseif v == 3 then
            break
        end
    end
    
    npc_message(npc, ch, "Gut du hast genug gehandelt. Neben dem NPC Handel gibt es noch den Handel mit anderen Spielern. Um mit einem Spieler zu handeln klicke mit der rechten Maustaste auf ihn und wähle Handeln aus dem Menü aus.")
    
    npc_message(npc, ch, "Daraufhin öffnet sich ein Fenster. Zusätzlich solltest du das Inventarfenster öffnen. Wähle nun ein Item aus und drücke im Handelsfenster auf Hinzufügen. Dadurch wird das Item dem Handel hinzugefügt. Wenn du den Handel beenden möchtest so klicke auf Vorschlagen und dann auf Bestätigen. Der Handel ist damit abgeschlossen.")
    
    npc_message(npc, ch, "Ja das wars auch schon zum Thema Handel.")
end

local function asam_talk(npc, ch)
    npc_message(npc, ch, "Die erste Devise von Invertika ist, das es so wenige Regeln wie möglich geben soll. Ganz einfach aus dem Grund das wir der Meinung sind das jede Regel doch eine gewisse Einschränkung darstellt. Doch gibt es einige Empfehlungen: ")

    npc_message(npc, ch, "Nummero 1: Seid nett zueinander.")
    
    npc_message(npc, ch, "Nummero 2: Kein SPAM!")
    
    npc_message(npc, ch, "Nummero 3: Die Spielsprache ist Deutsch. Dies bezieht sich nur auf den offnen Chat (im Fenster Allgemein). In Gildenchats darf natürlich jede andere Sprache gesprochen werden.")
    
    npc_message(npc, ch, "Wie gesagt sind dies Empfehlungen, aber wer weiß was die anderen Spieler machen wenn sie euch beim Spammen erwischen :) Ich wünsche dir viel Spaß.")
end

local function corona_talk(npc, ch)
    npc_message(npc, ch, "Wo du bist nachdem du gestorben bist? Das kann ich dir sagen. Jeder der stirbt findet sich im Nex wieder. Es ist ein Ort voller Frieden, wie das Vacare. Allerdings gibt es ein paar Dinge zu beachten.")
    
    npc_message(npc, ch, "Jedes Mal wenn du stirbst verlierst du ein Drittel deines Bargeldes. Deshalb darfst du nie zu viel Bargeld mit dir herum schleppen. Du kannst dein überschüssiges Geld aber zur Bank bringen. Dort wird es sogar verzinst. Und wenn du stirbst ist es dort sicher.")
    
    npc_message(npc, ch, "Also hüte dich und kämpfe keinen ausichtslosen Kampf...")
    
    npc_message(npc, ch, "Eine Sache noch: Wenn du das Reich der Toten verlässt wirst du zu der Netheksäule gebracht, bei welcher du zuletzt um den Segen gebeten hast, also halte Ausschau nach Ihnen.")
end

local function vacaria_talk(npc, ch)
    npc_message(npc, ch, "Bist du bereit für das große Abenteuer?")
    
    while true do 
        local v = npc_choice(npc, ch, "Ja.",
                                     "Nein.")
                                   
        if v == 1 then
            chr_warp(ch,  61, 179 * TILESIZE, 151 * TILESIZE) 
            npc_message(npc, ch, "Willkommen in Selphi Timlet. Das Abenteuer beginnt...")
            break;
        elseif v == 2 then
            npc_message(npc, ch, "Gut, dann übe noch ein wenig.")
            break;
        end
    end
end

local function essar_talk(npc, ch)
    npc_message(npc, ch, "Ich bin hier um dir zu erklären wie du mit anderen Spielern kommunizieren kannst.")
    npc_message(npc, ch, "Als erstes gibt es den normalen Chat.")
    npc_message(npc, ch, "Wenn du im Spiel Enter drückst erscheint ein Cursor im Chatfenster.")
    npc_message(npc, ch, "Hier kannst du deine Nachricht eingeben.")
    npc_message(npc, ch, "Diese Nachricht wird aber nur in deinem unmittelbarem Umfeld wahrgenommen.")
    npc_message(npc, ch, "Falls man nun aber Nachrichten an Spieler schreiben möchte die weiter entfernt sind muss man eine andere Chatweise wählen.")
    npc_message(npc, ch, "Diese Weise nennt sich \"whispern\". Um einem Spieler damit anzuschreiben muss man in das Chatfenster /w <Spielernamen> <mein Text> eingeben.")
    npc_message(npc, ch, "Wenn der Spielername Leerzeichen enthält muss der Spielername von Anführungszeichen \" umgeben werden.")
    npc_message(npc, ch, "Da dies nur mit einzelnen Spielern geht gibt es auch eine Möglichkeit mit mehreren Spielern über weitere Strecken zu kommunizieren.")
    npc_message(npc, ch, "Dies geschieht indem du einem Kanal beitrittst. Das kannst du ganz einfach mittels /join <Kanalname> machen.")
    npc_message(npc, ch, "Es öffnet sich ein neuer Tab im Chatfenster und du kannst dort mit anderen Leuten chatten.")
    npc_message(npc, ch, "Falls du nun als Neuling Kontakt zu anderen Spielern suchst empfiehlt sich als erstes mal dem invertika Kanal beizutreten: /join invertika.")
    npc_message(npc, ch, "Ist dort niemand da kannst du mal schauen wer grade generell online ist: /who. Dies zeigt dir eine Liste aller Spieler an die Online sind.")
    npc_message(npc, ch, "Dann kannst du mittels /w <Spielername> <text> einen der Spieler anschreiben.")
    npc_message(npc, ch, "Hilfe über diese und weitere Befehle kannst du über /help jederzeit abrufen.")
    npc_message(npc, ch, "Viel Spaß mit Invertika.")
end

atinit(function()
 --- Erster Start
 trigger_create(115 * TILESIZE, 15 * TILESIZE, 50 * TILESIZE, 23 * TILESIZE, firststart_trigger, 0, true) --- Erste Meldung
 
 -- Zelan
 npc_create("Zelan", 58, GENDER_UNSPECIFIED, 132 * TILESIZE + 16, 21 * TILESIZE + 16, zelan_talk, nil) --- Zelan
 
 -- Zeitungsjunge
 npc_create("Jack", 34, GENDER_UNSPECIFIED, 159 * TILESIZE + 16, 31 * TILESIZE + 16, jack_talk, nil) --- Jack
 
 -- Zaun NPC 
 npc_create("Ancoise", 25, GENDER_UNSPECIFIED, 137 * TILESIZE + 16, 41 * TILESIZE + 16, ancoise_talk, nil) --- Ancoise

 -- Kampf NPC
 npc_create("Kolbert", 30, GENDER_UNSPECIFIED, 156 * TILESIZE + 16, 66 * TILESIZE + 16, kolbert_talk, nil) --- Kolbert
 
 -- Levelup NPC
 npc_create("Syntyche", 25, GENDER_UNSPECIFIED, 142 * TILESIZE + 16, 110 * TILESIZE + 16, syntyche_talk, nil) --- Syntyche
 
 -- Handel Valaia 
 npc_create("Valaia", 60, GENDER_UNSPECIFIED, 102 * TILESIZE + 16, 83 * TILESIZE + 16, valaia_talk, nil) --- Valaia
 
 -- Regeln Asam 
 npc_create("Asam", 72, GENDER_UNSPECIFIED, 66 * TILESIZE + 16, 130 * TILESIZE + 16, asam_talk, nil) --- Asam
 
 -- Kommunikation mit Spielern Essar
 npc_create("Essar", 21, GENDER_UNSPECIFIED, 68 * TILESIZE + 16, 124 * TILESIZE + 16, essar_talk, nil)
 
 -- Leben und Sterben Corona  
 npc_create("Corona", 12, GENDER_UNSPECIFIED, 89 * TILESIZE + 16, 135 * TILESIZE + 16, corona_talk, nil) --- Corona 
 
 -- Verlassen des Vacare
 npc_create("Vacaria", 1, GENDER_UNSPECIFIED, 103 * TILESIZE, 139 * TILESIZE + 16, vacaria_talk, nil) --- Vacaria
end)
