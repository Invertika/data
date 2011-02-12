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

SPADE_HIGH_CARD = 1
SPADE_ONE_PAIR = 2
SPADE_TWO_PAIR = 3
SPADE_THREE_OF_A_KIND = 4
SPADE_STRAIGHT = 5
SPADE_FLUSH = 6
SPADE_FULL_HOUSE = 7
SPADE_FOUR_OF_A_KIND = 8
SPADE_STRAIGHT_FLUSH = 9
SPADE_ROYAL_FLUSH = 10
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
function register_player(ch)
end
function register_event_shuffle(funct)
    event_shuffle = funct
end
function register_event_next_turn(funct)
    event_next_turn = funct
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
-- Vergleicht Blätter gleicher Wertung.
-- Returns:
-- -1: ch1 hat ein schlechterest Blatt als ch2.
--  0: ch1 und ch2 haben ein gleich gutes Blatt.
--  1: ch1 hat ein besser Blatt als ch2.
function compare_spades_of_same_rating(ch1, ch2, spade_type)
    -- High Card
    if spade_type == SPADE_HIGH_CARD then
        local highest_value_ch1 = 0
        local highest_value_ch2 = 0
        for i = 1, table.getn(player[ch1][CARDS]) do
            if player[ch1][CARDS][i][CARD_VALUE] > highest_value_ch1 then
                highest_value_ch1 = player[ch1][CARDS][i][CARD_VALUE]
            end
            if player[ch2][CARDS][i][CARD_VALUE] > highest_value_ch1 then
                highest_value_ch2 = player[ch2][CARDS][i][CARD_VALUE]
            end
        end
        if highest_value_ch1 > highest_value_ch2 then
            return 1 -- ch1 gewinnt
        elseif highest_value_ch1 < highest_value_ch2 then
            return -1 -- ch2 gewinnt
        else
            return 0 -- keiner gewinnt
        end
    end
    
    
    
    -- Pairs
    
    local rate_same_of_x = function(x)
        
    end
    
    if (spade_type == SPADE_ONE_PAIR) or (spade_type == SPADE_TWO_PAIRS) or (spade_type == SPADE_THREE_OF_A_KIND) or (spade_type == SPADE_FOUR_OF_A_KIND) or (spade_type == SPADE_FULL_HOUSE) then
        local same_of_value1 = {}
        local same_of_value2 = {}
        
   
        for i = 1, table.getn(player[ch1][CARDS]) do -- Geht alle 5 Karten durch
            if same_of_value1[player[ch1][CARDS][i][CARD_VALUE] == nil then
                same_of_value1[player[ch1][CARDS][i][CARD_VALUE]] = 1
            else
                same_of_value1[player[ch1][CARDS][i][CARD_VALUE]] = same_of_value1[player[ch][CARDS[i][CARD_VALUE]] + 1
            end
            
            if same_of_value2[player[ch2][CARDS][i][CARD_VALUE] == nil then
                same_of_value2[player[ch2][CARDS][i][CARD_VALUE]] = 1
            else
                same_of_value2[player[ch2][CARDS][i][CARD_VALUE]] = same_of_value2[player[ch][CARDS[i][CARD_VALUE]] + 1
            end
        end
    
    
        if spade_type == SPADE_ONE_PAIR then
            
            
            
        end
    end
    
    -- Straights
    if (spade_type == SPADE_STRAIGHT) or (spade_type == SPADE_STRAIGHT_FLUSH) then
        -- Höchte Karten der Straßen ermitteln
        local highest_card_ch1 = 0
        local highest_card_ch2 = 0
        for i = 1, table.getn(player[ch1][CARDS]) do -- Geht alle 5 Karten durch
            if highest_card_ch1 < player[ch1][CARDS][i][CARD_VALUE] then
                highest_card_ch1 = player[ch1][CARDS][i][CARD_VALUE]
            end
        end
        for i = 1, table.getn(player[ch2][CARDS]) do -- Geht alle 5 Karten durch
            if highest_card_ch1 < player[ch2][CARDS][i][CARD_VALUE] then
                highest_card_ch1 = player[ch2][CARDS][i][CARD_VALUE]
            end
        end
        if highest_card_ch1 < highest_card_ch2 then
            -- Spieler 1 ist besser
            return 1
        elseif highest_card_ch1 < highest_card_ch2 then
            -- Spieler 2 ist besser
            return -1
        else
            -- Gleich gutes Blatt, Split Pot
            return 0
        end
    end
    
    -- Royal Flush
    if (spade_type == SPADE_ROYAL_FLUSH)
        return 0 -- Bei 2 Royal Flushs immer Split Pot
    end
end
-- Bewertet die Blätter.
-- Returns:
-- SPADE_HIGH_CARD
-- SPADE_ONE_PAIR
-- SPADE_TWO_PAIR
-- SPADE_THREE_OF_A_KIND
-- SPADE_STRAIGHT
-- SPADE_FLUSH
-- SPADE_FULL_HOUSE
-- SPADE_FOUR_OF_A_KIND
-- SPADE_STRAIGHT_FLUSH
-- SPADE_ROYAL_FLUSH
function rate_spade(ch)
    local value = nil
    local same_of_value = {}
    local same_of_color = {}
    -- Gleiche Werte und Farben zählen
    for i = 1, table.getn(player[ch][CARDS]) do -- Geht alle 5 Karten durch
        if same_of_value[player[ch][CARDS][i][CARD_VALUE] == nil then
            same_of_value[player[ch][CARDS][i][CARD_VALUE]] = 1
        else
            same_of_value[player[ch][CARDS][i][CARD_VALUE]] = same_of_value[player[ch][CARDS[i][CARD_VALUE]] + 1
        end
        
        if same_of_color[player[ch][CARDS][i][CARD_COLOR]] == nil then
            same_of_color[player[ch][CARDS][i][CARD_COLOR]] = 1
        else
            same_of_color[player[ch][CARDS][i][CARD_COLOR]] = same_of_color[player[ch][CARDS][i][CARD_COLOR]] + 1
        end
    end
    -- Reihenfolge zählt (isStreet = true => ist eine Strasse von 5 Karten)
    local average = 0
    local isStreet
    for i = 1, table.getn(player[ch][CARDS]) do -- Geht alle 5 Karten durch
        average = average + player[ch][CARDS][i][CARD_VALUE]
    end
    average = average / 5
    if (average >= 3) and (average <= 6) and (average % 1 == 0) then
        if (same_of_value[average - 2] == 1) and (same_of_value[average - 1] == 1) and (same_of_value[average] == 1) and (same_of_value[average + 1] == 1) and (same_of_value[average + 2] == 1) then
            -- Ist eine Straße
            isStreet = true
        end
    end
    -- Royal Flush und Straight Flush
    for i,color in ipairs(same_of_color) do
        if (color >= 5) and isStreet then
            -- Auf höchste Karte testen
            if same_of_value[8] == 1 then
                return SPADE_ROYAL_FLUSH
            else
                return SPADE_STRAIGHT_FLUSH
            end
        end
    end
    -- Vierling
    for i,value in ipairs(same_of_value) do
        if value >= 4 then
            return SPADE_FOUR_OF_A_KIND
        end
    end
    -- Full House
    local number_of_two_of_a_kind = 0
    local number_of_three_of_a_kind = 0
    
    for i,value in ipairs(same_of_value) do
        if value >= 3 then
            number_of_three_of_a_kind = 1
        elseif value >= 2 then
            number_of_two_of_a_kind = 1
        end
    end
    if (number_of_two_of_a_kind == 1) and (number_of_three_of_a_kind == 1) then
        return SPADE_FULL_HOUSE
    end
    -- Flush
    for i,color in ipairs(same_of_color) do
        if color >= 5 then
            return SPADE_FLUSH
        end
    end
    -- Straße
    if isStreet then
        return SPADE_STRAIGHT
    end
    -- Drilling
    for i,value in ipairs(same_of_value) do
        if value >= 3 then
            return SPADE_FOUR_OF_A_KIND
        end
    end
    -- Zwei Paare oder ein Paar
    local number_of_pairs = 0
    for i,value in ipairs(same_of_value) do
        if value >= 2 then
            number_of_pairs = number_of_pairs + 1
        end
    end
    if number_of_pairs >= 2 then
        return SPADE_TWO_PAIRS
    elseif number_of_pairs == 1 then
        return SPADE_ONE_PAIR
    end
    -- High Card
    return SPADE_HIGH_CARD
end
function pop_card()
    if table.getn(cards_in_stack) == 0 then
        cards_in_stack = CARDS_AVAILABLE
        shuffle()
    end
    return table.remove(cards_in_stack)
end
-- Gebe (number) Karten an Spieler (ch)
function deal_cards(ch, number)
    local i = 1
    while i <= number do
       table.insert(player[ch][CARDS], pop_card())
       i = i + 1
    end 
end