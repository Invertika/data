-- Modul invertika
-- http://wiki.invertika.org/Invertika (Lua Modul)

module("invertika", package.seeall)

require "scripts/lua/npclib"

-- Allgemeine Funktionen

-- Gibt ein zufällig eines der übergebenen Argumente zurück
function get_random_element(...)
    local arrayCount = table.getn( arg ) -- Anzahl der Elemente  ermitteln
    local r = math.random(1, arrayCount)
    return arg[r]
end

--- Gibt eine Kopie der Table zurück.
-- @param t Das Table Objekt.
-- @return Kopie von t
function get_table_copy(t)
  local u = { } 
  for k, v in pairs(t) do u[k] = v end 
  return setmetatable(u, getmetatable(t))
end

--- Gibt die Distanz zwischen den beiden übergebenen Punkten an.
-- @param x1 Die X-Koordinate des ersten Punktes.
-- @param y1 Die Y-Koordinate des ersten Punktes.
-- @param x2 Die X-Koordinate des zweiten Punktes.
-- @param y2 Die Y-Koordinate des zweiten Punktes.
-- @return Die Distanz zwischen den Punkten.
function get_distance(x1, y1, x2, y2)
    -- dx: x2 - x1
    -- dy: y2 - y1
    -- Satz des Pythargoras:
    -- dx² + dy² = d²
    return math.sqrt(math.pow(x2 -x1, 2) + math.pow(y2 - y1, 2))
end

-- Queststati           

-- Initialisisert einen Queststatus.
-- @param ch Der Charakter dessen Quest initialisiert werden soll.
-- @param questname Der Name des Quests.
function init_quest_status(ch, questname)
    if tonumber(get_quest_var(ch, questname)) == nil then
        mana.chr_set_quest(ch, questname, 0)
    end
end

-- Setzt einen Queststatus
-- @param ch Der Charakter dessen Quest initialisiert werden soll.
-- @param questname Der Name des Quests.
-- @param value Der Wert auf den der Quest gesetzt werden soll.
function set_quest_status(ch, questname, value)
    mana.chr_set_quest(ch, questname, tonumber(value))
end

-- Gibt einen Queststatus zurück
-- @param ch Der Charakter dessen Quest initialisiert werden soll.
-- @param questname Der Name des Quests.
-- @return Aktuellen Status des Quests.
function get_quest_status(ch, questname)
    return tonumber(get_quest_var(ch, questname))
end

function init_quest_status_string(ch, questname)
    if tonumber(get_quest_var(ch, questname)) == nil then
        mana.chr_set_quest(ch, questname, "")
    end
end

-- Setzt einen Queststatus
-- @param ch Der Charakter dessen Quest initialisiert werden soll.
-- @param questname Der Name des Quests.
-- @param value Der Wert auf den der Quest gesetzt werden soll.
function set_quest_status_string(ch, questname, value)
    mana.chr_set_quest(ch, questname, value)
end

-- Gibt einen Queststatus zurück
-- @param ch Der Charakter dessen Quest initialisiert werden soll.
-- @param questname Der Name des Quests.
-- @return Aktuellen Status des Quests.
function get_quest_status_string(ch, questname)
    return get_quest_var(ch, questname)
end

-- EXP/Skill-Änderungen

local MONEY_ADD_TEXT = "Du hast %s Aki erhalten!"
local MONEY_REMOVE_TEXT = "Du hast %s Aki weniger!"
local ITEM_ADD_TEXT = "Du hast %sx %s erhalten!"
local ITEM_REMOVE_TEXT = "Du hast %sx %s weniger!"

--- Gibt einem Charakter Erfahrungspunkte (experimentell, nicht komplett implementiert)
-- @param character Der Charakter dem Erfahrungspunkte gegeben werden sollen.
-- @param attribute Das Attribute, dass erhöht werden soll.
-- @param amount Anzahl der Arfahrungspunkte die gegeben werden sollen.
-- @param optimalLevel optimalLevel.
function add_exp(character, attribute, amount, optimalLevel)
    mana.chr_give_exp(character, attribute, amount, optimalLevel)
    mana.chatmessage(character, "Du hast " + amount + "Erfahrungspunkte erhalten!")
end

--- Fügt Character ch amount Aki hinzu (bei negativen Werten wird abgezogen)
-- @param ch Der Spieler dem Geld gegeben werden soll.
-- @param amount Menge des Geldes.
function set_money(ch, amount)
    local current_money = mana.chr_money(ch)
    if current_money + amount < 0 then
        error("add_money failed: money would be less than 0")
    else
        mana.chr_money_change(ch, amount)
        if amount > 0 then
            mana.chatmessage(ch, string.format(MONEY_ADD_TEXT, amount))
        else
            mana.chatmessage(ch, string.format(MONEY_REMOVE_TEXT, amount*-1))
        end
    end
end

--- Fügt Charakter ch number Items der ID id hinzu
-- @param ch Der Spieler dem das Item gegeben werden soll.
-- @param id Id des Items.
-- @param number Anzahl der Items.
-- @param name Name des Items (sollte auf Itemnamen gesetzt werden)
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

--- Tötet ein Lebwesen
-- @param being Das zu tötende Lebewesen
function kill_being(being)
    mana.being_damage(being, 999999, 0, 99999, DAMAGE_PHYSICAL, ELEMET_NEUTRAL)
end

local tr_timer = {}
local tr_messages = {}

function create_npc_talk_random(npc,  messages)
    tr_messages[npc] = messages
end

function npc_talk_random(npc)
    if not tr_timer[npc] then
        tr_timer[npc] = 1 
    end 
    tr_timer[npc] = tr_timer[npc] + 1 
    if tr_timer[npc] == 250 then
        local text = get_random_element(tr_messages[npc])
        mana.being_say(npc, text)
        tr_timer[npc] = 1
    end 
end
