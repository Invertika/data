--- Class PokerGame
-- Mit dieser Klasse kann man ein Pokerspiel durchführen
-- mit allem drum und dran

require("pokerplayer")
require("pokercardstack")
require("pokerpot")

PokerGame = {}

PokerGame.player={}
PokerGame.player_on_turn = nil
PokerGame.pot = nil
PokerGame.card_stack = nil

--- Erstellt eine neue Instanz der Klasse PokerGame
function PokerGame:new(maxPayment)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	self.pot = PokerPot:new(maxPayment)
    self.card_stack = PokerCardStack:new()
	return res
end

--- PRIVATE: Gibt das Playerobjekt zurück, dass zum Char gehört.
-- @return Das dazugehöre Playerobjekt zu ch.
function PokerGame:getPlayerFromCh(ch)
    for i, v ind ipairs(self.player) do
        if v.ch == ch then
            return v
        end
    end
    return nil
end

--- Fügt einen Spieler zum Spiel hinzu.
-- @param ch Spieler der eingefügt wird.
function PokerGame:addPlayer(ch)
    table.insert(self.player, PokerPlayer:new(ch))
end

--- Entfernt einen Spieler vom Spiel
-- @return true wenn Spieler entfernt werden konnte, false wenn nicht.
function PokerGame:removePlayer(ch)
    local my_player = self:getPlayerFromCh(ch)
    if my_player == nil then
        return false
    else
        self.pot:pushPaymentOfPlayerToGeneralPot(my_player)
        table.remove(self.player, i)
        return true
    end
end

--- Nimmt einen Einsatz vom Spieler entgegen.
-- @param ch Spieler, der einen Einsatz leistet.
-- @param amount Höhe des Einsatzes.
-- @return true wenn erfolgreich, false wenn ungültiger Einsatz.
function PokerGame:registerPlayerPayment(ch, amount)
    local my_player = self:getPlayerFromCh(ch)
    if my_player == nil then
        return false
    else
        my_playeR:doPayment(amount)
        return true
    end
end

--- Gibt den Pot des Spieles zurück.
-- @return Pot des Spieles.
function PokerGame:getPot()
    return self.pot
end

--- Gibt eine Liste mit allen Spielern zurück.
-- @return List aller Spieler.
function PokerGame:getPlayer()
    return self.player
end

--- Gibt zurück wie viel Casino Münzen ein Spieler zu seiner Verfügung stehen hat.
-- @param ch Der Spieler
-- @return Menge der Casinomünzen des Spielers.
function PokerGame:getPlayerMoney(ch)
    local my_player = self:getPlayerFromCh(ch)
    if my_player == nil then
        return nil
    else 
        return my_player:getMoney()
end

--- Prüft ob der Spieler spielt.
-- @param ch Der Spieler.
-- @return true wenn der Spieler im Spiel ist, false wenn nicht.
function PokerGame:playerIsInGame(ch)
    local my_player = self:getPlayerFromCh(ch)
    if my_player ~= nil then
        return true
    else
        return false
    end
end

--- Prüft ob der Spieler an der Reihe ist.
-- @param ch Der Spieler.
-- @return true wenn Spieler an der Reihe, false wenn nicht.
function PokerGame:playerIsOnTurn(ch)
    return (self.player_on_turn.ch == ch)
end

--- Prüft welche Möglichkeiten ein Spieler hat.
-- @param ch Der Spieler.
-- @return Gibt eine Liste mit Möglichkeiten zurück.
-- @see pokerconstants.lua
function PokerGame:getPossibilities(ch)
    local my_player = self:getPlayerFromCh(ch)
    return self.pot:getPossibilitiesOfPlayer(my_player)
end

--- Gibt zurück um wie viel der Spieler erhöhen muss.
-- @param ch Der Spieler.
-- @return Geld um das der Spieler erhöhen muss.
function PokerGame:getMoneyPlayerHasToRaise(ch)
    return self.pot:getMoneyPlayerHasToRaise(self:getPlayerFromCh(ch))
end

--- Gibt zurück welchen Betrag der Spieler maximal setzen kann.
-- @param ch Der Spieler.
-- @return Betrag um den ch maximal erhöhen kann.
function PokerGame:getMaxMoneyPlayerCanRaise(ch)
    return self.pot_getHighestPossiblePayment(self:getPlayerFromCh(ch))
end

--- Teilt dem Spiel mit, dass ch Fold spielt.
function PokerGame:playerActionFold(ch)
   self:removePlayer(ch)
   self:nextPlayer()
end

--- Teilt dem Spiel mit, dass ch Call spielt.
function PokerGame:playerActionCall(ch)
    local min = self.pot:getMoneyPlayerHasToRaise(ch)
    local my_player = self:getPlayerFromCh(ch)
    my_player:doPayment(pot, min)
    self:nextPlayer()
end

--- Teil dem Spiel mit, dass ch Raise spielt.
function PokerGame:playerActionRaise(ch, amount)
    local my_player = self:getPlayerFromCh(ch)
    my_player:doPayment(pot, amount)
    self:nextPlayer()
end

--- Gibt einem Spieler n Karten
-- @param my_player Spieler dem Karten gegeben werden.
-- @param n Anzahl der Karten.
function PokerGame:givePlayerCards(my_player, n)
    for i=1, n do
        my_player:getSpade():addCard(self.card_stack:popCard())
    end
end

--- Gibt jedem Spieler n Karten
-- @param n Anzahl der Karten
function PokerGame:giveAllPlayerCards(n)
    for i, my_player in ipairs(self.player) do
        for j=1, n do
            my_player:getSpade():addCard(self.card_stack:popCard())
        end
    end
end

--- PRIVATE: nächster Spieler
function PokerGame:nextPlayer()
    -- TODO
end
