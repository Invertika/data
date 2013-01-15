﻿----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2010 The Invertika Development Team                        --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"


local function manitu_talk(npc, ch)
    npc_message(npc, ch, "Hallo, ich bin der Manitu. Grosses M, kleines anitu. Was kann ich für dich tun?")

    while true do
        local v = npc_choice(npc, ch, "IP Pakete kaufen",
                                     "Merkt ihr euch was ich so tue?",
                                     "Welche Weisheit habt ihr fuer mich?",
                                     "Nichts, danke.")

        if v == 1 then
            npc_trade(npc, ch, false, { {40002, 10, 50}, {40041, 10, 100} })
        elseif v == 2 then
            npc_message(npc, ch, "Nein warum sollte ich mir merken was ihr macht? Ich fuehre keine Protokolle. Schliesslich haben wir doch alle etwas zu verbergen :)")
        elseif v == 3 then
                npc_message(npc, ch, invertika.get_random_element("Wenn du einen Urlaub gebucht hast, halte dich von allem gefaehrlichen fern, bevor du im Urlaub bist. Der große Geist mir diese Weisheit beibrachte.",
      "Weisheit... Mmm... Der große Geist sagte mir einen Server kann man immer gut gebrauchen. Was er wohl damit meinte?",
      "Der große Geist sagt: Sei fair zu deinen Geschäftspartnern.",
      "Sei Menschlich und der Dank ist dir sicher."))
        elseif v == 4 then break
        end
    end
end

local function sandra_talk(npc, ch)
    npc_message(npc, ch, "Hi, ich bin S.A.N.D.R.A.")

    while true do
        local v = npc_choice(npc, ch, "Was bedeutet S.A.N.D.R.A.?",
                                 "Was macht ihr hier eigentlich?",
                                 "Ich wollte nichts fragen. Entschuldigung.")

        if v == 1 then
            npc_message(npc, ch, "S.A.N.D.R.A. steht fuer Serious Awake Nullification Droid for Regard Answers.")
        elseif v == 2 then
            npc_message(npc, ch, "Wir verkaufen hier Sachen, die man nicht sehen kann. Du glaubst garnicht was das in der Lagerung einspart.")
        elseif v == 3 then break
        end
    end
end

atinit(function()
 npc_create("Manitu", 47, GENDER_UNSPECIFIED, 55 * TILESIZE + 16, 23 * TILESIZE + 16, manitu_talk, nil) --- Der grosse Manitu
 npc_create("S.A.N.D.R.A.", 44, GENDER_UNSPECIFIED, 30 * TILESIZE + 16, 22 * TILESIZE + 16, sandra_talk, nil) --- S.A.N.D.R.A.
end)
