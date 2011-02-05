----------------------------------------------------------------------------------
-- Secrets-Modul - Funktionen fuer Geheimnisse                                  --
--                                                                              --
-- Dieses Modul stellt Grundfunktionen für Geheimnisse (hinter Geheimgängen)    --
-- zur Verfuegung                                                               --
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

module("secrets", package.seeall)

--- Hier werden alle Geheimnisse gespeichert, secrets[schild] = text
local secrets = {}

--- Erzeugt ein Geheimnis (am besten hinter einem Geheimgang o.ä., da es unsichtbar ist)
--- Position in TILES, nicht in Pixel
function create_secret(xpos, ypos, secretid, itemid, amount, moneyamount)
  mana.trigger_create(xpos*TILESIZE, ypos*TILESIZE, TILESIZE, TILESIZE, "secret_activate", secretid, true)
  secrets[secretid] = {}
  secrets[secretid][0] = itemid
  secrets[secretid][1] = amount
  secrets[secretid][2] = moneyamount
end

function secret_activate(being, secretid)
  -- Geheimnis gefunden
  -- Prüfe auf Player, prüfe auf questvar zur secretid
  -- händige item(s) bzw. Geld aus
  -- UNFERTIG
end
