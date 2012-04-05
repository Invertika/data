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
require "scripts/libs/sign"
require "scripts/libs/invertika"

require "scripts/libs/warp"

atinit(function()
  create_inter_map_warp_trigger(78, 90, 80, 68) --- Intermap warp
  sign.create_sign(147, 79, "Denkmal des großen Fehlerbehebers")
  
  mana.trigger_create(36 * TILESIZE, 97 * TILESIZE, 2 * TILESIZE, 2 * TILEISZE, "statue_trigger", true);
  
  create_npc("Statue", 1, 36 * TILESIZE + 16, 93 * TILESIZE + 16, statue_talk, nil)
end)

function statue_talk(npc, ch)
    
end

function statue_trigger(ch, id)
    mana.chatmessage(ch, "Ab hier beginnt das Denkmal des großen Fehlerbehebers.")
    mana.chatmessage(ch, "Du darfst erst passieren, sobald du dich als würdig erwiesen hast!")
    
    mana.chr_warp(ch, nil, 33 * TILESIZE + 16, mana.posY(ch))
end