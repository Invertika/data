----------------------------------------------------------------------------------
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

atinit(function()
    --TODO: Change NPC Sprite
    npc_create("Dache", 21, GENDER_UNSPECIFIED, 23 * TILESIZE + 16, 38 * TILESIZE + 16, dache_talk, nil)
    npc_create("Fohon", 5 , GENDER_UNSPECIFIED, 29 * TILESIZE + 16, 36 * TILESIZE + 16, fohon_talk, nil)
end)

local function dache_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Noch ein Drink und dann wars das.",
      "So langsam sehe ich alles doppelt.",
      "Mmmm also ich weiß ja nicht."))
end

local function fohon_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Was kann ich für sie tuen?",
      "Was möchten sie?"))
    while true do
        local v = npc_choice(npc, ch,
          "Kaufen.",
          "Nichts. Danke.")
        if v == 1 then
            npc_trade(npc, ch, false,
              {{30009, 25, 150},
              {30010, 25, 150},
              {30011, 290, 205},
              {30012, 70, 150},
              {30014, 25, 1000},
              {30026, 10, 500},
              {30027, 1, 250},
              {30001, 25, 300},
              {30006, 400, 200},
              {30007, 300, 200}})
            break
        elseif v == 2 then
            npc_message(npc, ch, invertika.get_random_element(
              "Einen guten Tag noch.",
              "Einen schönen Tag noch."))
            break
        end
    end
end