----------------------------------------------------------------------------------
-- Invertika Modul - Grundfunktionen                                            --
--                                                                              --
-- Dieses Modul stellt Grundfunktionen zur Verfügung                            --
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

module("invertika", package.seeall)

require "scripts/lua/npclib"

CARD_VALUE = 1
CARD_COLOR = 2

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

SPADE_HIGH_CARD = 1
SPADE_ONE_PAIR = 2
SPADE_THREE_OF_A_KIND = 3
SPADE_STRAIGHT = 4
SPADE_FLUSH = 5
SPADE_FULL_HOUSE = 6
SPADE_FOUR_OF_A_KIND = 7
SPADE_STRAIGTH_FLUSH = 8
SPADE_ROYAL_FLUSH = 9

local CARDS_AVAILABLE = {}

local cards_in_stack = {}
local player = {}
-- player[ch][CARDS][id] = Karten
-- player[ch][LAST_ACTION] = Zeitpunkt der letzten Aktion des Spielers

-- Events

-- Wird aufgerufen wenn die Karten gemischt werden
local event_shuffle = function()
  -- Nix 
end

-- Wird auf gerufen wenn der nächste Spieler (ch) an der Reihe ist.
local event_next_turn = function(ch)
    -- Nix
end

INPUT_TYPE_CALL = 1
INPUT_TYPE_RAISE = 2
INPUT_TYPE_FOLD = 3

-- Wird aufgerufen sobald ein Spieler einen Einsatz macht.
local event_player_input = function(ch, amount, input_type)
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
            CARDS_AVAILABLE[i][CARD_VALUE] = j
            CARDS_AVAILABLE[i][CARD_COLOR] = k
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

-- Bewertet die Blätter.
function rate_spade(ch)

end

function pop_card()
    if table.getn(cards_in_stack) == 0 then
        cards_in_stack = CARDS_AVAILABLE
        shuffle()
    end
    return table.remove(cards_in_stack)
end

function deal_cards(ch, number)
    local i = 1
    while i <= number do
       table.insert(player[ch][CARDS], pop_card())
       i = i + 1
    end 
end

