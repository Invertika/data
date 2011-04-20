--- Class ArenaFightPvM

require("data/scripts/libs/invertika")

MONSTER_SPAWN_SCATTER = 1000

ArenaFightPvM = {}

-- Events
ArenaFightPvM.event_player_died = nil
ArenaFightPvM.event_monster_died = nil
self.monsters = nil

--- Erstellt ene neue Instanz der Klasse ArenaFightPvM
-- @param ch Der Charakter, der kämpfen soll.
function ArenaFightPvM:new(ch, monster_id, monster_number)
    local res = {}
	setmetatable(res, self)
	self.__index = self
    self.ch = ch
    self.monster_id = monster_id
    self.monster_number = monster_number
    self.monsters = {}
	return res
end

--- Registriert eine Funktion, die das Event Player died behandeln soll.
-- @param funct Eine Funktion, die das Event Player died behandeln soll
function ArenaFightPvM:registerEventPlayerDied(funct)
    self.event_player_died = funct
end

--- Registriert eine Funktion, die das Event Monster died behandeln soll.
-- @param funct Eine Funktion, die das Event Monster died behandeln soll
function ArenaFightPvM:registerEventMonsterDied(funct)
    self.event_monster_died = funct
end

--- Ruft das Event Player died auf.
function ArenaFightPvM:raiseEventPlayerDied()
    self.event_player_died(self.ch)
end

--- Ruft das Event Monster killed auf.
function ArenaFightPvM:raiseEventMonsterKilled(monster)
    self.event_monster_killed(monster)
end

-- Getter

--- Gibt den Spieler zurück.
-- @return Gibt den Charakter zurück
function ArenaFightPvM:getCh()
    return self.ch
end

--- Gibt die Anzahl verbliebender Monster zurück.
-- @return Zahl der verbliebenden Monster
function ArenaFightPvM:getNumberOfMonsters()
    return #self.monsters
end

function ArenaFightPvM:startFight()
    on_death(self.ch, self:playerDied)
    -- Monster spawnen.
    for i=1,self.monster_number do
        local monster = mana.monster_create(self.monster_id,
          math.random(mana.posX(self.ch) - MONSTER_SPAWN_SCATTER,
            mana.posX(self.ch) + MONSTER_SPAWN_SCATTER),
          math.random(mana.posY(self.ch) - MONSTER_SPAWN_SCATTER,
            mana.posY(self.ch) + MONSTER_SPAWN_SCATTER))
        on_death(monster, self:getFunctionForMonsterDeath(i))
        table.insert(self.monsters, monster)
    end
end

--- Tötet ein Monster.
-- @param monster Das zu tötende Monster.
function ArenaFightPvM:killMonster(monster)
    for i,v in ipairs(self.monsters) do
        if v == monster then
            -- TODO: Monster töten
            break
        end
    end
end

--- PRIVATE: Erstellt eine Funktion um den Tod eines bestimmten Monsters zu behandeln.
function ArenaFightPvM:getFunctionForMonsterDeath(monster_number)
    return function() self:monsterDied(monster_number) end
end

--- PRIVATE: Behandelt die Ereignisse wenn ein Spieler stirbt.
function ArenaFightPvM:playerDied()

end

--- PRIVATE: Behandelt die Ereignisse wenn ein Monster stirbt.
-- @param monster_number Die Position des Monsters im Table
function ArenaFightPvM:monsterDied(monster_number)
    table.remove(self.monsters, monster_number)
    self:raiseEventMonsterDied()
end
