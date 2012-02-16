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
require "scripts/libs/invertika"

atinit(function()
    --TODO: bessere Namen
    create_npc("Koch", 52, 33 * TILESIZE + 16, 38 * TILESIZE + 16, koch_talk, nil)
    create_npc("Ghang", 60, 20 * TILESIZE + 16, 37 * TILESIZE + 16, nil, nil)
    create_npc("Estform", 117, 2 * TILESIZE + 16, 31 * TILESIZE + 16, nil, nil)
    create_npc("Ingawu", 17, 19 * TILESIZE + 16, 29 * TILESIZE + 16, nil, nil)
    create_npc("Ackona", 4, 32 * TILESIZE + 16, 30 * TILESIZE + 16, nil, nil)
end)

function koch_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element(
      "Ein Ei + noch  ein Ei + Brattpfanne = Spiegelei",
      "Bei der Hitze hier kommt man leicht ins schwitzen. Musst viel trinken."))
    do_npc_close(npc, ch)
    end