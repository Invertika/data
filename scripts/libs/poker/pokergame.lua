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
PokerGame.round = nil
-- Events
PokerGame.event_next_player = function(my_player) end 
PokerGame.event_player_exit = function(my_player) end 
PokerGame.event_player_ended_turn = function(my_player) end
PokerGame.event_player_won = function(my_player_list) end

--- Erstellt eine neue Instanz der Klasse PokerGame
function PokerGame:new(maxPayment)
    local res = {}
	setmetatable(res, self)
	self.__index = self
	self.pot = PokerPot:new(maxPayment)
    self.card_stack = PokerCardStack:new()
    self.round = 1
	return res
end

--- Registriert eine Funktion die das Event NextPlayer behandeln soll.
-- @param funct Die Funktion die beim Auftreten des Events ausgeführt werden soll.
function PokerGame:registerEventNextPlayer(funct)
    self.event_next_player = funct
end

--- Löst das Event NextPlayer aus.
function PokerGame:raiseEventNextPlayer()
    self.event_next_player(self.player_on_turn)
end

--- Registriert eine Funktion die das Event PlayerExit behandeln soll.
-- @param funct Die Funktion die beim Auftreten des Events ausgeführt werden soll.
function PokerGame:registerEventPlayerExit(funct)
    self.event_player_exit = funct
end

--- Löst das Event PlayerExit aus.
-- @param my_player Der Spieler der entfernt wurde.
function PokerGame:raiseEventPlayerExit(my_player)
    self.event_player_exit(my_player)
end

--- Registriert eine Funktion die das Event PlayerEndedTurn behandeln soll.
-- @param funct Die Funktion die beim Auftreten des Events ausgeführt werden soll.
function PokerGame:registerEventPlayerEndedTurn(funct)
    self.event_player_ended_turn = funct
end

-- Löst das Event PlayerEndedTurn aus.
-- @param my_player Der Spieler der den Zug beendet hat.
function PokerGame:raiseEventPlayerEndedTurn(my_player)
    self.event_player_ended_turn(my_player)
end

--- Registriert eine Funktion die das Even PlayerWon behandeln soll.
-- @param funct Die Funktion die beim Auftreten des Events ausgeführt werden soll.
function PokerGame:registerEventPlayerWon(funct)
    self.event_player_won = funct
end

--- Löst das Event PlayerWon aus.
-- @param player_list Eine Liste der Spieler die etwas gewonnen haben.
function PokgerGame:raiseEventPlayerWon(player_list)
    self.event_player_won(player_list)
end


--- Gibt das Playerobjekt zurück, dass zum Char gehört.
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
        my_player:doPayment(self.pot, amount)
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

--- nächster Spieler
function PokerGame:nextPlayer()
    if self.player_on_turn == nil then
        self.player_on_turn = self.player[1]
    else
        -- Letzter Spieler war grade am Zug.
        if self.player[#self.player] == self.player_on_turn then
            if self.pot:arePaymentRequired() then
                self.player_on_turn = self.player[1]
            else
                self:nextRound()
            end
        else
            for i, my_player in ipairs(self.player) do
                if my_player == self.player_on_turn then
                    self.player_on_turn = self.player[i + 1]
                    break
                end
            end
        end
    end
    if self:playerCanComeToTurn(self.player_on_turn) then
    else
        self:nextPlayer()
    end
end

--- Prüft ob die aktuelle Bietrunde noch nicht zu Ende ist.
-- @return true Wenn die Runde nicht zu Ende ist, false wenn doch.
function PokerGame:roundNotAtEnd()
    if pot::arePaymentsRequired() then
        -- Noch Einzahlungen nötig => Bietrunde läuft noch
        return true
    elseif  then
        -- Noch nicht alle Spieler dran gewesen => Runde noch nicht zu Ende
        return true
    else
        -- Runde zu Ende
        return false
    end
end

--- Lässt alle Spieler einen Beitrag in den Pott leisten.
-- param amount Höhe des Beitrags der geleistet werden muss.
function PokerGame:letAllPlayerPay(amount)
    for i, my_player in ipairs(self.player) do
        my_player:doPayment(self.pot, amount)
    end
end

--- Läutet die nächste Runde ein.
function PokerGame:nextRound()
    -- 1: Grundeinsätze machen. Karten geben.
    -- 2: Andere Karten geben. 
    -- 3: Karten austauschen
    -- 4: Ende.

    self.round = self.round + 1
end

--- Prüft ob ein beliebiger Spieler inaktiv ist.
-- @return true Wenn Spieler inaktiv, false wenn nicht.
function PokerGame:playerIsInactive()
    if self.player_on_turn:getTimePlayerIsOnTurn() > PokerConstants.TIMEOUT then
        return true
    else
        return false
    end 
end

--- Entfernt einen inaktiven Spieler.
function PokerGame:removeInactivePlayer()
    for i=1, table.getn(self.player) do
        if self.player[i]:getTimePlayerIsOnTurn() > PokerConstants.TIMEOUT then
            table.remove(self.player, i)
            break
        end
    end
end

--- Lässt einen Spieler eine Karte abwerfen und gibt ihm eine neue.
-- @param card_id Die ID der Karte.
-- @return true Wenn erfolgreich, false wenn nicht.
function PokerGame:changeCard(ch, id)
    local my_player = self:getPlayerFromCh(ch)
    if my_player == nil then return false end
    if my_player:getSpade:removeCard(id) == false then return false
    self:givePlayerCards(my_player, 1)
    return true
end

function PokerGame:startGame()
    self:giveInitialInput()
    self:nextPlayer()
end

--- Gibt von jedem Spieler das Startgebot in den Pot.
function PokerGame:giveInitialInput()
    self:letAllPlayerPay(PokerConstants.INITIAL_PAYMENT)
end
