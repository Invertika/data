-- Class PokercardValue

PokercardValue = {}
PokercardValue.value = nil

--- Erzeugt eine neue Instanz der Klasse Poker
-- @param value Der Wert der Karte; Zahl von 1 - 8 (je höher, desto größer der Wert)
function PokercardValue:new(value)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	res.value = value
	return res
end

--- Gibt den Text des Kartenwertes zurück
-- @return Text des Kartenwertes
function PokercardValue:getText()
    CARD_VALUES = {}
    CARD_VALUES[8] = "e Killermade"
    CARD_VALUES[7] = "es Mammut"
    CARD_VALUES[6] = "er Sandkriecher"
    CARD_VALUES[5] = "e Terranite"
    CARD_VALUES[4] = "er Geist"
    CARD_VALUES[3] = "er Zombie"
    CARD_VALUES[2] = "er Sandwurm"
    CARD_VALUES[1] = "e Eidechse"
    return CARD_VALUES[self.value]
end

--- Gibt den Kartenwert als Zahl zurück
-- @return Kartenwert als Zahl von 1 - 8 (je höher, desto größer der Wert)
function PokercardValue:getValue()
    return self.value
end

