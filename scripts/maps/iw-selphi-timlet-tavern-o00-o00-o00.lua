----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                          --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/banker"
require "scripts/libs/slotmachine"
require "scripts/libs/invertika"


local function brecht_talk(npc, ch)
    npc_message(npc, ch, "Ich sehe schon du bist durstig. Was möchtest du?")
    npc_trade(npc, ch, false, { {30006, 999, 25}, {30007, 999, 60}, {30008, 999, 450} })
    npc_message(npc, ch, "Lass es dir schmecken.")
end

local function chodar_talk(npc, ch)
    invertika.init_quest_status(ch, "selphi_timlet_vipcard")

    local function get_qstatus() return invertika.get_quest_status(ch, "selphi_timlet_vipcard") end
    local function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_vipcard", x) end

    if get_qstatus() == 0 then
        npc_message(npc, ch, "Hey! Du! Steht nicht so dumm rum! Bring mir mein Bier!")
        set_qstatus(1)
    elseif get_qstatus() == 1 then
        count = chr_inv_count(ch, 30006)
        if count >= 1 then
            npc_message(npc, ch, "Endlich! Da ist ja das Bier! Stell es da hin!")
            while true do
                v = npc_choice(npc, ch, "Das Bier auf den Tisch stellen.", "Das Bier behalten.")
                if v == 1 then
                    invertika.add_items(ch, 30006, -1, "Bier")
                    npc_message(npc, ch, "Ah. Endlich! Hier hast du deine 25 Aki.")
                    invertika.add_money(ch, 25)
                    set_qstatus(2)
                    npc_message(npc, ch, "Kannst du mir nen zuverlässigen Burschen empfehlen, der Zugang zum Palast hat? Dieser komische Kauz Nepuret wollte mir nicht diesen Brief geben...")
                    while true do
                        v2 = npc_choice(npc, ch, "Hm. Ich kenne keinen.", "Ich habe Zugang zum Palast!")
                        if v2 == 1 then
                            npc_message(npc, ch, "Ahw. Komm wieder wenn du einen kennst!")
                            break
                        elseif v2 == 2 then
                            npc_message(npc, ch, "Du? Was solls. Hier ist ein Brief. Gib ihn dem König. Und Wehe dir! Ich weiß ob du ihn abgeliefert hast!")
                            invertika.add_items(ch, 40027, 1, "Brief an den König")
                            set_qstatus(3)
                            break
                        end
                    end

                    break
                elseif v == 2 then
                    npc_message(npc, ch, "Scher dich zum Teufel und schick mir die Bedienung!")
                    break
                end
            end
        else
            npc_message(npc, ch, "Jetzt stehst du schon wieder da! Ich will mich nicht unterhalten! Ich will mein Bier!")
        end
    elseif get_qstatus() == 2 then
        npc_message(npc, ch, "Kannst du mir inzwischen einen zuverlässigen Burschen empfehlen, der Zugang zum Palast hat? Dieser komische Kauz Nepuret wollte mir nicht diesen Brief geben...")
        while true do
            v = npc_choice(npc, ch, "Hm. Nein. Immer noch nicht.", "Ich habe Zugang zum Palast!")
            if v == 1 then
                npc_message(npc, ch, "Ah okay. Komm wieder wenn du einen kennst!")
                break
            elseif v == 2 then
                npc_message(npc, ch, "Du? Naja, egal. Hier ist ein Brief. Gib ihn dem König. Und wehe dir! Ich weiß ob du ihn abgeliefert hast!")
                invertika.add_items(ch, 40027, 1, "Brief an den König")
                set_qstatus(3)
                break
            end
        end
    elseif get_qstatus() == 3 then
        npc_message(npc, ch, "Los. Lauf zum König. Worauf wartest du?")
    elseif get_qstatus() == 4 then
        npc_message(npc, ch, "Du warst da? Ja natürlich war er erschüttert!")
        npc_message(npc, ch, "Komm ich schmeiß ne Runde! PROST!")
        invertika.add_items(ch, 30006, 1, "Bier")
        set_qstatus(5)
    elseif get_qstatus() == 5 then
        npc_message(npc, ch, invertika.get_random_element("Auf den König!",
                                                         "PROST!",
                                                         "Auf bessere Zeiten!"))
    end
end

atinit(function()
 npc_create("Brecht", 21, GENDER_UNSPECIFIED, 20 * TILESIZE + 16, 15 * TILESIZE + 16, brecht_talk, nil) --- Brecht
 npc_create("Chodar", 40, GENDER_UNSPECIFIED, 38 * TILESIZE + 16, 18 * TILESIZE + 16, chodar_talk, nil) --- Chodar
end)
