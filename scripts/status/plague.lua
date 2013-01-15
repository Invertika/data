-------------------------------------------------------------
-- This when applied to a being will spread from one being --
-- to another                                              --
-- Thats all it does.                                      --
----------------------------------------------------------------------------------
--  Copyright 2009 The Mana World Development Team                              --
--                                                                              --
--  This file is part of The Mana World.                                        --
--                                                                              --
--  The Mana World  is free software; you can redistribute  it and/or modify it --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

function tick(target, ticknumber)
    if (ticknumber % 50 == 0) then
        being_say(target, "I have the plague! :( = " .. ticknumber)
    end
        -- So, status direkt mal entfernen, dadurch wird er unbrauchbar
    if (being_get_status_time(target, 1) > 5) then
        being_set_status_time(target, 1, 1)
    end
    local victims = get_beings_in_circle(posX(target), posY(target), 64)
    local i = 1
    while (victims[i]) do
       if (being_has_status(victims[i], 1) == false) then
           being_apply_status(victims[i], 1, ticknumber)
           being_say(victims[i], "I don't feel so good")
       end
       i = i + 1
    end
end
