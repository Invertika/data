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
require "scripts/libs/sign"
require "scripts/libs/invertika"

dofile("data/scripts/libs/warp.lua")

atinit(function()
    create_inter_map_warp_trigger(97, 107, 95, 85) --- Intermap warp

    sign_entrance = "Narva"
    sign.create_sign(154, 128, sign_entrance) --- Schild Ortseingang
    sign.create_sign(62, 106, sign_entrance) --- Schild Ortseingang
    sign.create_sign(95, 47, sign_entrance) --- Schild Ortseingang

    create_npc("Awond", 120, 159 * TILESIZE, 40 * TILESIZE, awond_talk, nil)
end)

function awond_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Sei gegrüßt Reisender!",
      "Das war ein harter Tag.",
      "Ich hoffe meine Frau macht schonmal das Abendessen.",
      "Setz dich doch zu mir."))
    do_npc_close(npc, ch)
end
