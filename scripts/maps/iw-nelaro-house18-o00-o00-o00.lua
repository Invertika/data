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
    --TODO Change Sprite ID
    hobal = create_npc("Hobel", 2, 33 * TILESIZE + 16, 36 * TILESIZE + 16, hobel_talk, invertika.npc_talk_random)
    invertika.create_npc_talk_random(hobel,
      {"Hilfe! Hilfe! Ein Geist!!",
      "Ich hab ein Brett vorm Kopf.",
      "Kann man das trinken oder ist das Strom?"})
end)

function hobel_talk(npc, ch)
    do_message(npc, ch, "...")
    do_npc_close(npc, ch)
end