----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------


require "scripts/lua/npclib"
require "scripts/libs/invertika"

local tano = {}
local waypointstate = {}

atinit(function()
    --- NPCs
    tano[1] = npc_create("Irdath", 89, GENDER_UNSPECIFIED, 35 * TILESIZE + 16, 44 * TILESIZE + 16, tano1_talk, npclib.walkaround_small) --- Ta No 1 (Ta No am Eingang)
    tano[2] = npc_create("Rhaor", 91, GENDER_UNSPECIFIED, 42 * TILESIZE + 16, 36 * TILESIZE + 16, tano2_talk, nil) --- Ta No 2 (Schatzkammer Wächter)
    tano[3] = npc_create("Karl", 92, GENDER_UNSPECIFIED, 25 * TILESIZE + 16, 41 * TILESIZE + 16, tano3_talk, nil) --- Ta No 3 (Verkäufer)
    tano[4] = npc_create("Samos", 93, GENDER_UNSPECIFIED, 67 * TILESIZE + 16, 14 * TILESIZE + 16, tano4_talk, nil) --- Ta No 4 (Sektenführer)
    tano[5] = npc_create("Ceria", 94, GENDER_UNSPECIFIED, 20 * TILESIZE + 16, 20 * TILESIZE + 16, tano5_talk, nil) --- Ta No 5 (Köchin)
    tano[6] = npc_create("Enlelm", 95, GENDER_UNSPECIFIED, 19 * TILESIZE + 16, 19 * TILESIZE + 16, tano6_talk, nil) --- Ta No 6 (Küchenhilfe)
    tano[7] = npc_create("Byler", 96, GENDER_UNSPECIFIED, 17 * TILESIZE + 16, 24 * TILESIZE + 16, tano7_talk, nil) --- Ta No 7 (Normal m)
    tano[8] = npc_create("Lyril", 97, GENDER_UNSPECIFIED, 21 * TILESIZE + 16, 24 * TILESIZE + 16, tano8_talk, nil) --- Ta No 8 (Normal f)
    tano[9] = npc_create("Iawar", 98, GENDER_UNSPECIFIED, 26 * TILESIZE + 16, 24 * TILESIZE + 16, tano9_talk, nil) --- Ta No 9 (Normal m)
    tano[10] = npc_create("Isskel", 99, GENDER_UNSPECIFIED, 18 * TILESIZE + 16, 29 * TILESIZE + 16, tano10_talk, nil) --- Ta No 10 (Normal m)
    tano[11] = npc_create("Kahlan", 100, GENDER_UNSPECIFIED, 22 * TILESIZE + 16, 29 * TILESIZE + 16, tano11_talk, nil) --- Ta No 11 (Normal f)
	
    --- Blickrichtungen
    --- schedule_in(1, function()
    ---     being_set_direction(tano[7], DIRECTION_RIGHT)
    ---     being_set_direction(tano[8], DIRECTION_LEFT)
    ---     being_set_direction(tano[9], DIRECTION_DOWN)
    ---     being_set_direction(tano[10], DIRECTION_RIGHT)
    ---     being_set_direction(tano[11], DIRECTION_LEFT)
    --- end)
	
    --- Waypoints
    --- Ta No 5 (Köchin)
    --- trigger_create(20 * TILESIZE + 16, 20 * TILESIZE + 16, 1, 1, waypoints, 1, true) --- Wegpunkt 1 (Küchenanrichte, ganz links)
    --- trigger_create(23 * TILESIZE + 16, 20 * TILESIZE + 16, 1, 1, waypoints, 2, true) --- Wegpunkt 2 (Küchenanrichte, zweite von rechts)
    --- trigger_create(24 * TILESIZE + 16, 20 * TILESIZE + 16, 1, 1, waypoints, 3, true) --- Wegpunkt 3 (Küchenanrichte, ganz rechts)
    --- waypointstate[tano[5]] = 1

    --- Ta No 6 (Küchenhilfe)
    --- trigger_create(19 * TILESIZE + 16, 19 * TILESIZE + 16, 1, 1, waypoints, 1, true) --- Wegpunkt 1 (Küchenanrichte, links vor dem Ofen)
    --- trigger_create(9 * TILESIZE + 16, 14 * TILESIZE + 16, 1, 1, waypoints, 2, true) --- Wegpunkt 2 (Vorratskammer, oben vor dem Regal)
    --- trigger_create(9 * TILESIZE + 16, 19 * TILESIZE + 16, 1, 1, waypoints, 3, true) --- Wegpunkt 3 (Vorratskammer, unten vor einer Kiste)
    --- trigger_create(7 * TILESIZE + 16, 16 * TILESIZE + 16, 1, 1, waypoints, 4, true) --- Wegpunkt 4 (Vorratskammer, links vor einem Sack)
    --- waypointstate[tano[6]] = 1
	
    --- Schutz der Schatzkammer
    -- trigger_create(42 * TILESIZE, 36 * TILESIZE, 2 * TILESIZE, 2 * TILESIZE, treasure_trap, 0, true)
    -- trigger_create(39 * TILESIZE, 36 * TILESIZE, 3 * TILESIZE, 3 * TILESIZE, treasure_warning, 0, true)
end)

