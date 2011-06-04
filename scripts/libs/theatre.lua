----------------------------------------------------------------------------------
-- Theater Bibliothek                                                          --
--                                                                              --
-- Die DateTime Bibliothek stellt Funktionen zur Zeit                           --
-- zur Verfügung                                                                --
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

module("theatre", package.seeall)

require "scripts/lua/npclib"

Theatre = {}
Theatre.Monologa=0

-- Konstuktor
function Theatre:new()
	local res = {}
	setmetatable(res, self)
	self.__index = self
	return res
end

function Theatre:Init(x, y, width, height)
    --Scheudler aktivieren
    schedule_every(2, function()
    self.NextStep()
  end)
  
      --Testnpc
    Theatre.Monologa=create_npc("Monologa", 44, 41 * TILESIZE + 16, 17 * TILESIZE + 16, Theatre.monologa_talk, nil) --- Monologa
end

function Theatre.monologa_talk(npc, ch)
  mana.chatmessage(ch, "Theatre.monologa_talk")
end

function Theatre:NextStep()
    mana.being_say(Theatre.Monologa, "Lorem Ipsum sit dolor amet...")
end

