----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2011 The Invertika Development Team                          --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/banker"
require "scripts/libs/invertika"

atinit(function() 
 create_npc("Banker", 11, 45 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 11, 53 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 11, 60 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 11, 67 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 11, 75 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 create_npc("Banker", 11, 83 * TILESIZE + 16, 85 * TILESIZE + 16, banker.banker_talk, nil) --- Banker
 
 --NPCs
 wache = create_npc("Wache", 29, 30 * TILESIZE + 16, 87 * TILESIZE + 16, wache_talk, nil) --- Wache
 create_npc("Wache", 29, 36 * TILESIZE + 16, 87 * TILESIZE + 16, wache_talk, nil) --- Wache
 
 create_npc("Mertox", 2, 24 * TILESIZE + 16, 24 * TILESIZE + 16, mertox_talk, nil) --- Mertox
 
  -- Trigger für die Überwachung des Bereiches
 trigger_create(30 * TILESIZE, 84 * TILESIZE, 7 * TILESIZE, 3 * TILESIZE, "wache_trigger", 1, true) --- Trigger
end)

function wache_trigger(ch, id)
   if (being_type(ch) ~= TYPE_MONSTER) then --- Nur Player durchlassen
     local count = chr_inv_count(ch, 40036)
     
     if count == 0 then
       local x = posX(ch)
       local y = posY(ch)
       chr_warp(ch, get_map_id(), x, 90 * TILESIZE) 
       
       being_say(wache, invertika.get_random_element("Zutritt nur für Mitarbeiter.",
      "Sie sind kein Mitarbeiter der Zentralbank."))
     else
         being_say(wache, invertika.get_random_element("Eine wunderschönen Tag wünsche ich ihnen.",
        "Sie heute auch hier?",
        "Ihre ID Karte ist gültig."))
     end
  end
 end
 
function wache_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Zutritt nur für Mitarbeiter.",
        "Sie sind kein Mitarbeiter der Zentralbank."))
      do_npc_close(npc, ch)
end

function mertox_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Zur Zeit gibt es keine Wirtschaftskenngrößen.",
        "Kommen sie später wieder."))
      do_npc_close(npc, ch)
end