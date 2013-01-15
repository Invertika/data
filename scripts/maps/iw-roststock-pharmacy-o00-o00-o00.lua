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
require "scripts/libs/invertika"


local function nijeta_talk(npc, ch)
    -- quest init
    invertika.init_quest_status(ch, "roststock_pharmacy_quest")
    -- quest get/set functions
    local function get_qstatus() return tonumber(invertika.get_quest_status(ch, "roststock_pharmacy_quest")) end
    local function set_qstatus(x) invertika.set_quest_status(ch, "roststock_pharmacy_quest", tonumber(x)) end

    if get_qstatus() == 1 then
        if chr_inv_count(ch, 30025) >= 4 then
            npc_message(npc, ch, "Hey, super, du hast die Schlangeneier gekriegt!")
            invertika.add_items(ch, 30025, -4, "Schlangenei")
            set_qstatus(2)
            npc_message(npc, ch, "Als nächstes brauche ich 10 Kokosnüsse")
            npc_message(npc, ch, "Kann ich noch etwas für dich tun?")
        else
            npc_message(npc, ch, "Ich brauche zuerst 4 Schlangeneier.")
            npc_message(npc, ch, "Kann ich noch etwas für dich tun?")
        end
    elseif get_qstatus() == 2 then
        if chr_inv_count(ch, 30026) >= 10 then        
            npc_message(npc, ch, "Danke für die Kokosnüsse!")
            invertika.add_items(ch, 30026, -10, "Kokosnuss")
            set_qstatus(3)
            npc_message(npc, ch, "Zu guter letzt brauche ich noch das gewisse Etwas, was meinen Arzneimitteln ihre gute Wirksamkeit verleiht.")
            npc_message(npc, ch, "Bring mir 2 Phiolen Nogatch Hemlock. In sehr geringen Dosen eingesetzt wirkt es nicht schädlich sondern äußerst heilkräftig!")
            npc_message(npc, ch, "Kann ich noch etwas für dich tun?")
        else
            npc_message(npc, ch, "Vergiss nicht, ich wollte noch 10 Kokosnüsse von dir.")
            npc_message(npc, ch, "Kann ich noch etwas für dich tun?")
        end
    elseif get_qstatus() == 3 then
        if chr_inv_count(ch, 30003) >= 2 then
            npc_message(npc, ch, "Perfekt! Danke für das Nogatch Hemlock.")
            invertika.add_items(ch, 30003, -2, "Nogatch Hemlock")
            set_qstatus(4)
            npc_message(npc, ch, "Als Belohnung für deine Mühen bekommst du einen kleinen Vorrat an Arzneimitteln von mir. Du bekommst sogar ein paar der experimentellen und neueren Exemplare!")
            invertika.add_items(ch, 30018, 20, "Energetia")
            invertika.add_items(ch, 30019, 10, "Energetia Medium")
            invertika.add_items(ch, 30020, 5, "Energetia Maxima")
            invertika.add_items(ch, 30017, 2, "Inspirin Megaplus")
            npc_message(npc, ch, "Kann ich sonst noch etwas für dich tun?")
        else
            npc_message(npc, ch, "Denk dran, 2 Phiolen Nogatch Hemlock! Nicht mehr und nicht weniger.")
            npc_message(npc, ch, "Kann ich noch etwas für dich tun?")
        end
    else
        npc_message(npc, ch, "Hallo, was kann ich für dich tun?")
    end
    
    while true do
        local v = npc_choice(npc, ch,
          "Kaufen.",
          "Verkaufen.",
          "Ich suche Arbeit.",
          "Nichts. Danke.")
        if v == 1 then
            npc_trade(npc, ch, false,
              {{30002, 50, 70},
              {30015, 50, 150},
              {30016, 50, 450},
              {30018, 50, 150},
              {30019, 50, 500}})
            break
        elseif v == 2 then
            npc_trade(npc, ch, true,
              {{30002, 50, 50},
              {30015, 50, 50},
              {30016, 50, 250},
              {30018, 50, 50},
              {30019, 50, 300}})
            break
        elseif v == 3 then
            if get_qstatus()==0 then
                npc_message(npc, ch, "Du könntest mir ein paar mehr oder weniger seltene Sachen besorgen, die ich für meine Medikamente brauche.")
                npc_message(npc, ch, "Lust?")
                while true do
                    local v2 = npc_choice(npc, ch, 
                      "OK. Was soll ich denn besorgen?",
                      "Nein danke, besser nicht.")
                    if v2 == 1 then
                        npc_message(npc, ch, "Super! Als erstes benötige ich 4 Schlangeneier.")
                        set_qstatus(1)
                        break
                    elseif v2 == 2 then
                        npc_message(npc, ch, "Schade, dann muss ich wohl jemand anderen finden.")
                        break
                    end
                end
            else
                npc_message(npc, ch, "Leider habe ich nichts mehr für dich zu tun...")
            end
            break
        elseif v == 4 then
            npc_message(npc, ch, "Und immer an die Risiken und Nebenwirkungen denken!")
            break
        end
    end
end

atinit(function()
    npc_create("Nijeta", 58, GENDER_UNSPECIFIED, 50 * TILESIZE + 16, 33 * TILESIZE + 16, nijeta_talk, nil) --Nijeta
end)
