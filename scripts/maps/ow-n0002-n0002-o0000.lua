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

require "scripts/libs/warp"


local function peter_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Gerade Kanten und symmetrisch muss es sein.",
      "Wir sorgen dafür das in der Welt von Invertika eine gewisse Gradlinigkeit herrscht.",
      "Ich bin hier der mit dem 90 Grad Winkelmaß.",
      "Akkurat muss es geschnitten sein, Akkurat!",
      "Bei uns wird das sehr sehr gewissenhaft gemacht."))
end

local function hans_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Wir sind Landschaftsgärtner. Das muss schließlich alles seine Ordnung haben.",
      "Da drüben haben wir ein kleines Problem mit dieser Blume. Schrecklich.",
      "Jetzt steht diese Blume dort schon seit 5 Tagen und wir haben noch kein Mittel gegen sie gefunden.",
      "Das mit der Blume hätte nicht passieren dürfen."))
	
	local queststring = "monument_of_bugfixer_flower_quest"
    
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)
	
	if quest_var == 1 then
		npc_message(npc, ch, "Wie, du brauchst eine Blume?")
		npc_message(npc, ch, "Hier, die schenke ich dir.")
		invertika.add_items(ch, 40053, 1, "Blume")
	end
	
end

local function siegfried_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Wir sorgen für Ordnung und Ordnung und ganz wichtig Ordnung.",
      "Verdammt, was macht diese Blume hier?",
      "Diese Blume zerstört die Perfektion.",
      "Neeeeeeeeeeeeeeiiiiiiiiiiiiinnnnnnnn, diese Blume darf nicht sein."))
end

atinit(function()
 create_inter_map_warp_trigger(12, 2, 14, 24) --- Intermap warp
 
 npc_create("Peter", 46, GENDER_UNSPECIFIED, 78 * TILESIZE + 16, 42 * TILESIZE + 16, peter_talk, nil) --- Peter
 npc_create("Hans", 46, GENDER_UNSPECIFIED, 88 * TILESIZE + 16, 43 * TILESIZE + 16, hans_talk, nil) --- Hans
 npc_create("Siegfried", 46, GENDER_UNSPECIFIED, 101 * TILESIZE + 16, 42 * TILESIZE + 16, siegfried_talk, nil) --- Siegfried
end)
