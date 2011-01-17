----------------------------------------------------------------------------------
--  Housing Skript                                                              --
--                                                                              --
--  Das Housing Skript stellt die Wohnungsverwaltung zur Verf�gung              --
--                                                                              --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2009 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

-- Vor jedem Haus gibt es eine Trigger Zone. 
-- Diese Trigger Zone kontroliert ob der Charakter der Besitzer ist
-- Wenn dies der Fall ist warpt der Trigger den Charakter hinein

-- Wenn dem Spieler das Haus nicht geh�rt erschein ein Dialog in welchem
-- angezeigt wird wem das Haus geh�rt und ob er es betretten m�chte
-- Daf�r ben�tigt der Spieler dann ein passwort

-- Im Inneren des Hauses gibt es Terminal an dem der Spieler 
-- das Passwort �ndern kann sowie alle Leute aus dem Haus werfen kann

-- Weiterverkauf?

-- Wenn das Haus keinen Besitzer hat darf es jeder betreten

-- Probleme: zur zeit keine globalen Variablen m�glich

require "scripts/lua/npclib"