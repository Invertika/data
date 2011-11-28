----------------------------------------------------------------------------------
-- Theater Bibliothek                                                          --
--                                                                              --
-- Die DateTime Bibliothek stellt Funktionen zur Zeit                           --
-- zur Verfügung                                                                --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2001 The Invertika Development Team                          --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

module("race", package.seeall)

require "scripts/lua/npclib"
require "scripts/libs/datetime"

Race = {}
Race.StartTime=0
Race.EndTime=0
Race.InProgress=false

Race.Rounds=1
Race.RaceName="none"
Race.BestPlayerTime=-1;
Race.NumberOfCheckpoints=0;
Race.CurrentCheckpoints=0;

-- Konstuktor
function Theatre:new(racename, numberofCheckpoints)
    local res = {}
    setmetatable(res, self)
    self.__index = self

    Race.RaceName=racename
    Race.NumberOfCheckpoints=numberofCheckpoints
end


function Theatre:Start()
    Race.StartTime=datetime.get_current_datetime();
    Race.InProgress=true;
end

function Theatre:Checkpoint(int number)
    if number==Race.CurrentCheckpoints+1 then
        Race.CurrentCheckpoints=number;
    end
end

function Theatre:End()
    if Race.CurrentCheckpoints == Race.NumberOfCheckpoints then
        EndTime=datetime.get_current_datetime();
        Race.InProgress=false;
    end
end

function Theatre:GetTimeForLastRace()
    return Race.EndTime-Race.StartTime;
end
