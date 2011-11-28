----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2011 The Invertika Development Team                          --
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
  create_npc("Marc", 61, 24 * TILESIZE + 16, 22 * TILESIZE + 16, marc_talk, nil) --- Marc
  
  create_npc("Richard", 25, 36 * TILESIZE + 16, 19 * TILESIZE + 16, richard_talk, nil) --- Richard
  create_npc("Dean", 28, 53 * TILESIZE + 16, 18 * TILESIZE + 16, dean_talk, nil) --- Dean
  create_npc("Anderson", 46, 58 * TILESIZE + 16, 24 * TILESIZE + 16, anderson_talk, nil) --- Anderson
end)

function marc_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Willkommen bei der RDA.",
      "Hallo, ich bin Marc, von der RDA.",
      "Die RDA ist nach ihren Gründern benannt: Richard, Dean und Anderson.",
      "Wir treten für den Umweltschutz ein."))
      do_npc_close(npc, ch)
end

function richard_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Es geht um Pflanzen und so.",
      "Diese großen Dinger du weißt schon, Bäume, findest du auf so ziemlich jedem Planeten, außer auf PX404.",
      "Nimm dir eine Schaufel und dann, ja... geht es los."))
      do_npc_close(npc, ch)
end

function dean_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Wir schützen die Tiere und Pflanzen auf Amoneus.",
      "Im Moment arbeiten wir an der Aufforstung des Waldes hier.",
      "Einige Bäume sind schon gepflanzt. Es wird also langsam."))
      do_npc_close(npc, ch)
end

function anderson_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Du möchstest uns unterstützen. Mmm da muss ich mir wohl etwas einfallen lassen.",
      "Hilfe ist eigentlich immer gewünscht, da müssen wir einfach mal schauen.",
      "Ja wir benötigen Geld, allerdings müssen wir uns noch eine Spendenkasse besorgen."))
      do_npc_close(npc, ch)
end