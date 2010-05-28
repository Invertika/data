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

require "scripts/libs/npclib"

require "scripts/libs/npclib"
require "scripts/ivklibs/invertika"

atinit(function()
 create_npc("Averin", 125, 175 * TILESIZE + 16, 25 * TILESIZE + 16, averin_talk, nil) --- Elmo
end)

function averin_talk(npc, ch)

	if (get_quest_var(ch, "selphi_timlet_royal_pass")=="") then ---Keine Questvar gesetzt
	  do_message(npc, ch, "Hallo, was ist dein Begehr?")
	  while true do 
		  local v = do_choice(npc, ch, "Wer bist du?",
					      "Ich suche einen königlichen Passierschein.",
					      "Nichts. Danke.")
								    
		  if v == 1 then
			  do_message(npc, ch, invertika.get_random_element("Ich bin Averin, Chef der königlichen Palastwache.",
			  "Mein Name ist Averin. Mir untersteht die königliche Palastwache.",
			  "Ich bin Averin und bin zuständig für die Sicherheit des Palastes.",
			  "Mein Name tut nichs zur Sache, oder doch?",
			  "Ich bin für die Sicherheit im Selphi Timlet zuständig.",
			  "Ich sichere mit den Palastwachen die Stadt."))
			  break
		  elseif v == 2 then
			  do_message(npc, ch, "Du möchtest also einen königlichen Passierschein? Nun gut, aber vorher musst du mir einen Gefallen tun. Bringe diesen Brief bitte in die Botschaft in Roststock.")
			  mana.chr_inv_change(ch, 40011, 1)
			  mana.chr_set_quest(ch, "selphi_timlet_royal_pass", 1)
			  break
		  elseif v == 3 then
			  do_message(npc, ch, "Dann gehe wie du gekommen bist.")
			  break
		  end
	  end
	elseif (tonumber(get_quest_var(ch, "selphi_timlet_royal_pass"))==1) then --- Hier kann der Quest weitergeführt werden
	  do_message(npc, ch, invertika.get_random_element("Mach die schnell auf den Weg.",
	  "Was machst du noch hier? Schnell, der Brief ist wichtig.",
	  "Du bist ja immer noch hier? Müsstest du nicht längst auf dem Weg nach Roststock sein?"))
	elseif (tonumber(get_quest_var(ch, "selphi_timlet_royal_pass"))==2) then
	  local count = mana.chr_inv_count(ch, 40012) 
	
	  if count > 0 then
	      mana.chr_inv_change(ch, 40012, -1, 40009, 1)
	      mana.chr_set_quest(ch, "selphi_timlet_royal_pass", 3)
	      do_message(npc, ch, "Danke für deine Hilfe. Hier ist dein königlicher Passierschein.")
	  else
	      do_message(npc, ch, invertika.get_random_element("Wo ist das Antwortschreiben?",
	      "Du solltest doch eine Antwort von der Botschaft mitbringen?",
	      "Hast du das Antwortschtreiben vergessen?"))
	  end
	elseif (tonumber(get_quest_var(ch, "selphi_timlet_royal_pass"))==3) then
	  do_message(npc, ch, invertika.get_random_element("Danke für deine Hilfe.",
	  "Wenn ich wieder mal jemanden brauche, sage ich es dir.",
	  "Im Moment habe ich nichts für dich."))
	end

	do_npc_close(npc, ch)
end
