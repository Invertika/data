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
require "scripts/libs/nethek"
require "scripts/libs/sign"
require "scripts/libs/invertika"

dofile("data/scripts/libs/warp.lua")

atinit(function()
    create_inter_map_warp_trigger(58, 70, 60, 4) --- Intermap warp
    nethek.create_netheksaeule(130 * TILESIZE, 151 * TILESIZE + 16) --- Netheksäule

    sign_descr = "Nelaro"
    sign.create_sign(69, 110, sign_descr) --- Schild Stadtmitte
    
    --TODO Change Sprite IDs
    egroe = create_npc("Egroe", 2, 119 * TILESIZE + 16, 153 * TILESIZE + 16, egroe_talk, egroe_update)
    invertika.create_npc_talk_random(egroe,
      {"Quallitätswaren zum billigsten Preis.",
      "Wasser nur 2500 Aki pro Liter!"})
    thinaima = create_npc("Thinaima", 2, 64 * TILESIZE + 16, 112 * TILESIZE + 16, thinaima_talk, thinaima_update)
    invertika.create_npc_talk_random(thinaima,
      {"Waffen, handgefertigte Waffen!",
      "Wasser zum billigsten Preis in der Region!",
      "Edelste Waren aus dem Norden!"})
    
    --TODO Change Sprite ID
    create_npc("Onurn", 2, 91 * TILESIZE + 16, 98 * TILESIZE + 16, nil, onurn_update)
end)

function egroe_talk(npc, ch)
    --TODO mehr Auswahl
    mana.npc_trade(npc, ch, false, {
      {10001, 20, 620}
    })
    do_npc_close(npc, ch)
end

function egroe_update(npc)
    npclib.walkaround_wide(npc)
    invertika.npc_talk_random(npc)
end

function thinaima_talk(npc, ch)
    --TODO mehr Auswahl
    mana.npc_trade(npc, ch, false, {
      {10001, 20, 620}
    })
    do_npc_close(npc, ch)
end

function thinaima_update(npc)
    npclib.walkaround_wide(npc)
    invertika.npc_talk_random(npc)
end

function onurn_update(npc)
    walkaround_small(npc)
end