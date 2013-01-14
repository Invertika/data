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


atinit(function()
     npc_create("Ingrid", 44, GENDER_UNSPECIFIED, 38 * TILESIZE, 16 * TILESIZE + 16, ingrid_talk, nil) --- Ingrid 
     npc_create("Anne", 68, GENDER_UNSPECIFIED, 19 * TILESIZE, 6 * TILESIZE + 16, anne_talk, nil) --- Anne 
     npc_create("Paul", 113, GENDER_UNSPECIFIED, 24 * TILESIZE, 6 * TILESIZE + 16, paul_talk, nil) --- Paul 
end)

local function ingrid_talk(npc, ch)
    npc_message(npc, ch, "Das Theater hat leider noch nicht geöffnet, da wir noch an der Bühne arbeiten.")
end

local function anne_talk(npc, ch)
    npc_message(npc, ch, "Ja, hier können sie ihre Garderobe abgeben, sobald wir geöffnet haben.")
end

local function paul_talk(npc, ch)
    npc_message(npc, ch, "Ihre Garderobe können sie erst nach der Eröffnung abgeben.")
end
