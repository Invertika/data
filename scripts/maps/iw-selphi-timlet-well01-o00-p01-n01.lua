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


-- require "scripts/lua/npclib"
-- require "scripts/libs/invertika"
-- 
-- local tano = {}
-- local waypointstate = {}

atinit(function()
  --- NPCs
  tano[1] = create_npc("Irdath", 89, 35 * TILESIZE + 16, 44 * TILESIZE + 16, tano1_talk, npclib.walkaround_small) --- Ta No 1 (Ta No am Eingang)
  tano[2] = create_npc("Rhaor", 91, 42 * TILESIZE + 16, 36 * TILESIZE + 16, tano2_talk, nil) --- Ta No 2 (Schatzkammer Wächter)
  tano[3] = create_npc("Karl", 92, 25 * TILESIZE + 16, 41 * TILESIZE + 16, tano3_talk, nil) --- Ta No 3 (Verkäufer)
  tano[4] = create_npc("Samos", 93, 67 * TILESIZE + 16, 14 * TILESIZE + 16, tano4_talk, nil) --- Ta No 4 (Sektenführer)
  tano[5] = create_npc("Ceria", 94, 20 * TILESIZE + 16, 20 * TILESIZE + 16, tano5_talk, nil) --- Ta No 5 (Köchin)
  tano[6] = create_npc("Enlelm", 95, 19 * TILESIZE + 16, 19 * TILESIZE + 16, tano6_talk, nil) --- Ta No 6 (Küchenhilfe)
  tano[7] = create_npc("Byler", 96, 17 * TILESIZE + 16, 24 * TILESIZE + 16, tano7_talk, nil) --- Ta No 7 (Normal m)
  tano[8] = create_npc("Lyril", 97, 21 * TILESIZE + 16, 24 * TILESIZE + 16, tano8_talk, nil) --- Ta No 8 (Normal f)
  tano[9] = create_npc("Iawar", 98, 26 * TILESIZE + 16, 24 * TILESIZE + 16, tano9_talk, nil) --- Ta No 9 (Normal m)
  tano[10] = create_npc("Isskel", 99, 18 * TILESIZE + 16, 29 * TILESIZE + 16, tano10_talk, nil) --- Ta No 10 (Normal m)
  tano[11] = create_npc("Kahlan", 100, 22 * TILESIZE + 16, 29 * TILESIZE + 16, tano11_talk, nil) --- Ta No 11 (Normal f)
  --- Blickrichtungen
  schedule_in(1, function()
     mana.being_set_direction(tano[7], DIRECTION_RIGHT)
     mana.being_set_direction(tano[8], DIRECTION_LEFT)
     mana.being_set_direction(tano[9], DIRECTION_DOWN)
     mana.being_set_direction(tano[10], DIRECTION_RIGHT)
     mana.being_set_direction(tano[11], DIRECTION_LEFT)
  end)
--  --- Waypoints
--     --- Ta No 5 (Köchin)
--      mana.trigger_create(20 * TILESIZE + 16, 20 * TILESIZE + 16, 1, 1, "waypoints", 1, true) --- Wegpunkt 1 (Küchenanrichte, ganz links)
--      mana.trigger_create(23 * TILESIZE + 16, 20 * TILESIZE + 16, 1, 1, "waypoints", 2, true) --- Wegpunkt 2 (Küchenanrichte, zweite von rechts)
--      mana.trigger_create(24 * TILESIZE + 16, 20 * TILESIZE + 16, 1, 1, "waypoints", 3, true) --- Wegpunkt 3 (Küchenanrichte, ganz rechts)
--      waypointstate[tano[5]] = 1
--  
--     --- Ta No 6 (Küchenhilfe)
--      mana.trigger_create(19 * TILESIZE + 16, 19 * TILESIZE + 16, 1, 1, "waypoints", 1, true) --- Wegpunkt 1 (Küchenanrichte, links vor dem Ofen)
--      mana.trigger_create(9 * TILESIZE + 16, 14 * TILESIZE + 16, 1, 1, "waypoints", 2, true) --- Wegpunkt 2 (Vorratskammer, oben vor dem Regal)
--      mana.trigger_create(9 * TILESIZE + 16, 19 * TILESIZE + 16, 1, 1, "waypoints", 3, true) --- Wegpunkt 3 (Vorratskammer, unten vor einer Kiste)
--      mana.trigger_create(7 * TILESIZE + 16, 16 * TILESIZE + 16, 1, 1, "waypoints", 4, true) --- Wegpunkt 4 (Vorratskammer, links vor einem Sack)
--      waypointstate[tano[6]] = 1
--  --- Schutz der Schatzkammer
--  mana.trigger_create(42 * TILESIZE, 36 * TILESIZE, 2 * TILESIZE, 2 * TILESIZE, "treasure_trap", 0, true)
--  mana.trigger_create(39 * TILESIZE, 36 * TILESIZE, 3 * TILESIZE, 3 * TILESIZE, "treasure_warning", 0, true)
end)
 
