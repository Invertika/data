----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2011 The Invertika Development Team                        --
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



local function blyther_talk(npc, ch)
    local questname = "twin_house_quest"
    invertika.init_quest_status(ch, questname)
    local function get_qstatus() return invertika.get_quest_status(ch, questname) end
    local function set_qstatus(x) invertika.set_quest_status(ch, questname, x) end

    if get_qstatus() == 0 then
        npc_message(npc, ch, "Hallo Reisender aus der Wüste.")
        npc_message(npc, ch, "Es ist selten das ich Besuch bekomme.")
        npc_message(npc, ch, "Willst du für mich eine Aufgabe erledigen?")
        npc_message(npc, ch, "Dieses Schwert gehört Tetse. Er benutzte es in einer großen Schlacht. Dann verlor er es.")
        npc_message(npc, ch, "Ich habe es gefunden und für ihn aufbewahrt. Würdest du es zu ihm bringen?")
        while true do
            local v = npc_choice(npc, ch, "Mach ich!", "Nein.")
            if v == 1 then
                invertika.add_items(ch, 10008, 1, "Tetses Schwert")
                set_qstatus(1)
                npc_message(npc, ch, "Vielen Dank. Ich weiß allerdings nicht wo er wohnt. Das müsstest du selbst herausfinden.")
                break
            elseif v == 2 then
                npc_message(npc, ch, "Schade. Dann muss ich wohl selbst herausfinden wo er wohnt.")
                break
            end
        end
    elseif get_qstatus() == 1 then -- Quest beim ersten Zwilling angenommen.
        if chr_inv_count(ch, 10008) >= 0 then
            npc_message(npc, ch, invertika.get_random_element("Ich weiß nicht wo Tese wohnt. Tut mir Leid.",
              "Wolltest du nicht zu Tetse ihm das Schwert bringen?"))
        else
            npc_message(npc, ch, "Wo ist das Schwert? Tetse wird nicht erfreut sein, dass du es verloren hast.")
        end
    elseif get_qstatus() == 2 then -- Quest beim ersten Zwilling ausgeführt.
        npc_message(npc, ch, "Ah. Der Reisende aus dem Sandsturm. Tetse wird sich sehr über das Schwert gefreut haben.")
        npc_message(npc, ch, "Nimm als Dank diese paar Energetia Pillen. Sie werden dir helfen wenn du erschöpft bist.")
        invertika.add_items(ch, 30018, 20, "Energetia Pillen")
        set_qstatus(5)
    elseif get_qstatus() == 3 then -- Quest beim zweiten Zwilling angenommen.
        npc_message(npc, ch, "Die Wände sind dünn hier! Ich habe gehört was du mit meinem Zwillingsbruder besprochen hast!")
        npc_message(npc, ch, "Verlasse dieses Haus! Ich will dich hier nicht mehr sehen!")
    elseif get_qstatus() == 4 then -- Quest beim zeiten Zwilling ausgeführt.
        npc_message(npc, ch, "Die Wände sind dünn hier! Ich habe gehört was du mit meinem Zwillingsbruder besprochen hast!")
        npc_message(npc, ch, "Verlasse dieses Haus! Ich will dich hier nicht mehr sehen!")
    elseif get_qstatus() == 5 then -- Allgemein
        npc_message(npc, ch, invertika.get_random_element("Ich würde nicht das Nachbarhaus besuchen. Dort wohnt mein Zwillingsbruder.",
          "Mein Bruder und ich hassen uns.",
          "Wir reden schon ewig nicht mehr miteinader."))
    end
end

atinit(function()
    npc_create("Blyther", 60, GENDER_UNSPECIFIED, 15 * TILESIZE + 16, 13 * TILESIZE + 16, blyther_talk, nil) --- Blyther (1. Zwilling)
end)
