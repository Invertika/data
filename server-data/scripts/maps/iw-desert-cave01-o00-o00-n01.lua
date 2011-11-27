----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2010 - 2010 by Invertika Project                                  --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"
require "scripts/libs/sign"
require "scripts/libs/secrets"

atinit(function()
    sign.create_sign(65, 40, "Vorsicht! Hier lauern gefährliche Monster (deutlich gefährlicher als die Fledermäuse). Weitergehen auf eigene Gefahr!")
    secrets.create_secret(42, 18, "MAP20156_1", nil, nil, 500)
    secrets.create_secret(23, 5, "MAP20156_2", 30006, 1, nil)
end)