function tano1_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Geh doch mal zu Samos, der hat bestimmt einen Auftrag für dich.",
      "Im Laden kannst du erst etwas kaufen, wenn du dir Reputation bei uns erworben hast.",
      "Was das hier ist? Natürlich das Hauptquartier der Ta No!",
      "Unsere Ziele? Die sind geheim!"))
    do_npc_close(npc, ch)
end

function tano2_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Ich passe auf, dass niemand so ohne weiteres in die Schatzkammer geht.",
      "Versuche gar nich erst, etwas zu stehlen!",
      "Über der Schatzkammer hängt ein Schutzzauber.",
      "NEIN, du darfst NICHT in die Schatzkammer."))
    do_npc_close(npc, ch)
end

function tano3_talk(npc, ch)
    do_message(npc, ch, "Ich werde irgendwann mal Waffen und Ausrüstung verkaufen und so.")
    do_npc_close(npc, ch)
end

function tano4_talk(npc, ch)
    do_message(npc, ch, "Ich soll irgendwann mal Quests vergeben, mit denen die Reputation bei den Ta No gesteigert werden kann.")
    do_npc_close(npc, ch)
end

function tano5_talk(npc, ch)
    do_message(npc, ch, "Hier könnte ihre Werbung stehen")
    do_npc_close(npc, ch)
end

function tano6_talk(npc, ch)
    do_message(npc, ch, "Hier könnte ihre Werbung stehen")
    do_npc_close(npc, ch)
end

function tano7_talk(npc, ch)
    do_message(npc, ch, "Hier könnte ihre Werbung stehen")
    do_npc_close(npc, ch)
end

function tano8_talk(npc, ch)
    do_message(npc, ch, "Hier könnte ihre Werbung stehen")
    do_npc_close(npc, ch)
end

function tano9_talk(npc, ch)
    do_message(npc, ch, "Hier könnte ihre Werbung stehen")
    do_npc_close(npc, ch)
end

function tano10_talk(npc, ch)
    do_message(npc, ch, "Hier könnte ihre Werbung stehen")
    do_npc_close(npc, ch)
end

function tano11_talk(npc, ch)
    do_message(npc, ch, "Hier könnte ihre Werbung stehen")
    mana.being_set_direction(npc, DIRECTION_LEFT)
    do_npc_close(npc, ch)
end

