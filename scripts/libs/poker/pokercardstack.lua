--- Class PokerCardStack

require("pokerconstants")
require("pokercard")

PokerCardStack = {}
PokerCardStack.cards = {}

--- Erstellt eine neue Instanz der Klasse PokerCardStack
function PokerCardStack:new()
    setmetatable(res, self)
    self.__index = self
    self:createCards()
    return res
end

--- PRIVATE: Erzeugt die Karten im Kartenstapel.
function PokerCardStack:createCards()
    self.cards = {}
    local i = 1 -- Für gesamt Zähler
    local j = 1 -- Für Wert Zähler
    local k = 1 -- Für Farbe Zähler

    while j <= table.getn(PokerConstants.CARD_VALUES) do
        k = 0
        while k <= table.getn(PokerConstants.CARD_COLORS) do
            self.cards[i] = PokerCard:new(i, k) -- Karte erzeugen
            i = i + 1
            k = k +1
        end
        j = j + 1
    end
    self:shuffle()
end

--- PRIVATE: Mischt die Karten
function PokerCardStack:shuffle()
    for i = 1, table.getn(self.cards) do
        local j = math.random(i)
        self.cards[i], self.cards[j] = self.cards[j], self.cards[i]
    end
end

--- Gibt die nächste Karte vom Stapel.
-- @return Die nächste Karte vom Stapel.
function PokerCardStack:popCard()
    return table.remove(self.cards)
end
