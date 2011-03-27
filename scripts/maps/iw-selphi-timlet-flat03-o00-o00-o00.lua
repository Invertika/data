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
require "scripts/libs/invertika"

atinit(function()
 create_npc("...", 1, 68 * TILESIZE + 16, 18 * TILESIZE + 16, tresor_talk, nil) --- Tresor
 create_npc("Ceech", 54, 38 * TILESIZE + 16, 22 * TILESIZE + 16, ceech_talk, nil) --- Ceech
end)

function tresor_talk(npc, ch)
	-- quest init
        invertika.init_quest_status(ch, "selphi_timlet_flat03_safe")

	-- quest get/set functions
	function get_qstatus() return invertika.get_quest_status(ch, "selphi_timlet_flat03_safe") end
	function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_flat03_safe", x) end
  
	if get_qstatus()==0 then
	  do_message(npc, ch, "Hinter dem Bild befindet sich etwas. Mal schauen. Oh das ist ein Tresor. Mmm da schaue ich mal hinein. Bloß wie bekomme ich ihn auf?")
	
	  while true do 
	  	  local v = do_choice(npc, ch, "Dynamit benutzen", "Nett anklopfen", "Zweimal links, einmal rechts, dreimal diagonal...", "42", "Die Zahlenkombination auf der Rückseite des Bildes benutzen")
								   
		  if v == 1 then
			local countDynamite = mana.chr_inv_count(ch, 40025)
			if countDynamite == 0 then
			  do_message(npc, ch, "Ähm ich habe gar kein Dynamit.")
			else
			  mana.chr_inv_change(ch, 40025, -1)
			  mana.effect_create(151, 68 * TILESIZE + 16, 18 * TILESIZE + 16)
			  mana.being_damage(ch, 200, 100, 100, 0, 0)
			  set_qstatus(2)
			end
			
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

function ceech_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Lass mich arbeiten!",
      "Ich habe zu tun.",
      "Jetzt nicht.",
      "Schhhhh."))
    do_npc_close(npc, ch)
end