local function tano1_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Geh doch mal zu Samos, der hat bestimmt einen Auftrag für dich.",
      "Im Laden kannst du erst etwas kaufen, wenn du dir Reputation bei uns erworben hast.",
      "Was das hier ist? Natürlich das Hauptquartier der Ta No!",
      "Unsere Ziele? Die sind geheim!"))
end

local function tano2_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Ich passe auf, dass niemand so ohne weiteres in die Schatzkammer geht.",
      "Versuche gar nich erst, etwas zu stehlen!",
      "Über der Schatzkammer hängt ein Schutzzauber.",
      "NEIN, du darfst NICHT in die Schatzkammer."))
end

local function tano3_talk(npc, ch)
    npc_message(npc, ch, "Ich werde irgendwann mal Waffen und Ausrüstung verkaufen und so.")
end

local function tano4_talk(npc, ch)
    npc_message(npc, ch, "Ich soll irgendwann mal Quests vergeben, mit denen die Reputation bei den Ta No gesteigert werden kann.")
end

local function tano5_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Ich koche hier für die anderen Sektenmitglieder.",
      "Pah, die sollen sich bloß nicht schon wieder über das Essen beschweren! Verwöhntes Pack...",
      "Hmm, noch ein bisschen hiervon, und ein wenig hiervon, und probieren ... Arghh, schon wieder zu viel Salz!",
      "Aus der blöden Spüle kommt schon wieder nur rostiges Wasser!"))
end

local function tano6_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Ich hasse Küchendienst... Aber naja, immer noch besser als Abort saubermachen.",
      "Die Spülmaschine ist schon wieder kaputt und jetzt muss ich alles von Hand waschen...",
      "Eigentlich hatte ich mir das Leben als Ta No irgendwie spannender vorgestellt, und jetzt stehe ich den ganzen Tag bloss hier in der Küche.",
      "\"Enlelm, hol dies! Enlelm, hol das!\" - Arghh! Wie ich es hasse!",
      "Ob ich unzufrieden bei den Ta No bin? Nein, auf keinen Fall! Tritt uns am besten bei und melde dich für den Küchendienst! o0(dann kann ich nämlich hier weg, hehe)"))
end

local function tano7_talk(npc, ch)
    npc_message(npc, ch, "Hier könnte ihre Werbung stehen")
end

local function tano8_talk(npc, ch)
    npc_message(npc, ch, "Hier könnte ihre Werbung stehen")
end

local function tano9_talk(npc, ch)
    npc_message(npc, ch, "Hier könnte ihre Werbung stehen")
end

local function tano10_talk(npc, ch)
    npc_message(npc, ch, "Hier könnte ihre Werbung stehen")
end

local function tano11_talk(npc, ch)
    npc_message(npc, ch, "Hier könnte ihre Werbung stehen")
    being_set_direction(npc, DIRECTION_LEFT)
end

