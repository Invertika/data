----------------------------------------------------------------------------------
-- Verkäufer Skript                                                             --
--                                                                              --
-- Dieses Skript stellt einen generischen Verkäufer bereit                      --
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

module("seller", package.seeall)

require "scripts/lua/npclib"

--- NPC Talk Funktion
function seller_talk(npc, ch)
    local sellcase = mana.npc_trade(npc, ch, true)
    if sellcase == 0 then
      do_message(npc, ch, "Hi, was möchtest du verkaufen?")
    elseif sellcase == 1 then
      do_message(npc, ch, "Ich bin an deinen Sachen nicht interessiert.")
    else
      do_message(npc, ch, "Hmm irgendetwas stimmt nicht...")
    end
    
    do_npc_close(npc, ch)
end
