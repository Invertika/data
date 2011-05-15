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
require "scripts/libs/sign"

dofile("data/scripts/libs/warp.lua")

atinit(function()
    create_inter_map_warp_trigger(19001, 110, 98, 88) --- Intermap warp

    sign_entrance = "Alexia"
    sign.create_sign(10, 74, sign_entrance) --- Schild Ortseingang
    sign.create_sign(84, 132, sign_entrance) --- Schild Ortseingang

    create_npc("Regret", 8, 55 * TILESIZE + 16, 173 * TILESIZE + 16, regret_talk, nil) --- Regret 
    create_npc("Holbert", 63, 129 * TILESIZE + 16, 120 * TILESIZE + 16, holbert_talk, nil) --- Holbert
    create_npc("Vektor", 11, 134 * TILESIZE + 16, 120 * TILESIZE + 16, vektor_talk, nil) --- Vektor
end)

function regret_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Verdammt, was mache ich hier? Ich bin im falschen Spiel!",
      "Ich muss doch nach Leo. Wo bin ich? In Alexia? Gibt es auf unserem Kontinent nicht.",
      "Ich muss jetzt echt los sonst komme ich zu spät zu der Fortsetzung meiner Spielereihe.",
      "Wenn ich den kriege der mir das hier eingebrockt hat."))
    do_npc_close(npc, ch)
end

function holbert_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Immer diese Entwickler... berücksichtigen die elementaren Grundlagen der Physik nicht. Und was haben wir nun davon? Dieses Haus.",
      "Von wegen optische Täuschung, das haben die wirklich so gebaut!",
      "Nichts ist unmöglich... Invertika *mir Werbemusik dazu denke*",
      "Möchte mal wissen wer die Baugenehmigung dafür ausgestellt hat."))
    do_npc_close(npc, ch)
end

function vektor_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Ich war früher mal ein Superschurke.",
      "Ich bin Statiker, aber damit habe ich nichts, aber auch wirklich garnichts zu tun.",
      "Eigentlich müsste dieses Haus in sich zusammenfallen. Oder das Universum. Blöderweise passiert nichts von beidem.",
      "Wir könnten auch einfach so tun, als ob da gar kein Haus steht."))
    do_npc_close(npc, ch)
end