local function waypoints(being, num)
    if being == tano[5] then --- Nur Ta No 5 (Koch) beachten
        if (num == 1)and(num == waypointstate[being]) then
            --- Wegpunkt 1 (Küchenanrichte, ganz links)
            schedule_in(1, function()
                    being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
                end)
            schedule_in(5, function()
                    being_walk(tano[5], 23 * TILESIZE + 16, 20 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 2
                end)
            waypointstate[being] = 2
        elseif (num == 2)and(num == waypointstate[being]) then
            --- Wegpunkt 2 (Küchenanrichte, zweite von rechts)
            schedule_in(1, function()
                    being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
                end)
            schedule_in(5, function()
                    being_walk(tano[5], 24 * TILESIZE + 16, 20 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 3
                end)
            waypointstate[being] = 3
        elseif (num == 3)and(num == waypointstate[being]) then
            --- Wegpunkt 3 (Küchenanrichte, ganz rechts)
            schedule_in(1, function()
                    being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
                end)
            schedule_in(5, function()
                    being_walk(tano[5], 20 * TILESIZE + 16, 20 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 1
                end)
            waypointstate[being] = 1
        end
    elseif being == tano[6] then --- Nur Ta No 6 (Küchenhilfe) beachten
        if (num == 1) then
            --- Wegpunkt 1
            if (waypointstate[being] == 1) then
                schedule_in(1, function()
                    being_set_direction(being, DIRECTION_RIGHT) --- Nach rechts schauen
                end)
                schedule_in(5, function()
                    being_walk(being, 9 * TILESIZE + 16, 14 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 2
                end)
                waypointstate[being] = 2
            elseif (waypointstate[being] == 3) then
                schedule_in(1, function()
                    being_set_direction(being, DIRECTION_RIGHT) --- Nach rechts schauen
                end)
                schedule_in(5, function()
                    being_walk(being, 9 * TILESIZE + 16, 19 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 3
                end)
                waypointstate[being] = 4
            elseif (waypointstate[being] == 5) then
                schedule_in(1, function()
                    being_set_direction(being, DIRECTION_RIGHT) --- Nach rechts schauen
                end)
                schedule_in(5, function()
                    being_walk(being, 7 * TILESIZE + 16, 16 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 4
                end)
                waypointstate[being] = 6
            end
        elseif (num == 2)and(waypointstate[being] == 2) then
            --- Wegpunkt 2
            schedule_in(1, function()
                being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
            end)
            schedule_in(5, function()
                being_walk(being, 19 * TILESIZE + 16, 19 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 1
            end)
            waypointstate[being] = 3
        elseif (num == 3)and(waypointstate[being] == 4) then
            --- Wegpunkt 3
            schedule_in(1, function()
                being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
            end)
            schedule_in(5, function()
                being_walk(being, 19 * TILESIZE + 16, 19 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 1
            end)
            waypointstate[being] = 5
        elseif (num == 4)and(waypointstate[being] == 6) then
            --- Wegpunkt 4
            schedule_in(1, function()
                being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
            end)
            schedule_in(5, function()
                being_walk(being, 19 * TILESIZE + 16, 19 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 1
            end)
            waypointstate[being] = 1
        end
    end
end

local function treasure_trap(being)
--  if (being_type(being) == TYPE_CHARACTER) then --- Nur Spieler beachten
--    being_say(tano[2], invertika.get_random_element("Wer nicht hören will muss fühlen.",
--      "Kein Durchgang!",
--      "Du darfst hier nicht durch!",
--      "Draußen bleiben!",
--      "Zutritt verboten!",
--      "Hier darf keiner durch!"))
--    chr_warp(being, get_map_id(), 40 * TILESIZE + 16, 37 * TILESIZE + 16)
--    --- Auskommentiert, weil es zum festhängen des Characters führt
--    ---being_damage(being, 50, 40, 100, 1, 0)
--  end
end

local function treasure_warning(being)
--  if (being_type(being) == TYPE_CHARACTER) then --- Nur Spieler beachten
--    being_say(tano[2], invertika.get_random_element("Keinen Schritt weiter!",
--      "Stopp! Sonst wird es schmerzhaft.",
--      "Halt!"))
--  end
end