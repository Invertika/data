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
  npc_create("Marc", 61, GENDER_UNSPECIFIED, 24 * TILESIZE + 16, 22 * TILESIZE + 16, marc_talk, nil) --- Marc
  
  npc_create("Richard", 25, GENDER_UNSPECIFIED, 36 * TILESIZE + 16, 19 * TILESIZE + 16, richard_talk, nil) --- Richard
  npc_create("Dean", 28, GENDER_UNSPECIFIED, 53 * TILESIZE + 16, 18 * TILESIZE + 16, dean_talk, nil) --- Dean
  npc_create("Anderson", 46, GENDER_UNSPECIFIED, 58 * TILESIZE + 16, 24 * TILESIZE + 16, anderson_talk, nil) --- Anderson
end)

function marc_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Willkommen bei der RDA.",
      "Hallo, ich bin Marc, von der RDA.",
      "Die RDA ist nach ihren Gründern benannt: Richard, Dean und Anderson.",
      "Wir treten für den Umweltschutz ein."))
end

function richard_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Es geht um Pflanzen und so.",
      "Diese großen Dinger, du weißt schon, Bäume, findest du auf so ziemlich jedem Planeten, außer auf PX404.",
      "Nimm dir eine Schaufel und dann, ja... geht es los."))
end

function dean_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Wir schützen die Tiere und Pflanzen auf Amoneus.",
      "Im Moment arbeiten wir an der Aufforstung des Waldes hier.",
      "Einige Bäume sind schon gepflanzt. Es wird also langsam."))
end

function anderson_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Du möchstest uns unterstützen. Mmm da muss ich mir wohl etwas einfallen lassen.",
      "Hilfe ist eigentlich immer gewünscht, da müssen wir einfach mal schauen.",
      "Ja wir benötigen Geld, allerdings müssen wir uns noch eine Spendenkasse besorgen."))
end