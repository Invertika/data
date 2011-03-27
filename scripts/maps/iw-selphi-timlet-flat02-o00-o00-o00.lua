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

atinit(function()
 ---create_npc("Banker", 122, 180 * TILESIZE + 16, 160 * TILESIZE + 16, banker.banker_talk, nil) --- Banker (Debug)
 create_npc("Asam", 66, 76 * TILESIZE + 16, 27 * TILESIZE + 16, asam_talk, nil) -- Asam
 create_npc("Samos", 64, 59 * TILESIZE + 16, 25 * TILESIZE + 16, samos_talk, nil) -- Samos

end)

function asam_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Ich wohne hier.",
      "Serlphie Timlet ist eine schöne Stadt.",
      "Ich bin hier aufgewachsen.",
      "Es gab auch schon schwerere Zeiten."))
    do_npc_close(npc, ch)
end

function samos_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Hol mich hier raus!",
      "Mein Vater hat mich hier eingeschlossen.",
      "Ich hab doch nichts getan!"))
    do_npc_close(npc, ch)
end
