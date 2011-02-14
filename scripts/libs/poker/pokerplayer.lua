--- Class PokerPlayer

PokerPlayer = {}

PokerPlayer.ch = nil
PokerPlayer.spade = nil

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
