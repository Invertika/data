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

--- Gibt ein zufällig eines der übergebenen Argumente zurück
function get_random_element(...)
    local arrayCount = table.getn( arg ) -- Anzahl der Elemente  ermitteln
    local r = math.random(1, arrayCount)
    return arg[r]
end

--- Gibt die Distanz zwischen den beiden übergebenen Punkten an.
function get_distance(x1, y1, x2, y2)
    -- dx: x2 - x1
    -- dy: y2 - y1
    -- Satz des Pythargoras:
    -- dx² + dy² = d²
    return math.sqrt(math.pow(x2 -x1, 2) + math.pow(y2 - y1, 2))
end

---------------------------
-- Queststati            --
---------------------------

-- Initialisisert einen Queststatus
function init_quest_status(ch, questname)
    if tonumber(get_quest_var(ch, questname)) == nil then
        mana.chr_set_quest(ch, questname, 0)
    end
end

-- Setzt einen Queststatus
function set_quest_status(ch, questname, value)
    mana.chr_set_quest(ch, questname, tonumber(value))
end

-- Gibt einen Queststatus zurück
function get_quest_status(ch, questname)
    return tonumber(get_quest_var(ch, questname))
end

---------------------------
-- EXP/Skill-Änderungen  --
---------------------------

local MONEY_ADD_TEXT = "Du hast %s Aki erhalten!"
local MONEY_REMOVE_TEXT = "Du hast %s Aki weniger!"
local ITEM_ADD_TEXT = "Du hast %sx %s erhalten!"
local ITEM_REMOVE_TEXT = "Du hast %sx %s weniger!"

-- Experimentell und unfertig
function add_exp(character, attribute, amount, optimalLevel)
    mana.chr_give_exp(character, attribute, amount, optimalLevel)
    mana.chatmessage(character, "Du hast " + amount + "Erfahrungspunkte erhalten!")
end

-- Fügt Character ch amount Aki hinzu (bei negativen Werten wird abgezogen)
function add_money(ch, amount)
    local current_money = mana.chr_money(ch)
    if current_money + amount < 0 then
        error("add_money failed: money would be less than 0")
    else
        mana.chr_money_change(ch, current_money + amount)
        if amount > 0 then
            mana.chatmessage(ch, string.format(MONEY_ADD_TEXT, amount))
        else
            mana.chatmessage(ch, string.format(MONEY_REMOVE_TEXT, amount*-1))
        end
    end
end

-- Fügt Charakter ch numer Items der ID id hinzu
-- name sollte auf den Itemnamen gesetzt werden,
-- damit die Message vom Server richtig aussieht
function add_items(ch, id, number, name)
    local success = mana.chr_inv_change(ch, id, number)
    if success then
        if number > 0 then
            mana.chatmessage(ch, string.format(ITEM_ADD_TEXT, number, name))
        elseif number < 0 then
            mana.chatmessage(ch, string.format(ITEM_REMOVE_TEXT, -number, name))
        else
            -- 0 Items werden hinzugefügt/geändert
            -- Aber wer sollte so etwas tun?
        end
    end
    return success
end
