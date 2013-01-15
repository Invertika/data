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

require "scripts/libs/warp"


local function regret_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Verdammt, was mache ich hier? Ich bin im falschen Spiel!",
      "Ich muss doch nach Leo. Wo bin ich? In Alexia? Gibt es auf unserem Kontinent nicht.",
      "Ich muss jetzt echt los sonst komme ich zu spät zu der Fortsetzung meiner Spielereihe.",
      "Wenn ich den kriege der mir das hier eingebrockt hat."))
end

local function holbert_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Immer diese Entwickler... berücksichtigen die elementaren Grundlagen der Physik nicht. Und was haben wir nun davon? Dieses Haus.",
      "Von wegen optische Täuschung, das haben die wirklich so gebaut!",
      "Nichts ist unmöglich... Invertika *mir Werbemusik dazu denke*",
      "Möchte mal wissen wer die Baugenehmigung dafür ausgestellt hat."))
end

local function vektor_talk(npc, ch)
    if invertika.get_quest_status(ch, "selphi_timlet_felix_quest") == 1 then
        npc_message(npc, ch, "Ein Felix aus Selphi Timlet fragt ob ich für ihn Statiken berechnen kann?")
        npc_message(npc, ch, "Den kenne ich nicht...")
        npc_message(npc, ch, "Aber Selphi Timlet hat keine vernünftigen Statiker!")
        npc_message(npc, ch, "Schau dir mal den Palast an! Ein FLACHDACH!")
        npc_message(npc, ch, "Statik ist kompliziert. Da kann man nicht einfach irgendeinen dranlassen!")
        npc_message(npc, ch, "Wer schonmal Kartenhäuser gebaut hat weiß dies. Wenn man sich in der dritten Etage auch nur leicht bei einer einzigen Karte verrechnet! Es könnte gravierende Schwierigkeiten bedeuten die 63. Etage zu bauen!")
        npc_message(npc, ch, "Ich rege mich schon wieder zu sehr auf")
        npc_message(npc, ch, "*Beruhigungstabletten schluck*")
        while true do
            local v = npc_choice(npc, ch, "Wirst du Felix nun helfen?", "Tschüß!")
            if v == 1 then
                npc_message(npc, ch, "Ja. Natürlich! Ich mache mich gleich auf den Weg.")
                invertika.set_quest_status(ch, "selphi_timlet_felix_quest", 2)
                break
            elseif v == 2 then
                npc_message(npc, ch, "Was? Du gehst schon?")
                invertika.set_quest_status(ch, "selphi_timlet_felix_quest", -1)
                break
            end
        end
    else
        npc_message(npc, ch, invertika.get_random_element("Ich war früher mal ein Superschurke.",
            "Ich bin Statiker, aber damit habe ich nichts, aber auch wirklich garnichts zu tun.",
            "Eigentlich müsste dieses Haus in sich zusammenfallen. Oder das Universum. Blöderweise passiert nichts von beidem.",
            "Wir könnten auch einfach so tun, als ob da gar kein Haus steht."))
    end
end

atinit(function()
    create_inter_map_warp_trigger(nil, 110, 98, 88) --- Intermap warp

    sign_entrance = "Alexia"
    sign.create_sign(84, 132, sign_entrance) --- Schild Ortseingang

    npc_create("Regret", 8, GENDER_UNSPECIFIED, 55 * TILESIZE + 16, 173 * TILESIZE + 16, regret_talk, nil) --- Regret 
    npc_create("Holbert", 63, GENDER_UNSPECIFIED, 129 * TILESIZE + 16, 120 * TILESIZE + 16, holbert_talk, nil) --- Holbert
    npc_create("Vektor", 11, GENDER_UNSPECIFIED, 134 * TILESIZE + 16, 120 * TILESIZE + 16, vektor_talk, nil) --- Vektor
end)
