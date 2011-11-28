----------------------------------------------------------------------------------
--  Housing Skript                                                              --
--                                                                              --
--  Das Housing Skript stellt die Wohnungsverwaltung zur Verfügung              --
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

-- Wenn dem Spieler das Haus nicht gehört erschein ein Dialog in welchem
-- angezeigt wird wem das Haus gehört und ob er es betretten möchte
-- Dafür benötigt der Spieler dann ein Passwort

-- Im Inneren des Hauses gibt es Terminal an dem der Spieler 
-- das Passwort �ndern kann sowie alle Leute aus dem Haus werfen kann

-- Weiterverkauf?

-- Wenn das Haus keinen Besitzer hat darf es jeder betreten

-- Probleme: zur Zeit keine globalen Variablen möglich

require "scripts/lua/npclib"
