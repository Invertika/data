-- Externe Map Skripting Datei
-- In dieser Datei stehen die entsprechenden externen NPCs, Trigger und anderer Dinge.
--
-- © 2008-2011 by The Invertika Development Team
--
-- This file is part of Invertika. Invertika is free software; you can redistribute 
-- it and/or modify it under the terms of the GNU General  Public License as published 
-- by the Free Software Foundation; either version 3 of the License, or any later version.


require "scripts/lua/npclib"


atinit(function()
    npc_create("Echver", 57, 40 * TILESIZE + 16, 22 * TILESIZE + 16, echver_talk, nil)
end)

function echver_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element(
      "Ich bin der Priester dieser Stadt.",
      "Geheiligt sei Invertika, Amoneus und die Bewohner dieses Planeten.",
      "Leider besuchen die Jungen Leute die Kirchen des Landes nicht mehr. Nur noch bei wichtigen Festen sind sie anwesend."))
    do_npc_close(npc, ch)
end