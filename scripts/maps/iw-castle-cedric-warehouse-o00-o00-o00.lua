-- Externe Map Skripting Datei
-- In dieser Datei stehen die entsprechenden externen NPCs, Trigger und anderer Dinge.
--
-- © 2008-2011 by The Invertika Development Team
--
-- This file is part of Invertika. Invertika is free software; you can redistribute 
-- it and/or modify it under the terms of the GNU General  Public License as published 
-- by the Free Software Foundation; either version 3 of the License, or any later version.


require "scripts/lua/npclib"
require "scripts/libs/invertika"

atinit(function()
    create_npc("Trutim", 2, 23 * TILESIZE + 16, 32 * TILESIZE + 16, trutim_talk, nil)
end)

function trutim_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Endlich kommt mal wieder einer ins Lager.",
      "Hierhin verirrt sich selten eine Person.",
      "Ich bin für die Lagerung von Waren zuständig.",
      "Nur Personen mit Wohnrecht in Burg Cedric dürfen dieses Lager benutzen."
      ))
    do_npc_close(npc, ch)
end