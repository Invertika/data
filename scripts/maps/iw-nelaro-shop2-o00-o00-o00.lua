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

atinit(function()
    create_npc("Enla", 4, 33 * TILESIZE + 16, 36 * TILESIZE + 16, enla_Talk, nil)
end)

function enla_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Hi, was kann ich für sie tuen?",
      "Hi, was gibt es?",
      "Hi, wie kann ich ihnen helfen?",
      "Hallo, was kann ich für sie tuen?",
      "Hallo, was gibt es?",
      "Hallo, wie kann ich ihnen helfen?",
      "Guten Tag, was kann ich für sie tuen?",
      "Guten Tag, was gibt es?",
      "Guten Tag, wie kann ich ihnen helfen?",
      "Moin",
      "Was wollen sie hier?!"))
      
    while true do
        local v = do_choice(npc, ch, "Kaufen.",
          "Verkaufen.",
          "Nichts, Danke.")
        
        if v == 1 then
            mana.npc_trade(npc, ch, false, {
              {10001, 10, 19}, 
              {10013, 10, 159}, 
              {10002, 10, 997}, 
              {20001, 10, 30}, 
              {20002, 10, 50}, 
              {20011, 10, 30}, 
              {20012, 10, 30}, 
              {20013, 10, 30}, 
              {20014, 10, 30}, 
              {20015, 10, 50}, 
              {20016, 10, 50}, 
              {20017, 10, 50}, 
              {20018, 10, 50}
              })
            break
        elseif v == 2 then
            mana.npc_trade(npc, ch, true)
            break
        elseif v == 3 then
            do_message(npc, ch, invertika.get_random_element("Tschüß",
              "Tschau",
              "Bis Bald",
              "Beehren sie uns bald wieder",
              "Bis irgendwann.",
              "Verschwinde!",
              "Ciao"))
              break
        end
    end
    do_npc_close(npc, ch)
end