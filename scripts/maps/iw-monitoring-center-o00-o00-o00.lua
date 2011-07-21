----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                          --
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
 create_npc("Sei", 111, 11 * TILESIZE + 16, 33 * TILESIZE + 16, sei_talk, nil) --- Sei
 create_npc("Jo", 124, 22 * TILESIZE + 16, 32 * TILESIZE + 16, jo_talk, nil) --- Jo
 create_npc("Leo", 146, 57 * TILESIZE + 16, 23 * TILESIZE + 16, leo_talk, nil) --- Leo
 create_npc("Meg", 65, 20 * TILESIZE + 16, 32 * TILESIZE + 16, meg_talk, nil) --- Meg
end)

function sei_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Willkommen im Überwachungszentrum, hast du etwas zu essen mitgebracht?",
	    "Denk daran, alles zu vergessen wenn du uns verlässt.",
	    "Alles was du hier siehst ist streng geheim.",
	    "Wir überwachen, ganz bestimmte Organisationen.",
	    "Ich habe hier das sagen."))
	do_npc_close(npc, ch)
end

function jo_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Wenn du meinst...",
	    "Du redest zu viel...",
	    "Warten bis zum nächsten Auftrag...",
	    "Solltest du nicht für das Essen sorgen...",
	    "Ich habe keinen Hunger."))
	do_npc_close(npc, ch)
end

function leo_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Ich kümmere mich hier um die Technik.",
	    "Die Transcieverkerne verbrauchen aus irgendeinem Grund zu viel Strom.",
	    "Das schlimme ist, wenn du alles richtig machst merkt es keiner.",
	    "Als nächstes müssen die Bandspeicher überprüft werden.",
	    "Mist schon wieder abgestürzt."))
	do_npc_close(npc, ch)
end

function meg_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Jo, diese mechanischen Gehirne waren doch seltsam oder?",
	    "Man habe ich wieder einen Hunger, warum hast du noch nichts gekocht?",
	    "Jo, wollen wir nach Alexia ein bischen was einkaufen? Sag mal belauscht du uns etwa?",
	    "So Munition verstaut, Waffe geladen und gesäubert. Kann losgehen.",
	    "Irgendwie langweilig wenn nichts los ist."))
	do_npc_close(npc, ch)
end