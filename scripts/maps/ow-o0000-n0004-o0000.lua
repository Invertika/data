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

require "scripts/libs/warp"

atinit(function()
    create_inter_map_warp_trigger(58, 70, 60, 4) --- Intermap warp
    nethek.create_netheksaeule(130 * TILESIZE, 151 * TILESIZE + 16) --- Netheksäule

    sign_descr = "Nelaro"
    sign.create_sign(69, 110, sign_descr) --- Schild Stadtmitte
    
    --TODO Change Sprite IDs
    egroe = create_npc("Egroe", 34, 119 * TILESIZE + 16, 153 * TILESIZE + 16, egroe_talk, invertika.npc_talk_random)
    invertika.create_npc_talk_random(egroe,
      {"Qualitätswaren zum billigsten Preis.",
      "Wasser nur 2500 Aki pro Liter!"})
    thinaima = create_npc("Thinaima", 18, 64 * TILESIZE + 16, 112 * TILESIZE + 16, thinaima_talk, invertika.npc_talk_random)
    invertika.create_npc_talk_random(thinaima,
      {"Waffen, handgefertigte Waffen!",
      "Wasser zum billigsten Preis in der Region!",
      "Edelste Waren aus dem Norden!"})
    
    --TODO Change Sprite ID
    onurn = create_npc("Onurn", 2, 91 * TILESIZE + 16, 98 * TILESIZE + 16, onurn_talk, invertika.npc_talk_random)
    invertika.create_npc_talk_random(onurn,
      {"Wasser ist zum Waschen da, auch die Feuerwehr, braucht das Wasser sehr.",
      "Wasser ist zum Waschen da, auch zum Zähneputzen, kann man es benutzen.",
      "Die Fleischlackiererei ist auf der anderen Seite.",
      "˙ɟǝıɥɔs ʇsı ɹǝp 'ʇsǝıl sɐp ɹǝʍ"})
end)

function egroe_talk(npc, ch)
    --TODO mehr Auswahl
    mana.npc_trade(npc, ch, false, {
      {10001, 20, 620},
      {30037, 5, 2500},
      {10013, 30, 140},
      {10002, 30, 1000},
      {10009, 30, 1690},
      {20001, 30, 250},
      {20002, 30, 250},
      {20011, 30, 250},
      {20012, 30, 250},
      {20013, 30, 250}
    })
    do_npc_close(npc, ch)
end

function thinaima_talk(npc, ch)
    --TODO mehr Auswahl
    mana.npc_trade(npc, ch, false, {
      {10001, 20, 620},
      {10013, 30, 140},
      {10002, 30, 1000},
      {10009, 30, 1690},
      {20014, 30, 250},
      {20015, 30, 250},
      {20016, 30, 250},
      {20017, 30, 250},
      {20018, 30, 250},
      {20009, 30, 500} 
    })
    do_npc_close(npc, ch)
end

function onurn_talk(npc, ch)
    do_message(npc, ch, "...")
    while true      
        local v = do_choice(npc, ch, 
                    "Wie ist das Wetter?",
                    "Wie viel Uhr ist es?",
                    "Tschüß")
        if v == 1
            do_message(npc, ch, invertika.get_random_element(
              "Es ist sonnig.",
              "Es ist stürmisch.",
              "Dort oben ist eine Wolke. Vielleicht fängt es ja an zu regnen"))
            break
        else if v == 2
            do_message(npc, ch, "Es ist")
            break
        else
            do_message(npc, ch, "...")
            break
        end
    end
    do_npc_close(npc, ch)
end