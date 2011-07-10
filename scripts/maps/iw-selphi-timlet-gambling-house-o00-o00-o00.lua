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
require "scripts/libs/slotmachine"
require "scripts/libs/invertika"
require "scripts/libs/dice"

atinit(function() 
 create_npc("Slotmaschine", 1, 25 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 1, 27 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 1, 29 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 1, 31 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 1, 33 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 1, 35 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Daniela", 10, 25 * TILESIZE + 16, 27 * TILESIZE + 16, daniela_talk, nil)
 create_npc("Daniela", 1, 30 * TILESIZE + 16, 25 * TILESIZE + 16, dice.dicemanager_talk, nil)
end)

function daniela_talk(npc, ch)
  -- quest init
  invertika.init_quest_status(ch, "selphi_timlet_bruce_quest")
  -- quest get/set functions
  function get_qstatus() return invertika.get_quest_status(ch, "selphi_timlet_bruce_quest") end
  function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_bruce_quest", x) end
  
  if get_qstatus() < 5 then
    do_message(npc, ch, invertika.get_random_element("Stehst du auf der Gästeliste?",
                                                    "Party! Party!",
                                                    "Was willst du?",
                                                    "Kennen wir uns?"))
  elseif get_qstatus() == 5 and mana.chr_inv_count(ch, 40015) >= 1 then
    do_message(npc, ch, "Ein Geschenk von Bruce? Herzlichen Dank!")
    invertika.add_items(ch, 40015, -1, "Geschenk")
    set_qstatus(6)
  elseif get_qstatus() > 5 then
    do_message(npc, ch, invertika.get_random_element("Lust auf Poker?",
                                                      "Danke, dass ihr mir mein Geschenk gebracht habt!"))
  else
    do_message(npc, ch, invertika.get_random_element("Lust auf Poker?",
                                                      "Ich hab ne Glückssträhne!"))
  end
	do_npc_close(npc, ch)
end
