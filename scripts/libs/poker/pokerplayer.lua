--- Class PokerPlayer

PokerPlayer = {}

PokerPlayer.ch = nil
PokerPlayer.spade = nil
PokerPlayer.time_rounde_start = nil

--- Erstellt eine neue Instanz der Klasse PokerPlayer
function PokerPlayer:new(ch)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	self.ch = ch
	self.spade = PokerSpade:new()
	return res
end

--- Gibt die Anzahl von Casinomünzen zurück.
-- @return Anzahl der Casionemünzen die der Spieler besitzt.
function PokerPlayer:getMoney()
    return mana.chr_inv_count(self.ch, PokerConstants.ID_OF_POKER_CHIPS)
end

--- PRIVATE Zieht dem Spieler eine Anzahl von Münzen ab.
function PokerPlayer:removeMoney(amount)
    mana.chr_inv_count(self.ch, PokerConstants.ID_OF_POKER_CHIPS, -amount)
end

--- Gibt einen Betrag in den Pot.
-- @param pot der Pot in den das Gebot wandert.
-- @param amount Menge des Geldes.
function PokerPlayer:doPayment(pot, amount)
    self:removeMoney(amount)
    pot:doPayment(self, amount)
end

--- Signalisiert dem Spieler, dass er am Zug ist.
function PokerPlayer:startTurn()
    self.time_round_start = os.time(t)
end

--- Singalisiert dem Spieler, dass sein Zug beendet ist.
function PokerPlayer:endTurn()
    self.time_round_start = nil
end

--- Gibt die Zeit zurück die verstrichen ist seit der Spieler am Zug ist.
-- @return Zeit seit Beginn der Zuges.
function PokerPlayer:getTimePlayerIsOnTurn()
    if self.time_round_start == nil then
        return 0
    else
        return self.time_round_start - os.time(t)
    end
end

--- Gibt das Blatt des Spielers zurück.
-- @return Das Blatt des Spielers.
function PokerPlayer:getSpade()
    return self.spade
end


--- Gibt den Charakter zurück.
-- @return Den Charakter
function PokerPlayer:getCh()
    return self.ch
end
