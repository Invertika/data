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


atinit(function()
    --TODO: Change NPC Sprite
    create_npc("Dache", 21, 23 * TILESIZE + 16, 38 * TILESIZE + 16, dache_talk, nil)
end)

function dache_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element(
      "Noch ein Drink und dann wars das.",
      "So langsam sehe ich alles doppelt.",
      "Mmmm also ich weiß ja nicht."))
    do_npc_close(npc, ch)
end