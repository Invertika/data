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

-- Konstuktor
function Theatre:new()
	local res = {}
	setmetatable(res, self)
	self.__index = self
	return res
end

function Theatre:NextStep()
    mana.chatmessage(character, "NextStep")
end

function Theatre:Init()
    
    -Scheudler aktivieren
    schedule_every(2, function()
    self.NextStep()
  end)
end