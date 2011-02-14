--- Class PokerDealer

PokerDealer = {}
PokerDealer.game = nil

--- Erstellt eine neue Instanz der Klasse PokerDealer
function PokerDealer:new(maxPayment)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	self.game = PokerGame:new(maxPayment)
	return res
end

--- Prüft ob ein beliebiger Spieler inaktiv ist.
-- @return true Wenn Spieler inaktiv, false wenn nicht.
function PokerDealer:playerIsInactive()
    if self.game.player_on_turn:getTimePlayerIsOnTurn() > PokerConstants.TIMEOUT then
        return true
    else
        return false
    end
end

--- Entfernt einen inaktiven Spieler.
function PokerDealer:removeInactivePlayer()
    for i=1, table.getn(self.game.player) do
        if self.game.player[i]:getTimePlayerIsOnTurn() > PokerConstants.TIMEOUT then
            table.remove(self.game.player, i)
            break
        end
    end
end
