----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 The Invertika Development Team                               --
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
 ---create_npc("Banker", 122, 180 * TILESIZE + 16, 160 * TILESIZE + 16, banker.banker_talk, nil) --- Banker (Debug)
 create_npc("Icero", 80, 29 * TILESIZE + 16, 29 * TILESIZE + 16, icero_talk, nil) --- Icero
end)

function icero_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Es hat doch alles keinen Sinn mehr.",
                                                     "Ich habe keine Lust mehr.",
                                                     "*Gääääähn*",
                                                     "Hier ist nix los.",
                                                     "zZzzzzz. zZzzzzz. Wa? Hast du was gesagt?",
                                                     "Ich glaube ich geh schlafen..."))
    do_npc_close(npc, ch)
end
