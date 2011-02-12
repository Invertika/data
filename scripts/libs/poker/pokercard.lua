require("scripts/libs/poker/pokercardvalue")
require("scripts/libs/poker/pokercardcolor")


--- Class Pokercard
Pokercard = {}
Pokercard.value = nil
Pokercard.color = nil

--- Erzeugt eine neue Instanz der Klasse Pokercard
-- @param color Die Farbe der Karte vom Typ PokercardColor
-- @param value Der Wert der Karte vom Typ PokercardValue
function Pokercard:new(color, value)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	res.color = color
	res.value = value
	return res
end

--- Gibt den Wert der Karte zurück.
-- @return Wert der Karte
function Pokercard:getValue()
    return self.value
end

--- Gibt die Farbe der Karte zurück.
-- @return Farbe der Karte
function Pokercard:getColor()
    return self.color
end

--- Gibt den Text des Wertes der Karte zurück.
-- @return Text des Wertes der Karte.
function Pokercard:getText()
    return self.color:getText() .. self.value:getText()
end


--- Vergleicht die Karte gegen eine andere Karte.
-- Die Farbe wird hierbei mitverglichen!
-- @return true wenn die Karte besser als card2 ist. False wenn nicht.
function Pokercard:isBetterThan(card2)
    if self.value:getValue() > card2:getValue():getValue() then
        return true
    elseif self.value:getValue() < card2:getValue():getValue() then
        return false
    elseif self.color:getValue() > card2:getColor():getValue() then
    
    elseif self.color:getValue() < card2:getColor():getValue() then
    
    else
        -- 2 Karten mit gleichem Wert und gleicher Farbe
        -- Unmöglich => Warning
        print("[WARN] Pokercard.lua: 2 Karten mit gleicher Farbe und gleichen Wert")
        return false
    end
end