function waypoints(being, num)
    if being == tano[5] then --- Nur Ta No 5 (Koch) beachten
        if (num == 1)and(num == waypointstate[being]) then
            --- Wegpunkt 1 (Küchenanrichte, ganz links)
            schedule_in(1, function()
                    mana.being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
                end)
            schedule_in(5, function()
                    mana.being_walk(tano[5], 23 * TILESIZE + 16, 20 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 2
                end)
            waypointstate[being] = 2
        elseif (num == 2)and(num == waypointstate[being]) then
            --- Wegpunkt 2 (Küchenanrichte, zweite von rechts)
            schedule_in(1, function()
                    mana.being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
                end)
            schedule_in(5, function()
                    mana.being_walk(tano[5], 24 * TILESIZE + 16, 20 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 3
                end)
            waypointstate[being] = 3
        elseif (num == 3)and(num == waypointstate[being]) then
            --- Wegpunkt 3 (Küchenanrichte, ganz rechts)
            schedule_in(1, function()
                    mana.being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
                end)
            schedule_in(5, function()
                    mana.being_walk(tano[5], 20 * TILESIZE + 16, 20 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 1
                end)
            waypointstate[being] = 1
        end
    end
    if being == tano[6] then --- Nur Ta No 6 (Küchenhilfe) beachten
        if (num == 1) then
            --- Wegpunkt 1
            if (waypointstate[being] == 1) then
                schedule_in(1, function()
                    mana.being_set_direction(being, DIRECTION_RIGHT) --- Nach rechts schauen
                end)
                schedule_in(5, function()
                    mana.being_walk(being, 9 * TILESIZE + 16, 14 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 2
                end)
                waypointstate[being] = 2
            elseif (waypointstate[being] == 3) then
                schedule_in(1, function()
                    mana.being_set_direction(being, DIRECTION_RIGHT) --- Nach rechts schauen
                end)
                schedule_in(5, function()
                    mana.being_walk(being, 9 * TILESIZE + 16, 19 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 3
                end)
                waypointstate[being] = 4
            elseif (waypointstate[being] == 5) then
                schedule_in(1, function()
                    mana.being_set_direction(being, DIRECTION_RIGHT) --- Nach rechts schauen
                end)
                schedule_in(5, function()
                    mana.being_walk(being, 7 * TILESIZE + 16, 16 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 4
                end)
                waypointstate[being] = 6
            end
        elseif (num == 2)and(waypointstate[being] == 2) then
            --- Wegpunkt 2
            schedule_in(1, function()
                mana.being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
            end)
            schedule_in(5, function()
                mana.being_walk(being, 19 * TILESIZE + 16, 19 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 1
            end)
            waypointstate[being] = 3
        elseif (num == 3)and(waypointstate[being] == 4) then
            --- Wegpunkt 3
            schedule_in(1, function()
                mana.being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
            end)
            schedule_in(5, function()
                mana.being_walk(being, 19 * TILESIZE + 16, 19 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 1
            end)
            waypointstate[being] = 5
        elseif (num == 4)and(waypointstate[being] == 6) then
            --- Wegpunkt 4
            schedule_in(1, function()
                mana.being_set_direction(being, DIRECTION_UP) --- Nach oben schauen
            end)
            schedule_in(5, function()
                mana.being_walk(being, 19 * TILESIZE + 16, 19 * TILESIZE + 16, 1) -- Gehe zu Wegpunkt 1
            end)
            waypointstate[being] = 1
        end
    end
end

function treasure_trap(being)
--  if (mana.being_type(being) == TYPE_CHARACTER) then --- Nur Spieler beachten
--    mana.being_say(tano[2], invertika.get_random_element("Wer nicht hören will muss fühlen.",
--      "Kein Durchgang!",
--      "Du darfst hier nicht durch!",
--      "Draußen bleiben!",
--      "Zutritt verboten!",
--      "Hier darf keiner durch!"))
--    mana.chr_warp(being, mana.get_map_id(), 40 * TILESIZE + 16, 37 * TILESIZE + 16)
--    --- Auskommentiert, weil es zum festhängen des Characters führt
--    ---mana.being_damage(being, 50, 40, 100, 1, 0)
--  end
end

function treasure_warning(being)
--  if (mana.being_type(being) == TYPE_CHARACTER) then --- Nur Spieler beachten
--    mana.being_say(tano[2], invertika.get_random_element("Keinen Schritt weiter!",
--      "Stopp! Sonst wird es schmerzhaft.",
--      "Halt!"))
--  end
end
