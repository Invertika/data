----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                          --
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
    create_npc("Metatron", 36, 17 * TILESIZE + 16, 21 * TILESIZE + 16, metatron_talk, nil) --- Metatron
end)

function metatron_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element(
      "Ich bin die Stimme...",
      "Durch mich spricht sie...",
      "So höre mir zu..."))
    do_npc_close(npc, ch)
end
