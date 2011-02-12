require("pokerconstants")

-- Class PokerCardValue

PokerCardValue = {}
PokerCardValue.value = nil

--- Erzeugt eine neue Instanz der Klasse PokerCardValue
-- @param value Der Wert der Karte; Zahl von 1 - 8 (je höher, desto größer der Wert)
function PokerCardValue:new(value)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	res.value = value
	return res
end

--- Gibt den Text des Kartenwertes zurück
-- @return Text des Kartenwertes
function PokerCardValue:getText()
    return PokerConstants.CARD_VALUES[self.value]
end

--- Gibt den Kartenwert als Zahl zurück
-- @return Kartenwert als Zahl von 1 - 8 (je höher, desto größer der Wert)
function PokerCardValue:getValue()
    return self.value
end