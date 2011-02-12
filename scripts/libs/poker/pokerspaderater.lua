require("scripts/lib/pokerspade")

--- Erstellt eine neue Instanz der Klasse PokerSpadeRater
function PokerSpadeRater:new()
    local res = {}
	setmetatable(res, self)
	self.__index = self
	return res
end

--- Gibt den Wert-typ des Blattes zurück
-- @return Wert-typ des Blattes
-- @param spade Blatt das zu Bewerten ist.
function PokerSpadeRater:getSpadeType(spade)
    
end

