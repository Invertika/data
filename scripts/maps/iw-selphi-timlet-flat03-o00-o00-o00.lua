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
			  invertika.add_items(ch, 40025, -1, "Dynamit")
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
    local quest_string = "selphi_timlet_ceech_quest"
    invertika.init_quest_status(ch)
    local get_qstatus = function() return invertika.get_quest_status(ch, quest_string) end
    local set_qstatus = function(x) invertika.set_quest_status(ch, quest_string, x) end

    if get_qstatus() == 0 then
        do_message(npc, ch, "Hu. Ich war so in meine Arbeiten vertieft, dass ich dich nicht kommen sehen habe.")
        do_message(npc, ch, "Hättest du Lust diesen Brief hier zur Rezeption im Hotel zu bringen?")
        while true do
            local v = do_choice(npc, ch, "Ja.", "Nein.")
            if v == 1 then
                set_qstatus(1)
                invertika.add_items(ch, 40035, "Brief an die Rezeption", 1)
                do_message(npc, ch, "Sag mir Bescheid wenn du ihn vorbei gebracht hast.")
                break
            elseif v == 2 then
                do_message(npc, ch, "Dann halt nicht.")
                set_qstatus(-1)
                break
            end
        end
    elseif get_qstatus() == 1 then
        if mana.chr_inv_count(ch, 40035) == 0 then
            do_message(npc, ch, "Hast du den Brief abgegeben?")
            while true do
                local v = do_choice(npc, ch, "Ja.", "Nein. Ich habe ihn verloren.")
                if v == 1 then
                    do_message(npc, ch, "Du hast ihn verloren? Unzuverlässiger Bengel!")
                    set_qstatus(-1)
                    break
                elseif v == 2 then
                    do_message(npc, ch, "Hier. nimm diese Kokussnuss als Belohnung. Bald habe ich Anrecht auf die Kokussnuss Ernte!")
                    -- TODO: Eine Kokussnuss als Belohnung geben.
                    set_qstatus(2)
                    invertika.set_quest_status(ch, "selphi_timlet_rezeptionist_quest", -1)
                    break
                end
            end
        else
            do_message(npc, ch, "Was machst du noch hier? Du solltest doch den Brief wegbringen!")
        end
    elseif get_qstatus() == 2 then
        do_message(npc, ch, "Jetzt muss ich arbeiten.")
    elseif get_qstatus() == -1 then
        do_message(npc, ch, invertika.get_random_element("Lass mich arbeiten!",
        "Ich habe zu tun.",
        "Jetzt nicht.",
        "Schhhhh.", 
        "Hör auch zu stören!"))
    end
    do_npc_close(npc, ch)
end
