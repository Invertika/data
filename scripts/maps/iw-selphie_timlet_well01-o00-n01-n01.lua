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
require "scripts/ivklibs/invertika"

atinit(function()
 create_npc("Blubb", 89, 35 * TILESIZE + 16, 44 * TILESIZE + 16, tano1_talk, npclib.walkaround_wide) --- Ta No 1
 wache = create_npc("Schatzwächter", 89, 42 * TILESIZE + 16, 36 * TILESIZE + 16, tano2_talk, nil) --- Ta No 2 (Schatzkammer Wächter)
 create_npc("Karl", 89, 25 * TILESIZE + 16, 41 * TILESIZE + 16, tano3_talk, nil) --- Ta No 3
 
 mana.trigger_create(42, 36, 64, 64, "treasure_trap", 0, true)
end)

function tano1_talk(npc, ch)
    
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

function treasure_trap(being)
  if (mana.being_type(ch) == TYPE_CHARACTER) then --- Nur Spieler beachten
    mana.being_say(wache, invertika.get_random_element("Wer nicht hören will muss fühlen.",
      "Kein Durchgang!",
      "Du darfst hier nicht durch!",
      "Draußen bleiben!",
      "Zutritt verboten!",
      "Hier darf keiner durch!"))
    mana.chr_warp(being, mana.get_map_id(), 40 * TILESIZE + 16, 37 * TILESIZE + 16)
    mana.being_damage(being, 500, 100, 100, 1, 0)
  end
end
