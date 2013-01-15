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



local function goron_talk(npc, ch)
    -- 0 = keine Bestellungen.
    -- 1 = grüne Robe.
    -- 2 = gelbe Robe.
    -- 3 = rote Robe.
    -- 4 = blaue Robe.
    local queststring_orders = "selphi_timlet_goron_orders"
    local queststring_timestamp_order_ready = "selphi_timlet_goron_order_ready"

    invertika.init_quest_status(ch, queststring_orders)
    invertika.init_quest_status(ch, queststring_timestamp_order_ready)

    local get_order = function()
      return invertika.get_quest_status(ch, queststring_orders)
    end
    local set_order = function(x)
      invertika.set_quest_status(ch, queststring_orders, x)
    end

    local get_order_timestamp = function()
      return invertika.get_quest_status(ch, queststring_timestamp_order_ready)
    end
    local set_order_timestamp = function(x)
      return invertika.set_quest_status(ch, queststring_timestamp_order_ready, x)
    end

    if get_order() == 0 then
        local count_green_twine = chr_inv_count(ch, 40030)
        local count_yellow_twine = chr_inv_count(ch, 40031)
        local count_red_twine = chr_inv_count(ch, 40032)
        local count_blue_twine = chr_inv_count(ch, 40033)
        if count_green_twine > 0 or count_yellow_twine > 0 or count_red_twine > 0 or count_blue_twine > 0 then
            npc_message(npc, ch, "Willkommen. Willkommen. Treten Sie ein. Was kann ich für Sie tun?")
            while true do
                local v = npc_choice(npc, ch, "Ich hätte gerne eine Robe.", "Nein. Danke.")
                if v == 1 then
                    npc_message(npc, ch, "Hmm. Eine Robe. Welche Farbe wird denn gewünscht?")
                    while true do
                        local v1 = npc_choice(npc, ch, "Grün.", "Gelb.", "Rot.", "Blau.")
                        if v1 >= 1 and v1 <= 4 then -- Grün
                            if (v1 == 1 and count_green_twine > 0) or
                            (v1 == 2 and count_yellow_twine > 0) or
                            (v1 == 3 and count_red_twine > 0) or
                            (v1 == 4 and count_blue_twine > 0) then
                                npc_message(npc, ch, "Das macht dann 1200 Aki.")
                                while true do
                                    local v2 = npc_choice(npc, ch, "Bezahlen.", "Nein. Dann doch nicht.")
                                    if v2 == 1 then
                                        if chr_money(ch) >= 1200 then
                                            invertika.add_money(ch, -1200)
                                            if v1 == 1 then
                                                invertika.add_items(ch, 40030, -1, "grüner Garn")
                                            elseif v1 == 2 then
                                                invertika.add_items(ch, 40031, -1, "gelber Garn")
                                            elseif v1 == 3 then
                                                invertika.add_items(ch, 40032, -1, "roter Garn")
                                            elseif v1 == 4 then
                                                invertika.add_items(ch, 40033, -1, "blauer Garn")
                                            end
                                            set_order(v1)
                                            set_order_timestamp(math.random(os.time(t) + 2 * 60 * 60, os.time(t) + 3 * 60 * 60))
                                            npc_message(npc, ch, "Die Bestellung wurde aufgegeben. Sie können sie in 2 - 3 Stunden abholen.")
                                        else
                                            npc_message(npc, ch, "Tut mir Leid. Du hast leider nicht genug Geld dabei.")
                                        end
                                        break
                                    elseif v2 == 2 then
                                        break
                                    end
                                end
                            else
                                npc_message(npc, ch, "Tut mir Leid. Du hast nicht die passenden Farben dabei.")
                            end
                            break
                        end
                    end
                    break
                elseif v == 2 then
                    npc_message(npc, ch, "Beehren Sie mich bald wieder!")
                    break
                end
            end
        else
            npc_message(npc, ch, invertika.get_random_element("Ich bin der Schneider hier.",
              "Bringe mir etwas Garn und ich werde dir für eine Kleinigkeit wunderschöne Gewänder schneidern.",
                "Falls du Garn brauchst, frag Lidi. Die spinnt ihn selbst."))
        end
    elseif get_order() >= 1 and get_order() <= 4 then
        local current_time = os.time(t)
        local order_time = get_order_timestamp()
        if order_time - current_time < 0 then
            -- Bestellung fertig.
            npc_message(npc, ch, "Ihre Bestellung ist fertig. Es wird Ihnen ausgezeichnet stehen.")
            if get_order() == 1 then
                invertika.add_items(ch, 20024, 1, "modische grüne Robe")
            elseif get_order() == 2 then
                invertika.add_items(ch, 20025, 1, "modische gelbe Robe")
            elseif get_order() == 3 then
                invertika.add_items(ch, 20026, 1, "modische rote Robe")
            elseif get_order() == 4 then
                invertika.add_items(ch, 20027, 1, "modische blaue Robe")
            end
            set_order(0) -- Bestellung löschen.
        else
            -- Bestellungn noch nicht fertig
            npc_message(npc, ch, "Tut mir Leid. Ihre Bestellung ist noch nicht fertig. Kommen Sie später noch einmal vorbei.")
        end
    end
end

atinit(function()
 ---npc_create("Banker", 11, GENDER_UNSPECIFIED, 180 * TILESIZE + 16, 160 * TILESIZE + 16, banker.banker_talk, nil) --- Banker (Debug)
 npc_create("Goron", 11, GENDER_UNSPECIFIED, 77 * TILESIZE + 16, 24 * TILESIZE + 16, goron_talk, nil) -- Goron (Schneider)
end)
