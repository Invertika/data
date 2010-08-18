----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2010 The Invertika Development Team                        --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/ivklibs/invertika"

dofile("data/scripts/ivklibs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(1, 57, 3, 13) --- Intermap warp

 create_npc("Jurkan", 33, 80 * TILESIZE + 16, 115 * TILESIZE + 16, jurkan_talk, nil) --- Jurkan
 create_npc("Holzbein", 42, 83 * TILESIZE + 16, 115 * TILESIZE + 16, holzbein_talk, nil) --- Holzbein
 create_npc("seeseekey", 24, 93 * TILESIZE + 16, 118 * TILESIZE + 16, seeseekey_talk, nil) --- seeseekey
 create_npc("Delegan", 87, 81 * TILESIZE + 16, 122 * TILESIZE + 16, delegan_talk, nil) --- Delegan
end)

function jurkan_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Irgendwie ist mir zu heiß hier...",
	  "Glaub mir, das hier war nicht geplant.",
	  "Das habe ich nun davon, seeseekey geholfen zu haben. Wer das ist? Der da drüben!",
	  "ICH habe euch geschaffen, das mit Invertika ist alles Quatsch!!!!!",
	  "Warum anderen das Leben schwermachen, wenn man es ihnen nehmen kann?",
	  "Könnte mir vielleicht nochmal jemand was zu trinken bringen? Mit viel Eis?",
	  "Ich steh hier nur so rum, das ist schöpferische Willkür.",
	  "Nicht zu fassen. Überall diese Dingsbums.",
	  "while true; do echo Blubb; done; Blubb blubb blubb blubb blubb...",
	  "Seit ich hier in der Wüste bin, habe ich Schweissfüße!"))
	  do_npc_close(npc, ch)
end

function holzbein_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Wo ist mein Kamel?",
	  "Lieber Arm dran, als Arm ab.",
	  "Steck den Spaltenvektor in die Vektorspalte.",
	  "Um Pirat zu werden, musst du schon mehr machen als CDs brennen!",
	  "Der Tisch ist neidisch auf mein Holzbein.",
	  "Wo ist meine Brille?",
	  "Was hat das zu bedeuten?"))
	  do_npc_close(npc, ch)
end

function delegan_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Zu eckig, zu pixelig, zu virtuell! Neubauen!",
	  "Ob jeder so einfach Berge, Täler, Seen und Flüsse aus dem nichts erschaffen kann?",
	  "Sonne, Mond und Sterne, ich bau mir eine Taverne.",
	  "Mauszeiger hier, Mauszeiger dort und alles ist hin fort.",
	  "Ups... Sollte hier nicht "Leretica" stehen?",
	  "Ich glaube ich habe was vergessen. Naja, sie kommen ja immer noch durch die Fenster rein.",
	  "Ach herje... wo war noch gleich der eingebaute Geheimraum?!",
	  "Muh, Muh, Muh, macht die Kuh, Mäh, Mäh, Mäh, macht das Schaf, Wuff, Wuff, Wuff, macht der Enzyan... dieses doofe Lied... will mir nicht aus dem Kopf...",
	  "Gut, Dann kommt der Berg eben dort hin. Kein Problem. Wird sofort erledigt.",
	  "Brauchen sie einen Urwald mit kurzen Lieferzeiten und für wenig Geld?  Nicht verzagen, Mapper fragen."))
	do_npc_close(npc, ch)
end






