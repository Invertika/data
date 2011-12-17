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

atinit(function()
 create_inter_map_warp_trigger(12, 2, 14, 24) --- Intermap warp
 
 create_npc("Peter", 46, 78 * TILESIZE + 16, 42 * TILESIZE + 16, peter_talk, nil) --- Peter
 create_npc("Hans", 46, 88 * TILESIZE + 16, 43 * TILESIZE + 16, hans_talk, nil) --- Hans
 create_npc("Siegfried", 46, 101 * TILESIZE + 16, 42 * TILESIZE + 16, siegfried_talk, nil) --- Siegfried
end)

function peter_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Gerade Kanten und symmetrisch muss es sein.",
      "Wir sorgen dafür das in der Welt von Invertika eine gewisse Gradlinigkeit herrscht.",
      "Ich bin hier der mit dem 90 Grad Winkelmaß.",
      "Akkurat muss es geschnitten sein, Akkurat!",
      "Bei uns wird das sehr sehr gewissenhaft gemacht."))
    do_npc_close(npc, ch)
end

function hans_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Wir sind Landschaftsgärtner. Das muss schließlich alles seine Ordnung haben.",
      "Da drüben haben wir ein kleines Problem mit dieser Blume. Schrecklich.",
      "Jetzt steht diese Blume dort schon seit 5 Tagen und wir haben noch kein Mittel gegen sie gefunden.",
      "Das mit der Blume hätte nicht passieren dürfen."))
    do_npc_close(npc, ch)
end

function siegfried_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Wir sorgen für Ordnung und Ordnung und ganz wichtig Ordnung.",
      "Verdammt, was macht diese Blume hier?",
      "Diese Blume zerstört die Perfektion.",
      "Neeeeeeeeeeeeeeiiiiiiiiiiiiinnnnnnnn, diese Blume darf nicht sein."))
    do_npc_close(npc, ch)
end
