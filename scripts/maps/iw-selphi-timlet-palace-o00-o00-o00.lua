﻿----------------------------------------------------------------------------------
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


local function luor_talk(npc, ch)
    invertika.init_quest_status(ch, "selphi_timlet_vipcard")

    local function get_qstatus() return invertika.get_quest_status(ch, "selphi_timlet_vipcard") end
    local function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_vipcard", x) end

    if get_qstatus() == 3 then
        if chr_inv_count(ch, 40027) == 1 then
            npc_message(npc, ch, "Ein Brief? Gib her!")
            invertika.add_items(ch, 40027, -1, "Brief an den König")
            npc_message(npc, ch, "*Grübel* Das sind schlechte Neuigkeiten...")
            npc_message(npc, ch, "Danke, dass du mir den Brief gebracht hast. Nimm diesen VIP Ausweis für die Arena als Dank!")
            invertika.add_items(ch, 40026, 1, "VIP-Ausweis")
            set_qstatus(4)
        else
            npc_message(npc, ch, invertika.get_random_element("Ob der Brief wohl bald kommt?",
              "Hoffentlich ist alles gut gegangen.",
              "Er lässt sich aber auch wieder Zeit!",
              "Es tut mir leid, im Moment habe ich keine Zeit!",
              "Du siehst aus als ob du einen Brief hättest? Nicht? Na gut, dann nicht."))
        end
    elseif get_qstatus() >= 4 then
        npc_message(npc, ch, "Danke für den Brief, aber jetzt muss ich arbeiten!")
    else
        npc_message(npc, ch, "Sei gegrüßt, ich bin Luor, Herscher über Selphi Timlet, Bewahrer des Heiligen Kelches von Rixx. Wie lautet deine Bitte? - Obwohl lieber nicht, im Moment steht es mir nicht nach einer Audienz.")
    end
end

local function krenel_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Wir müssen Aktivität vortäuschen...",
      "Aktivität simulieren... Also steh hier nicht rum. Los, hop hop!",
      "Ich täusche Aktivität vor, also schau nicht so und mache das gleiche.",
      "Wenn wir das nicht tun ist alles zu spät.",
      "Das ganze Invertika Team macht das so... aber psssst..."))
end

atinit(function()
    npc_create("Luor", 20, GENDER_UNSPECIFIED, 34 * TILESIZE + 16, 24 * TILESIZE + 16, luor_talk, nil) --- Luor
    npc_create("Krenel", 54, GENDER_UNSPECIFIED, 41 * TILESIZE + 16, 56 * TILESIZE + 16, krenel_talk, nil) --- Krenel
end)
