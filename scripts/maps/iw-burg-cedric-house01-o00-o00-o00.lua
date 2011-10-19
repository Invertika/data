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
require "scripts/libs/invertika"

atinit(function()
    create_npc("Cedric", 39, 35 * TILESIZE + 16, 27 * TILESIZE + 16, nil, nil)
end)

cedric_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Ich bin Graf Cedric.", 
      "Fühle dich, in meiner Burg, wie zu Hause."))
    do_npc_close(npc, ch)
end
