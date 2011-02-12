--- Class PokerDealer

PokerDealer = {}

--- Erstellt eine neue Instanz der Klasse PokerDealer
function PokerDealer:new()
    local res = {}
	setmetatable(res, self)
	self.__index = self
	return res
end

PokerDealer.eventPlayerBet = function(ch, amount)
    -- Leer
end

--- Registriert eine neue PlayerBet-Event-Funktion
-- @param funct Die Funktion, die den PlayerBet-Event abarbeitet
function PokerDealer:registerEventPlayerBet(funct)
    self.eventPlayerBet = funct
end

--- Löst das Event PlayerBet aus.
-- @param ch Der Spieler der ein Gebot abgibt.
-- @param amount Die Menge des Geldes die der Spieler bietet.
function PokerDealer:raiseEventPlayerBet(ch, amount)
    self.eventPlayerBet(ch, amount)
end