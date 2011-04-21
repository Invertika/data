module("arenafight", package.seeall)

require "scripts/lua/npclib"
require "scripts/libs/invertika"

dofile("data/scripts/libs/arenafight/arenafightpvm.lua")

--- Gibt den Arena Rang zurück.
-- @param ch Der Spieler
-- @param arena_string Die Bezeichnung der Arena
-- @return Arena Rang
function get_arena_rank(ch, arena_string)
    return invertika.get_quest_status(ch, "arena_" .. arena_string .. "_rank")
end

--- Setzt den Arena Rang.
-- @param ch Der Spieler
-- @pram arena_string Die Bezeichnung der Arena
-- @param value Wert auf den der Rang gesetzt wird
function set_arena_rank(ch, arena_string, value)
    invertika.set_quest_status(ch, "arena_" .. arena_string .. "_rank")
end

--- Senkt den Arena Rang.
-- @param ch Der Spieler
-- @param arena_string Die Bezeichnung der Arena
-- @param value Der Wert und dem der Rang gesenkt werden soll
function decrease_arena_rank(ch, arena_string, value)
    set_arena_rank(ch, arena_string, math.max(get_arena_rank(ch, arena_string) - value, 0))
end

--- Erhöht den Arena Rang.
-- @param ch Der Spieler
-- @param arena_string Die Bezeichnung der Arena
-- @param value Der Wert und dem der Rang erhöht werden soll
function increase_arena_rank(ch, arena_string, value)
    set_arena_rank(ch, arena_string, get_arena_rank(ch, arena_string) + value)
end


--- Gibt die MonsterId zurück, die dem Rang des Spielers entspricht.
-- @param ch Der Spieler
-- @return ID des Monster das dem Rang des Spielers entspricht
function get_monster_id(ch)
    return 3 -- TODO
end

--- Git die Anzahl der Monster zurück, die dem Rand des Spielers entsprechen.
-- @param ch Der Spieler
-- @return Anzahl der Monster die dem Rang des Spielers entsprechen
function get_monster_number(ch)
    return 5 -- TODO
end
