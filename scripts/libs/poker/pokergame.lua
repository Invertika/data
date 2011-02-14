--- Class PokerGame
-- Mit dieser Klasse kann man ein Pokerspiel durchführen
-- mit allem drum und dran
PokerGame = {}

PokerGame.player={}
PokerGame.playerOnTurn = nil
PokerGame.pot = nil

--- Erstellt eine neue Instanz der Klasse PokerGame
function PokerGame:new(maxPayment)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	self.pot = PokerPot:new(maxPayment)
	return res
end

--- PRIVATE
function PokerGame:getPlayerFromCh(ch)
    for i, v ind ipairs(self.player) do
        if v.ch == ch then
            return v
        end
    end
    return nil
end

function PokerGame:addPlayer(ch)
    table.insert(self.player, ch)
end

--- Entfernt einen Spieler vom Spiel
-- @return true wenn Spieler entfernt werden konnte, false wenn nicht.
function PokerGame:removePlayer(ch)
    local my_player = self:getPlayerFromCh(ch)
    if my_player == nil then
        return false
    else
        table.remove(self.player, i)
        return true
    end
end

function PokerGame:registerPlayerPayment(ch, amount)
    local my_player = self:getPlayerFromCh(ch)
    if my_player == nil then
        return false
    else
        my_playeR:doPayment(amount)
        return true
    end
end

function PokerGame:getPot()
    return self.pot
end

function PokerGame:getPlayer()
    return self.player
end

function PokerGame:getPlayerMoney(ch)
    local my_player = self:getPlayerFromCh(ch)
    if my_player == nil then
        return nil
    else 
        return my_player:getMoney()
end
