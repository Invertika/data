----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------


require "scripts/lua/npclib"


atinit(function()

 create_npc("Saya", 7, 43 * TILESIZE + 16, 15 * TILESIZE + 16, saya_talk, nil) --- Saya
 create_npc("Tetse", 138, 45 * TILESIZE + 16, 23 * TILESIZE + 16, tetse_talk, nil) --- Tetse
end)

function saya_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Oh wir haben Gäste. Tetse deckst du denn Tisch ich bin fast fertig.",
	  "Tetse lernte ich vor sehr langer Zeit kennen.",
	  "Wir haben hier alles was wir brauchen.",
	  "Okita ist vor einiger Zeit gegangen, er sagte er müsse einige Dinge klären."))
	  do_npc_close(npc, ch)
end

function tetse_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Ja Saya, ich decke gleich den Tisch. Ich muss nur noch schnell mein Katana schärfen.",
	  "Sei willkommen Gast. Gleich gibt es etwas zu essen.",
	  "Du suchst Okita? Er ist schon lange Zeit nicht mehr hier gewesen. Ich glaube er wollte zur Küste.",
	  "Ja der Sandsturm wütet. Das geht schon die ganze Zeit so.",
	  "Warst du an ihrem Grab?"))
	  do_npc_close(npc, ch)
end