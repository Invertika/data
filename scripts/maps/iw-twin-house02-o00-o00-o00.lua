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
require "scripts/libs/barber"
require "scripts/libs/invertika"

atinit(function()
    ---create_npc("Banker", 122, 180 * TILESIZE + 16, 160 * TILESIZE + 16, banker.banker_talk, nil) --- Banker (Debug)
    create_npc("Rocer", 60, 42 * TILESIZE + 16, 31 * TILESIZE + 16, rocer_talk, nil) -- Rocer (2. Zwilling)
end)


function rocer_talk(npc, ch)
    local questname = "twin_house_quest"
    invertika.init_quest_status(questname)
    function get_qstatus() return invertika.get_quest_status(ch, questname) end
    function set_qstatus(x) invertika.set_quest_status(ch, questname, x) end

    if get_qstatus() == 0 then
        do_message(npc, ch, "Ein Reisender. Sei froh, dass du dieses Haus betreten hast und nicht das meines Zwillingsbruders.")
    elseif get_qstatus() == 1 then -- Quest beim ersten Zwilling angenommen.
        do_message(npc, ch, "Die Wände sind dünn hier! Ich habe gehört was du mit meinem Zwillingsbruder besprochen hast!")
        do_message(npc, ch, "Verlasse dieses Haus! Ich will dich hier nicht mehr sehen!")
    elseif get_qstatus() == 2 then -- Quest beim ersten Zwilling ausgeführt.
        do_message(npc, ch, "Die Wände sind dünn hier! Ich habe gehört was du mit meinem Zwillingsbruder besprochen hast!")
        do_message(npc, ch, "Verlasse dieses Haus! Ich will dich hier nicht mehr sehen!")
    elseif get_qstatus() == 3 then -- Quest beim zweiten Zwilling angenommen.

    elseif get_qstatus() == 4 then -- Quest beim zeiten Zwilling ausgeführt.

    elseif get_qstatus() == 5 then -- Allgemein
        do_message(npc, ch, invertika.get_random_element("Mein Bruder hat mich betrogen!",
          "Wir hassen uns seit wir auf der Welt sind!",
          "Ich bin als erstes geboren!"))
    end
    do_npc_close(npc, ch)
end
