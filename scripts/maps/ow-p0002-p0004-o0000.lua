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
require "scripts/libs/sign"
require "scripts/libs/invertika"

dofile("data/scripts/libs/warp.lua")

atinit(function()
    create_inter_map_warp_trigger(88, 98, 86, 76) --- Intermap warp

    sign_entrance = "Lauria"
    sign.create_sign(184, 92, sign_entrance) --- Schild Ortseingang
    sign.create_sign(99, 61, sign_entrance) --- Schild Ortseingang
    sign.create_sign(49, 133, sign_entrance) --- Schild Ortseingang
	
	create_npc("Robert", 64, 64 * TILESIZE, 117 * TILESIZE + 16, robert_talk, nil) --- Paul 
end)

function robert_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Ich bin Steuerberater.",
	                                                 "Paragraph 16, königliches Steuergesetz: Milch wird mit 4% des normalen Steuersatzes versteuert.",
													 "Das schlimme an Steuergesetzen ist, das sie keinen Sinn machen...",
													 "Ich glaube meine Beratung wird mit 7% versteuert."))
	do_npc_close(npc, ch)
end
