--- Class PokerGame
-- Mit dieser Klasse kann man ein Pokerspiel durchführen
-- mit allem drum und dran
PokerGame = {}

--- Erstellt eine neue Instanz der Klasse PokerGame
function PokerGame:new()
    local res = {}
	setmetatable(res, self)
	self.__index = self
	return res
end