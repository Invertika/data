--- Class ArenaFightPvM

require("data/scripts/libs/invertika")

MONSTER_SPAWN_SCATTER = 1000

ArenaFightPvM = {}

-- Events
ArenaFightPvM.event_player_died = function() end
ArenaFightPvM.event_monster_died = function() end
ArenaFightPvM.event_last_monster_died = function() end

--- Erstellt ene neue Instanz der Klasse ArenaFightPvM
-- @param ch Der Charakter, der kämpfen soll.
function ArenaFightPvM:new(ch, my_monster_id, my_monster_number)
    local res = {}
	setmetatable(res, self)
	self.__index = self
    self.ch = ch
    self.monster_id = my_monster_id
    self.monster_number = my_monster_number
    self.monsters = {}
    self.fight_running = false
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

--- Registriert eine Funktion, die das Event last Monster died behandeln soll.
-- @param funct Eine Funktion, die das Event last Monster died behandeln soll
function ArenaFightPvM:registerEventLastMonsterDied(funct)
    self.event_last_monster_died = funct
end
--- Ruft das Event Player died auf.
function ArenaFightPvM:raiseEventPlayerDied()
    self.event_player_died(self.ch)
end

--- Ruft das Event Monster killed auf.
function ArenaFightPvM:raiseEventMonsterKilled(monster)
    if #self.monsters == 0 then
        self.event_last_monster_died(monster)
    else
        self.event_monster_died(monster)
    end
end

-- Getter

--- Gibt den Spieler zurück.
-- @return Gibt den Charakter zurück
function ArenaFightPvM:getCh()
    return self.ch
end

--- Gibt die Anzahl verbliebender Monster zurück.
-- @return Zahl der verbliebenden Monster
function ArenaFightPvM:getNumberOfRemainingMonsters()
    return #self.monsters
end

--- Gibt zurück ob der Kampf läuft.
-- @return True, wenn der Kampf läuft, false wenn nicht
function ArenaFightPvM:isStarted()
    return self.fight_running
end

function ArenaFightPvM:getNextMonsterPosX()
    return math.random(mana.posX(self.ch) - MONSTER_SPAWN_SCATTER, mana.posX(self.ch) + MONSTER_SPAWN_SCATTER)
end

function ArenaFightPvM:getNextMonsterPosY()
    return math.random(mana.posY(self.ch) - MONSTER_SPAWN_SCATTER, mana.posY(self.ch) + MONSTER_SPAWN_SCATTER)
end

function ArenaFightPvM:addMonster(monster)
    on_death(monster, self:getFunctionForMonsterDeath(i))
    table.insert(self.monsters, monster)
end

function ArenaFightPvM:getMonsterId()
    return self.monster_id
end

function ArenaFightPvM:getMonsterNumber()
    return self.monster_number
end

function ArenaFightPvM:startFight()
    self.fight_started = true
    on_death(self.ch, self:playerDied())
    -- Monster spawnen.
    for i=1,self.monster_number do
        local monster = mana.monster_create(self.monster_id,
          math.random(mana.posX(self.ch) - MONSTER_SPAWN_SCATTER,
            mana.posX(self.ch) + MONSTER_SPAWN_SCATTER),
          math.random(mana.posY(self.ch) - MONSTER_SPAWN_SCATTER,
            mana.posY(self.ch) + MONSTER_SPAWN_SCATTER))
        table.insert(self.monsters, monster)
    end
end

--- Tötet ein Monster.
-- @param monster Das zu tötende Monster.
function ArenaFightPvM:killMonster(monster)
    for i,v in ipairs(self.monsters) do
        if v == monster then
            invertika.kill_being(monster)
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
    self:raiseEventMonsterDied(table.remove(self.monsters, monster_number))
end

--- Gibt das Objekt frei.
function ArenaFightPvM:delete()
    self.event_player_died = function() end
    self.event_monster_died = function() end
    -- Tötet alle Monster.
    while self.monsters[1] ~= nil do
        self:killMonster(self.monster[1])
    end
end
