--- Class PokerDealer

PokerDealer = {}
PokerDealer.game = nil

--- Erstellt eine neue Instanz der Klasse PokerDealer
function PokerDealer:new(maxPayment)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	self.game = PokerGame:new(maxPayment)
	return res
end

PokerDealer.eventPlayerBet = {}
PokerDealer.eventNextPlayer = {}

--- Registriert eine neue PlayerBet-Event-Funktion
-- @param funct Die Funktion(ch, amount), die den PlayerBet-Event abarbeitet
function PokerDealer:registerEventPlayerBet(funct)
    table.insert(self.eventPlayerBet, funct)
end

--- Registriert eine neue NextPlayer-Event-Funktion
-- @param funct Die Funktion(ch), die den NextPlayer-Event abarbeitet
function PokerDealer:registerEventPlayerBet(funct)
    table.insert(self.eventNextPlayer, funct)
end

--- Löst das Event PlayerBet aus.
-- @param ch Der Spieler der ein Gebot abgibt.
-- @param amount Die Menge des Geldes die der Spieler bietet.
function PokerDealer:raiseEventPlayerBet(ch, amount)
    for i, func in ipairs(self.eventPlayerBet) do
        func(ch, amount)
    end
end

--- Löst das Event NextPlayer aus.
-- @param ch Der Spieler der ein Gebot abgeben soll.
function PokerDealer:raiseEventNextPlayer(ch)
    for i, func in ipairs(self.eventNextPlayer) do
        func(ch)
    end
end
