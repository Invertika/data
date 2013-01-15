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
        chr_set_quest(ch, questname, 0)
    end
end

-- Setzt einen Queststatus
-- @param ch Der Charakter dessen Quest initialisiert werden soll.
-- @param questname Der Name des Quests.
-- @param value Der Wert auf den der Quest gesetzt werden soll.
function set_quest_status(ch, questname, value)
    chr_set_quest(ch, questname, tonumber(value))
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
        chr_set_quest(ch, questname, "")
    end
end

-- Setzt einen Queststatus
-- @param ch Der Charakter dessen Quest initialisiert werden soll.
-- @param questname Der Name des Quests.
-- @param value Der Wert auf den der Quest gesetzt werden soll.
function set_quest_status_string(ch, questname, value)
    chr_set_quest(ch, questname, value)
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
    if amount == 0 then return end -- prevent spamming the player
    chr_give_exp(character, attribute, amount, optimalLevel)
    chat_message(character, "Du hast " + amount + "Erfahrungspunkte erhalten!")
end

--- Fügt Character ch amount Aki hinzu (bei negativen Werten wird abgezogen)
-- @param ch Der Spieler dem Geld gegeben werden soll.
-- @param amount Menge des Geldes.
function add_money(ch, amount)
    if amount == 0 then return end -- prevent spamming the player
    local current_money = chr_money(ch)
    if current_money + amount < 0 then
        error("add_money failed: money would be less than 0")
    else
        chr_money_change(ch, amount)
        if amount > 0 then
            chat_message(ch, string.format(MONEY_ADD_TEXT, amount))
        else
            chat_message(ch, string.format(MONEY_REMOVE_TEXT, amount*-1))
        end
    end
end

--- Fügt Charakter ch amount Items der ID id hinzu
-- @param ch Der Spieler dem das Item gegeben werden soll.
-- @param id Id des Items.
-- @param amount Anzahl der Items.
-- @param name Name des Items (sollte auf Itemnamen gesetzt werden)
function add_items(ch, id, amount, name)
    if amount == 0 then return end -- prevent spamming the player
    local success = chr_inv_change(ch, id, amount)
    if success then
        if amount > 0 then
            chat_message(ch, string.format(ITEM_ADD_TEXT, amount, name))
        elseif amount < 0 then
            chat_message(ch, string.format(ITEM_REMOVE_TEXT, -amount, name))
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
    being_damage(being, 999999, 0, 99999, DAMAGE_PHYSICAL, ELEMET_NEUTRAL)
end

tr_messages = {}

function create_npc_talk_random(npc,  messages)
    assert(npc, "create_npc_talk_random called without a npc")
    schedule_in(30, function() npc_talk_random(npc, messages) end)
end

function npc_talk_random(npc, messages)
    local text = messages[math.random(1, #messages)]
    being_say(npc, text)
    schedule_in(math.random(20, 30), function() npc_talk_random(npc, messages) end)
end

tg_timer = {}
function npc_greet_random(npc)
    if tg_timer[npc] then
        if tg_timer[npc] > 500 then
            local beings = get_beings_in_circle(posX(npc), posY(npc), 10 * TILESIZE)
            for i, v in ipairs(beings) do
                local type = being_type(v)
                if (type == TYPE_NPC or type == TYPE_CHARACTER) and v ~= npc and math.random() < 0.3 then
                    being_say(npc, string.format(
                        get_random_element("Hallo %s!", "Tag %s.",
                            "Ah. Lange nicht gesehen %s."), being_get_name(v)))
                    break
                end
            end
            tg_timer[npc] = 1
        end
        tg_timer[npc] = tg_timer[npc] + 1
    else
        tg_timer[npc] = 1
    end
end

function schedule_every_day(hour, min, sec, funct)
    local d = os.date("*t")
    local t = os.time()
    local p = os.time{year=d.year, month=d.month, day=d.day, hour=hour, min=min, sec=sec}
    if t > p then
        p = p + 3600 * 24
    end
    schedule_in(p - t, function()
        funct()
        schedule_every_day(hour, min, sec, funct)
    end)
end
