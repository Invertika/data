-- PokercardColor

PokercardColor = {}

PokercardColor.color = nil

--- Erstellt eine neue Instanz der Klasse PokercardColor
-- @param color Die Farbe der Karte
function PokercardColor:new(color)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	res.color = color
	return res
end

--- Gibt den Text der Farbe zurück
-- @return Text der Farbe
function PokercardColor:getText()
    CARD_COLORS = {}
    CARD_COLORS[1] = "rot"
    CARD_COLORS[2] = "blau"
    CARD_COLORS[3] = "grün"
    CARD_COLORS[4] = "gelb"
    return CARD_COLORS[self.color]
end

--- Gibt die Farbe der Karte als Wert zurück
-- @return Wert der Farbe
function PokercardColor:getValue()
    return self.color
end
