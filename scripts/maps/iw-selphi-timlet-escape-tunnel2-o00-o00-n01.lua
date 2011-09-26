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
require "scripts/libs/sign"

atinit(function()
    sign.create_sign(24, 7, "Gerhards ganz gewöhnlicher Gebrauchtwarenladen \
\
Ganz bestimmt nicht geheim oder schwer zu finden oder so ^^\
Deshalb wird hier auch nicht mit illegaler Ware gehandelt.");
    create_npc("Gerhard", 7, 27 * TILESIZE + 16, 5 * TILESIZE + 16, gerhard_talk, nil) --- Gerhard
end)

function gerhard_talk(npc, ch)
    -- Dieser Händler könnte später mal Speed verkaufen.
    do_message(npc, ch, "Bist du ein Mitglied der Stadtwache? Nein? Sehr gut, was kann ich für dich tun?")
    while true do 
        local v = do_choice(npc, ch, "Kaufen.",
                                     "Verkaufen.",
                                     "Nichts. Danke.")
        if v == 1 then
            mana.npc_trade(npc, ch, false, { {30025, 10, 2000}, {30003, 10, 300}, {20023, 10, 12490} })
            break
        elseif v == 2 then
            mana.npc_trade(npc, ch, true)
            break
        elseif v == 3 then
            do_message(npc, ch, "Wenn die Stadtwache wegen dir von mir erfährt, kannst du dir gleich schonmal deinen Grabstein aussuchen!")
            break
        end
    end
    do_npc_close(npc, ch)
end
