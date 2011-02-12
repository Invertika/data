require("pokerconstants")

-- PokerCardColor

PokerCardColor = {}

PokerCardColor.color = nil

--- Erstellt eine neue Instanz der Klasse PokercardColor
-- @param color Die Farbe der Karte
function PokerCardColor:new(color)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	res.color = color
	return res
end

--- Gibt den Text der Farbe zurück
-- @return Text der Farbe
function PokerCardColor:getText()
    return PokerConstants.CARD_COLORS[self.color]
end

--- Gibt die Farbe der Karte als Wert zurück
-- @return Wert der Farbe
function PokerCardColor:getValue()
    return self.color
end