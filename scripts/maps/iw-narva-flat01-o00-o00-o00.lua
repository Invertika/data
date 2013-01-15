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
require "scripts/libs/invertika"



local function vervtia_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Willkommen in unserem bescheidenen Häuschen.",
      "Mein Mann ist gerade draußen.",
      "Die Arbeit ist hart. Aber man kommt über die Runden."))
end

atinit(function()
    npc_create("Vervtia", 144, GENDER_UNSPECIFIED, 29 * TILESIZE + 16, 38 * TILESIZE + 16, vervtia_talk, npclib.walkaround_small)
end)
