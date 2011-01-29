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
    create_npc("Blyther", 60, 36 * TILESIZE + 16, 30 * TILESIZE + 16, blyther_talk, nil) --- Blyther (1. Zwilling)
end)


function blyther_talk(npc, ch)
    local questname = "twin_house_quest"
    invertika.init_quest_status(questname)
    function get_qstatus() return invertika.get_quest_status(questname) end
    function set_qstatus(x) invertika.set_quest_status(questname, x) end

    if get_qstatus() == 0 then
        do_message(npc, ch, "Hallo Reisender aus der Wüste.")
        do_message(npc, ch, "Es ist selten das ich Besuch bekomme.")
        do_message(npc, ch, "Willst du für mich eine Aufgabe erldigen?")
        do_message(npc, ch, "Dieses Schwert gehört Tetse. Er benutze es in einer großen Schlacht. Dann verlor er es.")
        do_message(npc, ch, "Ich habe es gefunden und für ihn aufbewahrt. Würdest du es zu ihm bringen?")
        while true do
            local v = do_choice(npc, ch, "Mach ich!", "Nein.")
            if v == 1 then
                invertika.add_items(ch, 10008, 1, "Tetses Schwert")
                set_qstatus(2)
                do_message(npc, ch, "Vielen Dank. Ich weiß allerdings nicht wo er wohnt. Das müsstest du selbst herausfinden.")
                break
            elseif v == 2 then
                do_message(npc, ch, "Schade. Dann muss ich wohl selbst herausfinden wo er wohnt.")
                break
            end
        end
    elseif get_qstatus() == 1 then -- Quest beim ersten Zwilling angenommen.
        if mana.chr_inv_count(ch, 10008) >= 0 then
            do_message(npc, ch, invertika.get_random_element("Ich weiß nicht wo Tese wohnt. Tut mir Leid.",
              "Wolltest du nicht zu Tetse ihm das Schwert bringen?"))
        else
            do_message(npc, ch, "Wo ist das Schwert? Tetse wird nicht erfreut sein, dass du es verloren hast.")
        end
    elseif get_qstatus() == 2 then -- Quest beim ersten Zwilling ausgeführt.
        do_message(npc, ch, "Ah. Der Reisende aus dem Sandsturm. Tetse wird sich sehr über das Schwert gefreut haben.")
        do_message(npc, ch, "Nimm als Dank diese paar Energetia Pillen. Sie werden dir helfen wenn du erschöpft bist.")
        invertika.add_items(ch, 30018, 20, "Energetia Pillen")
        set_qstatus(5)
    elseif get_qstatus() == 3 then -- Quest beim zweiten Zwilling angenommen.
        do_message(npc, ch, "Die Wände sind dünn hier! Ich habe gehört was du mit meinem Zwillingsbruder besprochen hast!")
        do_message(npc, ch, "Verlasse dieses Haus! Ich will dich hier nicht mehr sehen!")
    elseif get_qstatus() == 4 then -- Quest beim zeiten Zwilling ausgeführt.
        do_message(npc, ch, "Die Wände sind dünn hier! Ich habe gehört was du mit meinem Zwillingsbruder besprochen hast!")
        do_message(npc, ch, "Verlasse dieses Haus! Ich will dich hier nicht mehr sehen!")
    elseif get_qstatus() == 5 then -- Allgemein
        do_message(npc, ch, invertika.get_random_element("Ich würde nicht das Nachbarhaus besuchen. Dort wohnt mein Zwillingsbruder.",
          "Mein Bruder und ich hassen uns.",
          "Wir reden schon ewig nicht mehr miteinader."))
    end
    do_npc_close(npc, ch)
end
