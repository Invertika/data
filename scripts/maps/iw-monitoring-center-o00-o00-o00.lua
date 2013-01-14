----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2011 The Invertika Development Team                          --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------


require "scripts/lua/npclib"
require "scripts/libs/invertika"

atinit(function()
    npc_create("Sei", 111, GENDER_UNSPECIFIED, 11 * TILESIZE + 16, 34 * TILESIZE + 16, sei_talk, nil) --- Sei
    npc_create("Jo", 124, GENDER_UNSPECIFIED, 22 * TILESIZE + 16, 32 * TILESIZE + 16, jo_talk, nil) --- Jo
    npc_create("Leo", 146, GENDER_UNSPECIFIED, 57 * TILESIZE + 16, 23 * TILESIZE + 16, leo_talk, nil) --- Leo
    npc_create("Meg", 65, GENDER_UNSPECIFIED, 20 * TILESIZE + 16, 32 * TILESIZE + 16, meg_talk, nil) --- Meg
    npc_create("Amy", 18, GENDER_UNSPECIFIED, 14 * TILESIZE + 16, 9 * TILESIZE + 16, amy_talk, nil) --- Amy

    npc_create("Bert", 28, GENDER_UNSPECIFIED, 34 * TILESIZE + 16, 9 * TILESIZE + 16, bert_talk, nil) --- Bert
    npc_create("Sascha", 54, GENDER_UNSPECIFIED, 15 * TILESIZE + 16, 14 * TILESIZE + 16, sascha_talk, nil) --- Sascha
    npc_create("David", 21, GENDER_UNSPECIFIED, 53 * TILESIZE + 16, 11 * TILESIZE + 16, david_talk, nil) --- David
    npc_create("Jan", 50, GENDER_UNSPECIFIED, 41 * TILESIZE + 16, 21 * TILESIZE + 16, jan_talk, nil) --- Jan
    npc_create("Jens", 64, GENDER_UNSPECIFIED, 21 * TILESIZE + 16, 27 * TILESIZE + 16, jens_talk, nil) --- Jens
    npc_create("Lora", 55, GENDER_UNSPECIFIED, 12 * TILESIZE + 16, 21 * TILESIZE + 16, lora_talk, nil) --- Lora
end)

local function sei_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Willkommen im Überwachungszentrum, hast du etwas zu essen mitgebracht?",
      "Denk daran, alles zu vergessen wenn du uns verlässt.",
      "Alles was du hier siehst ist streng geheim.",
      "Wir überwachen ganz bestimmte Organisationen.",
      "Ich habe hier das Sagen."))
end

local function jo_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Wenn du meinst...",
      "Du redest zu viel...",
      "Warten bis zum nächsten Auftrag...",
      "Solltest du nicht für das Essen sorgen...",
      "Ich habe keinen Hunger."))
end

local function leo_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Ich kümmere mich hier um die Technik.",
      "Die Transceiverkerne verbrauchen aus irgendeinem Grund zu viel Strom.",
      "Das schlimme ist, wenn du alles richtig machst merkt es keiner.",
      "Als nächstes müssen die Bandspeicher überprüft werden.",
      "Mist schon wieder abgestürzt."))
end

local function meg_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Jo, diese mechanischen Gehirne waren doch seltsam oder?",
      "Man habe ich wieder einen Hunger, warum hast du noch nichts gekocht?",
      "Jo, wollen wir nach Alexia ein bisschen was einkaufen? Sag mal belauschst du uns etwa?",
      "So Munition verstaut, Waffe geladen und gesäubert. Kann losgehen.",
      "Irgendwie langweilig wenn nichts los ist."))
end

local function amy_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "So die Datenverbindung herstellen und schon kann es losgehen.",
      "Mmm, dieser Algorithmus ist ziemlich komplex. Ich sollte ihn rekursiv gestalten.",
      "So, noch ein paar Minuten und ich habe alle Daten heruntergeladen.",
      "Dieses Programm könnte uns noch nützlich sein.",
      "Erstaunlich. Wer auch immer das geschrieben hat, hat eine Menge Ahnung."))
end

local function bert_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Schauen wir mal was die Konkurrenz so macht.",
      "Oh bei The Mana World wird eine neue Stadt gebaut, da müssen wir etwas tun.",
      "Server Check für The Mana World wurde vorgenommen, er läuft immer noch auf eAthena.",
      "Webseite von The Mana World unverändert, soweit ich das sehen kann.",
      "Interessante Onlineanzeige."))
end

local function sascha_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Ich überwache The Alternate World.",
      "Mmm da stimmt irgendwas mit den Grafiken nicht.",
      "Interessante organische Maps. Das sollten wir auch machen.",
      "Und so füge ich dem Bericht X33/2 die Anmerkung zur genaueren Untersuchung hinzu.",
      "Vielleicht doch nicht so wichtig, aber ich schreibe es mir mal auf."))
end

local function david_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Ich überwache die visuellen Kanäle.",
      "Oh, die haben einen neuen Werbespot geschaltet, das muss ich sofort melden.",
      "Mmmm, der neue Invertika Spot sollte doch längst auf Sendung sein.",
      "Der Darsteller des neusten Manasource basierenden Projektes hat Charisma. Das könnte zu einem Problem werden.",
      "Gut, schauen wir nun mal auf den anderen Kanälen."))
end

local function jan_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Ziemlich durcheinander dort, wird alles ziemlich chaotisch.",
      "Interessant, keine Mapper und Grafiker, zumindestens offiziell.",
      "Oh, ich sehe, sie haben einige Werbespots.",
      "Aha, eine spezifische Ausrichtung auf ein deutschsprachiges Publikum.",
      "Ziemlich viele Serverausfälle laut dieser Anzeige."))
end

local function jens_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Schauen wir mal was die Zielgruppenanalyse dazu sagt.",
      "Ziemlich viel übernommen, kaum eigene Maps. Aber einige neue Städte. Interessant...",
      "So Punkt 4 und 5 der Checkliste wurden überprüft, auf zu Punkt 6.",
      "Mmm ich kann kein einheitliches System entdecken.",
      "Der Umgang der Community lässt zu wünschen übrig."))
end

local function lora_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Da schauen wir doch mal ob wir an diese Information kommen.",
      "Er wird es mir sicherlich gleich verraten. Na da ist die Nachricht ja. Interessant...",
      "Diese Informationen sollten sofort an Sei weitergeleitet werden, das könnte in einem operativen Einsatz münden.",
      "Ah da ist der neue Bericht. Schauen wir mal rein.",
      "Noch 40 Berichte zum lesen. Na dann wollen wir mal..."))
end
