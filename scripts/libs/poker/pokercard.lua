require("pokercardvalue")
require("pokercardcolor")


--- Class PokerCard
-- Die Werte einer Pokerkarte können bei der Initialisierung festgelegt werden,
-- danach bleiben diese konstant
PokerCard = {}
PokerCard.value = nil
PokerCard.color = nil

--- Erzeugt eine neue Instanz der Klasse PokerCard
-- @param color Die Farbe der Karte
-- @param value Der Wert der Karte
function PokerCard:new(color, value)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	res.color = PokerCardColor:new(color)
	res.value = PokerCardValue:new(value)
	return res
end

--- Gibt den Wert der Karte zurück.
-- @return Wert der Karte
function PokerCard:getValue()
    return self.value
end

--- Gibt die Farbe der Karte zurück.
-- @return Farbe der Karte
function PokerCard:getColor()
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
function PokerCard:isBetterThan(card2)
    if self.value:getValue() > card2:getValue():getValue() then
        return true
    elseif self.value:getValue() < card2:getValue():getValue() then
        return false
    elseif self.color:getValue() > card2:getColor():getValue() then
    
    elseif self.color:getValue() < card2:getColor():getValue() then
    
    else
        -- 2 Karten mit gleichem Wert und gleicher Farbe
        -- Unmöglich => Warning
        print("[WARN] pokercard.lua: 2 Karten mit gleicher Farbe und gleichen Wert")
        return false
    end
end