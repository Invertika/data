----------------------------------------------------------------------------------
-- Invertika Modul - Grundfunktionen                                            --
--                                                                              --
-- Dieses Modul stellt Grundfunktionen zur Verfügung                            --
--                                                                              --
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

module("invertika", package.seeall)

require "scripts/lua/npclib"

VALUE = 1
COLOR = 2

CARD_COLORS = {}
CARD_COLORS[1] = "rot"
CARD_COLORS[2] = "blau"
CARD_COLORS[3] = "grün"
CARD_COLORS[4] = "gelb"

CARD_VALUES[] = {}
CARD_VALUES[1] = "e Killermade"
CARD_VALUES[2] = "es Mammut"
CARD_VALUES[3] = "er Sandkriecher"
CARD_VALUES[4] = "e Terranite"
CARD_VALUES[5] = "er Geist"
CARD_VALUES[6] = "er Zombie"
CARD_VALUES[7] = "er Sandwurm"
CARD_VALUES[8] = "e Eidechse"

local CARDS_AVAILABLE = {}

local cards_in_stack = {}
local player = {}
-- player[ch][CARDS][id] = Karten
-- player[ch][LAST_ACTION] = Zeitpunkt der letzten Aktion des Spielers

-- Events
local event_shuffle = function()
  -- Nix 
end

function register_event_shuffle(funct)
    event_shuffle = funct
end

function initialize()
    create_cards()
    cards_in_stack = CARDS_AVAILABLE
end

function create_cards()
    CARDS_AVAILABLE = {}
    local i = 1 -- Für gesamt Zähler
    local j = 1 -- Für Wert Zähler
    local k = 1 -- Für Farbe Zähler

    while j <= table.getn(CARD_VALUES) do
        k = 0
        while k <= table.getn(CARD_COLORS) do
            CARDS_AVAILABLE[i] = {}
            CARDS_AVAILABLE[i][VALUE] = j
            CARDS_AVAILABLE[i][VALUE] = k
            i = i + 1
            k = k +1
        end
        j = j + 1
    end
end

function shuffle()
    event_shuffle()
    for i = 1, table.getn(cards_in_stack) do
        local j = math.random(i)
        cards_in_stack[i], cards_in_stack[j] = cards_in_stack[j], cards_in_stack[i]
    end
end

function round1(ch)

end

function round2(ch)

end

function get_min_input(ch)
