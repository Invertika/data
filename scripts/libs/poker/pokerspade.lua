require("../invertika") -- TODO: Pfad anpassen
require("pokercard")
require("pokerspaderater")

--- Class PokerSpade
PokerSpade = {}
PokerSpade.cards = {}
PokerSpade.rating = nil

--- Erzeugt eine neue Instanz der Klasse PokerSpade
function PokerSpade:new()
    local res = {}
	setmetatable(res, self)
	self.__index = self
	return res
end

--- Fügt eine Karte zum Blatt hinzu
-- @param card Die Karte vom Typ Pokercard, die hinzugefügt werden soll
function PokerSpade:addCard(card)
    table.insert(self.cards, card)
    self:sort()
    self.rating = nil -- Bewertung wird ungültig
end

--- Entfernt eine Karte aus der Hand.
-- @param pos Die Position der Karte, die entfernt werden soll
function PokerSpade:removeCard(pos)
    table.remove(self.cards, pos)
    self.rating = nil -- Bewertung wird ungültig
end

--- Gibt die Anzahl der Karten zurück.
-- @return Anzahl der Karten.
function PokerSpade:getCardCount()
    return table.getn(self.cards)
end

--- Gibt eine Kopie der Karten zurück.
-- @return Kopie der Karten des Blattes.
function PokerSpade:getCards()
    return invertika.tablecopy(self.cards)
end

--- PRIVATE: Sortiert die Karten in der Hand.
-- Dabei kommt die schlechteste Karte zuunterst
function PokerSpade:sort()
    table.sort(self.cards, function(a,b) return a:isBetterThan(b) end)
end

--- Gibt die Wertung des Blattes zurück.
-- @return Wertung des Blattes
-- @see pokerconstants.lua
function PokerSpade:getSpadeType()
    if self.rating == nil then
        self.rating = PokerSpadeRater:getSpadeType(self)
    end
    return invertika.tablecopy(self.rating)
end