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
require "scripts/ivklibs/slotmachine"
require "scripts/ivklibs/invertika"

atinit(function() 
 create_npc("Slotmaschine", 20001, 25 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 27 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 29 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 31 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 33 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Slotmaschine", 20001, 35 * TILESIZE + 16, 23 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
 create_npc("Daniela", 106, 25 * TILESIZE + 16, 27 * TILESIZE + 16, daniela_talk, nil)
end)

function daniela_talk(npc, ch)
  -- quest init
  if tonumber(get_quest_var(ch, "selphi_timlet_bruce_quest")) == nil then
    mana.chr_set_quest(ch, "selphi_timlet_bruce_quest", 0)
  end
  -- quest get/set functions
  function get_qstatus() return tonumber(get_quest_var(ch, "selphi_timlet_bruce_quest")) end
  function set_qstatus(x) mana.chr_set_quest(ch, "selphi_timlet_bruce_quest", tonumber(x)) end
  
  if get_qstatus() < 5 then
    do_message(npc, ch, invertika.get_random_element("Stehst du auf der Gästeliste?",
                                                    "Party! Party!",
                                                    "Was willst du?",
                                                    "Kennen wir uns?"))
  elseif get_qstatus() == 5 and mana.chr_inv_count(ch, 40015) >= 1 then
    do_message(npc, ch, "Ein Geschenk von Bruce? Herzlichen Dank!")
    mana.chr_inv_change(ch, 40015, -1)
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
