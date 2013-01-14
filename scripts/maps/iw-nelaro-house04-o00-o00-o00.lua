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
    --TODO: bessere Namen
    npc_create("Koch", 52, GENDER_UNSPECIFIED, 33 * TILESIZE + 16, 38 * TILESIZE + 16, koch_talk, nil)
    npc_create("Ghang", 60, GENDER_UNSPECIFIED, 20 * TILESIZE + 16, 37 * TILESIZE + 16, ghang_talk, nil)
    npc_create("Estform", 117, GENDER_UNSPECIFIED, 2 * TILESIZE + 16, 31 * TILESIZE + 16, estform_talk, nil)
    npc_create("Ingawu", 17, GENDER_UNSPECIFIED, 19 * TILESIZE + 16, 29 * TILESIZE + 16, ingawu_talk, nil)
    npc_create("Ackona", 4, GENDER_UNSPECIFIED, 32 * TILESIZE + 16, 30 * TILESIZE + 16, ackona_talk, nil)
end)

local function koch_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Ein Ei + noch ein Ei + Bratpfanne = Spiegelei.",
      "Bei der Hitze hier kommt man leicht ins Schwitzen. Musst viel trinken."))
end

local function ghang_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Hallo Fremder, ich war gerade in der Wüste spazieren und es hat wiedereinmal nicht geregnet.",
      "Falls Du Durst hast, verkauft Egroe der hier in der Stadt neben der Netheksäule steht, Wasserflaschen."))
end

local function estform_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Hier siehst Du nur 4 Betten aber mehr als 5 Personen im Raum, das ist merkwürdig...",
      "Da wir hier nur 4 Betten haben praktizieren wir das allseits bewährte Bett-Sharing."))
end

local function ingawu_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Willkommen in unserem bescheidenen Heim, hast Du schon mit den anderen gesprochen?",
      "Manchmal schmeiss ich den Riemen auf die Orgel, dann gehts aber sowas von ab hier!"))
end

local function ackona_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element(
      "Hi, wenn Dir auch so warm ist hier drinnen hilft es vielleicht, z.B. Deine Waffe abzulegen.",
      "Der Kamin ist selbstverständlich gerade nicht in Betrieb, es ist ja schließlich warm genug hier drinnen."))
end
