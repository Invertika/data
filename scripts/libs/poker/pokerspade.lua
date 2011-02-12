require("scripts/libs/invertika") -- TODO: Pfad anpassen
require("scripts/libs/poker/pokercard")

--- Class PokerSpade
PokerSpade = {}
PokerSpade.cards = {}

--- Erzeugt eine neue Instanz der Klasse PokerSpade
function PokerSpade:new()
    local res = {}
    self.cards = {}
	setmetatable(res, self)
	self.__index = self
	return res
end

--- Fügt eine Karte zum Blatt hinzu
-- @param card Die Karte vom Typ Pokercard, die hinzugefügt werden soll
function PokerSpade:addCard(card)
    table.insert(self.cards, card)
    self:sort()
end

--- Entfernt eine Karte aus der Hand.
-- @param pos Die Position der Karte, die entfernt werden soll
function PokerSpade:removeCard(pos)
    table.remove(self.cards, pos)
end

--- Gibt die Anzahl der Karten zurück.
-- @return Anzahl der Karten.
function PokerSpade:getCardCount()
    return table.getn(self.cards)
end

--- Gibt eine Kopie der Karten zurück.
-- @return Kopie der Karten des Blattes.
function PokerSpade:getCards()
    return table.copy(self.cards)
end

--- PRIVATE: Sortiert die Karten in der Hand.
-- Dabei kommt die schlechteste Karte zuunterst
function PokerSpade:sort()
    self.cards = table.sort(self.cards, function(a,b) return a:isBetterThan(b) end)
end

--- Vergleicht das Blatt mit einem anderen
-- @param spade2 Das Blatt, mit dem verglichen werden soll
-- @return true wenn das Blatt besser als spade2 ist
function PokerSpade:isBetterThan(spade2)

end

--- Gibt den Wert des Blattes zurück.
-- @return Blattwert
function PokerSpade:getSpadeType()
    -- Vielleicht auslagern?
    -- Viel unübersichtlicher Code
end
