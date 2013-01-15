----------------------------------------------------------------------------------
-- Theater Bibliothek                                                          --
--                                                                              --
-- Die DateTime Bibliothek stellt Funktionen zur Zeit                           --
-- zur Verfügung                                                                --
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

module("theatre", package.seeall)

require "scripts/lua/npclib"

Theatre = {}
Theatre.Monologa=0

-- talk
Theatre.monologa_talk = function()
  chat_message(ch, "Theatre.monologa_talk")
end

--Stücke
require("scripts/libs/theatre/osterspaziergang")

plotOsterspaziergangInst = plotOsterspaziergang:new()

-- Konstuktor
function Theatre:new(x, y, width, height)
	local res = {}
	setmetatable(res, self)
	self.__index = self

    --Scheduler aktivieren
    schedule_every(2, function()
      Theatre:NextStep()
    end)
    self.Monologa = npc_create("Monologa", 44, GENDER_UNSPECIFIED, 41 * TILESIZE + 16, 17 * TILESIZE + 16,
      self.monologa_talk, nil) --- Monologa
	return res
end


function Theatre:NextStep()
    --Schaue in Spielplan (welches Stück wird zur Zeit gespielt)

    plotOsterspaziergangInst:nextPlotStep()

    --Führe nextPlotStep aus
    being_say(self.Monologa, "Lorem Ipsum sit dolor amet...")
end

