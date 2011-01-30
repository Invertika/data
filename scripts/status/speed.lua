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
    if (ticknumber % 10 == 0) then mana.chatmessage(target, ticknumber) end
    --- Ist nur dazu da, die Geschwindigkeit wieder zurückzusetzen
    if (ticknumber <= 5) then
        mana.being_set_speed(target, 6.0) -- 6 Tiles pro Sekunde - Standard Speed
    end
end
