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

atinit(function()
 create_npc("...", 1, 68 * TILESIZE + 16, 18 * TILESIZE + 16, tresor_talk, nil) --- Tresor
end)

function tresor_talk(npc, ch)
	-- quest init
	if tonumber(get_quest_var(ch, "selphi_timlet_flat03_safe")) == nil then
	  mana.chr_set_quest(ch, "selphi_timlet_flat03_safe", 0)
	end
  
	-- quest get/set functions
	function get_qstatus() return tonumber(get_quest_var(ch, "selphi_timlet_flat03_safe")) end
	function set_qstatus(x) mana.chr_set_quest(ch, "selphi_timlet_flat03_safe", tonumber(x)) end
  
	if get_qstatus()==0 then
	  do_message(npc, ch, "Hinter dem Bild befindet sich etwas. Mal schauen. Oh das ist ein Tresor. Mmm da schaue ich mal hinein. Bloß wie bekomme ich ihn auf?")
	
	  while true do 
	  	  local v = do_choice(npc, ch, "Dynamit benutzen", "Nett anklopfen", "Zweimal links, einmal rechts, dreimal diagonal, koxiales Relais + Solantriebskala Stufe 10 x Pi, Kartoffel und Schnitt-Lauch im Sinn...", "42", "Die Zahlenkombination auf der Rückseite des Bildes benutzen")
								   
		  if v == 1 then
			do_message(npc, ch, "Ähm ich habe gar kein Dynamit.")
			--TODO Dynamit als Item einbauen
			--set_qstatus(2)
			break
		  elseif v == 2 then
			do_message(npc, ch, "Nein, bin gerade beschäftigt. Inventur. Bitte kommen sie während unserer Servicezeiten nochmal.")
			break
		  elseif v == 3 then
			do_message(npc, ch, "Da wir uns zu jeder Zeit, gleichzeitig im Universum befinden und alles Wissen erlangen das es gibt, wissen wir das diese Option die falsche war.")
			break
		  elseif v == 4 then
			do_message(npc, ch, "Wie jetzt? Das kann nicht dein Ernst sein.")
			break
		  elseif v == 5 then
			do_message(npc, ch, "Ein Zettel. Mal sehen was draufsteht: Diebstahl lohnt sich nicht.")
			set_qstatus(1)
			break
		  end
	  end
	elseif get_qstatus()==1 then
	  do_message(npc, ch, "Der Tresor ist offen und leer.")
	elseif get_qstatus()==2 then
	  do_message(npc, ch, "Der Tresor ist durch die Explosion verzogen und lässt sich nicht mehr öffnen.")
	end
	
	do_npc_close(npc, ch)
end