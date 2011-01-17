----------------------------------------------------------------------------------
-- Sign-Modul - Funktionen fuer Schilder                                        --
--                                                                              --
-- Dieses Modul stellt Grundfunktionen für Schilder (als NPCs) zur Verfuegung   --
--                                                                              --
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

module("sign", package.seeall)
require "scripts/lua/npclib"

--- Hier werden alle Schildertexte gespeichert, signtext[schild] = text
local signtext = {}

--- Erzeugt ein Schild mit Aufschrift als NPC (ohne Grafik, diese sollte schon gemappt sein)
--- Position in TILES, nicht in Pixel
function create_sign(xpos, ypos, text)
  npc = create_npc("Schild", 1, xpos*TILESIZE+16, ypos*TILESIZE+16, sign_read, nil) --- Schild
  signtext[npc] = text
end

function sign_read(npc, ch)
  do_message(npc, ch, signtext[npc])
  do_npc_close(npc, ch)
end
