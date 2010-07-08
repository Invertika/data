----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------
 
require "scripts/lua/npclib"
require "scripts/ivklibs/invertika"

atinit(function()
 create_npc("Botschafter", 66, 51 * TILESIZE + 16, 31 * TILESIZE + 16, botschafter_talk, nil)
end)

function botschafter_talk(npc, ch)
	--print(get_quest_var(ch, "selphi_timlet_royal_pass"), type(get_quest_var(ch, "selphi_timlet_royal_pass")))
	if (get_quest_var(ch, "selphi_timlet_royal_pass")=="") then ---Keine Questvar gesetzt
	do_message(npc, ch, invertika.get_random_element("Ich bin hier der Botschafter. Ich vertrete Selphi Timlet in Roststock.",
	  "Ich bin schon viele Jahre hier.",
	  "Kenne ich dich?",
	  "Was ist denn? Nichts. Gut dann lass mich weiter arbeiten.",
	  "Im Moment nicht ich bin beschäftigt",
	  "Ich würde mal gerne zum Meer."))
	elseif (tonumber(get_quest_var(ch, "selphi_timlet_royal_pass"))==1) then
	   local count = mana.chr_inv_count(ch, 40011) 
	   
	   if count > 0 then
	      mana.chr_inv_change(ch, 40011, -1, 40012, 1) -- NOTE: 2 einzelne Funktionsaufrufe fuer die Items funktionieren nicht (bug?).
	      mana.chr_set_quest(ch, "selphi_timlet_royal_pass", 2)
	      do_message(npc, ch, "Oh ein Brief. Warte einen Moment... Hier nimm diese Antwort und bringe sie Averin.")
	   else
		  do_message(npc, ch, "Ihr seid nicht zufällig der Bote von Avarin? Ich erwarte einen wichtigen Brief von ihm!")
	   end
	elseif (tonumber(get_quest_var(ch, "selphi_timlet_royal_pass"))==2) then
	  do_message(npc, ch, invertika.get_random_element("Schnell, bringt Avarin den Brief!",
	  "Worauf wartet ihr noch?"))
	elseif (tonumber(get_quest_var(ch, "selphi_timlet_royal_pass"))>=3) then
	  do_message(npc, ch, invertika.get_random_element("Danke für deine Hilfe.",
	  "Dankeschön.",
	  "Nein es ist nichts mehr.",
	  "Ich muss nun weiterarbeiten."))
	end

	do_npc_close(npc, ch)
end
