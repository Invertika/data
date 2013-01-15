﻿----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------


require "scripts/lua/npclib"
require "scripts/libs/invertika"



local function saya_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Oh, wir haben Gäste! Tetse, deckst du den Tisch? Ich bin fast fertig.",
      "Tetse lernte ich vor sehr langer Zeit kennen.",
      "Wir haben hier alles was wir brauchen.",
      "Okita ist vor einiger Zeit gegangen, er sagte, er müsse einige Dinge klären."))
end

local function tetse_talk(npc, ch)
    local questname = "twin_house_quest"
    invertika.init_quest_status(ch, questname)
    local function get_qstatus() return invertika.get_quest_status(ch, questname) end
    local function set_qstatus(x) invertika.set_quest_status(ch, questname, x) end

    if get_qstatus() == 1 then
        if chr_inv_count(ch, 10008) > 0 then
            npc_message(npc, ch, "Du hast mein Schwert! Ich suche es seit Jahren! Ich habe es einst in einer großen Schlacht verloren. Gibst du es mir wieder?")
            while true do
                local v = npc_choice(npc, ch,
                  "Hier ist es.",
                  "Nein. Dies ist mein Schwert!")
                if v == 1 then
                    invertika.add_items(ch, 10008, -1, "Tetses Schwert")
                    npc_message(npc, ch, "Nimm als Dank dieses Geld.")
                    invertika.add_money(ch, 5000) -- Ändern?
                    set_qstatus(2)
                    break
                elseif v == 2 then
                    npc_message(npc, ch, "Verflucht sollst du sein! Invertika wird dich für dein Vergehen bestrafen!")
                    break
                end
            end
        else
            npc_message(npc, ch, "Ich verlor einst ein Schwert. Wenn du es findest bekommst du von mir eine gute Belohnung.")
        end
    else
        npc_message(npc, ch, invertika.get_random_element(
          "Ja Saya, ich decke gleich den Tisch. Ich muss nur noch schnell mein Katana schärfen.",
          "Sei willkommen Gast. Gleich gibt es etwas zu essen.",
          "Du suchst Okita? Er ist schon lange Zeit nicht mehr hier gewesen. Ich glaube er wollte zur Küste.",
          "Ja der Sandsturm wütet. Das geht schon die ganze Zeit so.",
          "Warst du an ihrem Grab?"))
    end
end

atinit(function()
    npc_create("Saya", 7, GENDER_UNSPECIFIED, 43 * TILESIZE + 16, 15 * TILESIZE + 16, saya_talk, nil) --- Saya
    npc_create("Tetse", 138, GENDER_UNSPECIFIED, 45 * TILESIZE + 16, 23 * TILESIZE + 16, tetse_talk, nil) --- Tetse
end)
