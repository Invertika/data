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
PokerGame.player_was_on_turn = nil
PokerGame.cards_player_swapped = nil
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
    self.player_was_on_turn = {}
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
        self.event_player_exit
        self.pot:pushPaymentOfPlayerToGeneralPot(my_player)
        for i, v in ipairs(self.player) do
            if v == my_player then
                table.remove(self.player, i)
                break
            end
        end
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
    if self.round == PokerConstants.SWAP_ROUND then
        return {PokerConstants.POSSIBILITY_CHANGE_CARD}
    end
    return self.pot:getPossibilitiesOfPlayer(my_player)
end

--- Gibt zurück um wie viel der Spieler erhöhen muss.
-- @param ch Der Spieler.
-- @return Geld um das der Spieler erhöhen muss.
function PokerGame:getMoneyChHasToRaise(ch)
    return self.pot:getMoneyPlayerHasToRaise(self:getPlayerFromCh(ch))
end

--- Gibt zurück welchen Betrag der Spieler maximal setzen kann.
-- @param ch Der Spieler.
-- @return Betrag um den ch maximal erhöhen kann.
function PokerGame:getMaxMoneyPlayerCanRaise(ch)
    return self.pot_getHighestPossiblePayment(self:getPlayerFromCh(ch))
end

--- PRIVATE: Führt generelle Funktion bei einer Spieleraktion aus.
-- @param ch Der Charakter, der eine Aktion ausführt.
function PokerGame:playerAction(ch)
    self:nextPlayer()
end

--- Teilt dem Spiel mit, dass my_player Fold spielt.
-- @param my_player Der Charakter, der eine Aktion ausführt.
function PokerGame:playerActionFold(my_player)
    self:removePlayer(my_player.ch)
    self:playerAction(my_player)
end

--- Teilt dem Spiel mit, dass my_player Call spielt.
-- @param my_player Der Charakter, der eine Aktion ausführt.
function PokerGame:playerActionCall(my_player)
    local min = self.pot:getMoneyChHasToRaise(my_player.ch)
    my_player:doPayment(pot, min)
    self:playerAction(my_player)
end

--- Teil dem Spiel mit, dass my_player Raise spielt.
-- @param my_player Der Charakter, der eine Aktion ausführt.
function PokerGame:playerActionRaise(my_player, amount)
    my_player:doPayment(pot, amount)
    self:playerAction(my_player)
end

--- Lässt einen Spieler eine Karte abwerfen und gibt ihm eine neue.
-- @param card_id Die ID der Karte.
-- @return true Wenn erfolgreimy_player, false wenn nicht.
function PokerGame:playerActionSwapCard(my_player, id)
    if self.cards_player_swapped[my_player] == PokerConstans.MAX_NUMBER_OF_SWAPABLE_CARDS then
        return false
    end
    if my_player:getSpade:removeCard(id) == false then return false
    self.cards_player_swapped[my_player] = self.cards_player_swapped[my_player] + 1
    self:givePlayerCards(my_player, 1)
    self:playerAction(my_player)
    return true
end

--- Teilt dem Spiel mit, dass ch Fold spielt.
-- @param ch Der Charakter, der eine Aktion ausführt.
function PokerGame:chActionFold(ch)
    local my_player = self:getPlayerFromCh(ch)
    return self:playerActionFold(my_player)
end

--- Teilt dem Spiel mit, dass ch Call spielt.
-- @param ch Der Charakter, der eine Aktion ausführt.
function PokerGame:chActionCall(ch)
    local my_player = self:getPlayerFromCh(ch)
    return self:playerActionCall(my_player)
end

--- Teil dem Spiel mit, dass ch Raise spielt.
-- @param ch Der Charakter, der eine Aktion ausführt.
function PokerGame:chActionRaise(ch, amount)
    local my_player = self:getPlayerFromCh(ch)
    self:playerActionRaise(my_player, amount)
end

--- Lässt einen Spieler eine Karte abwerfen und gibt ihm eine neue.
-- @param card_id Die ID der Karte.
-- @return true Wenn erfolgreich, false wenn nicht.
function PokerGame:chActionSwapCard(ch, id)
    local my_player = self:getPlayerFromCh(ch)
    return self:playerActionSwapCard(my_player, id)
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

--- PRIVATE: Gibt zurück ob ein Spieler noch an den Zug kommen kann.
-- @param my_player Der Spieler bei dem getestet werden soll ob er noch einmal an den Zug kommen kann.
-- @return true Wenn der Spieler noch an den Zug kommen kann. false Wenn nicht.
function PokerGame:playerCanComeToTurn(my_player)
    -- TODO: Weitere Bedingungen?
    if self:roundNotAtEnd() == false then
        return false
    elseif self.pot:getMoneyPlayerHasToRaise(my_player) > 0 then
        return true
    elseif self.player_was_on_turn[my_player] == false then
        return true
    end
end

--- nächster Spieler
function PokerGame:nextPlayer()
    if self:roundNotAtEnd() then
        if self.player_on_turn == nil then
            self.player_on_turn = self.player[1]
        else
            self.event_player_ended_turn(self.player_on_turn)
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
            self.event_next_player()
        else
            self:nextPlayer()
        end
    else
        self:nextRound()
    end
end

--- Prüft ob bereits alle Spieler mindestens einmal am Zug waren.
-- @return true wenn alle Spieler mindestens einmal am Zug waren, false wenn nicht.
function PokerGame:allPlayerWereOnTurn()
    for i, v in ipairs(self.player_was_on_turn) do
        if v == false then return false end
    end
    return true
end

--- Prüft ob die aktuelle Bietrunde noch nicht zu Ende ist.
-- @return true Wenn die Runde nicht zu Ende ist, false wenn doch.
function PokerGame:roundNotAtEnd()
    if self:allPlayerWereOnTurn() == false then
        return true
    elseif pot:arePaymentsRequired() then
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
    self.player_was_on_turn = {}
    self.round = self.round + 1
    if self.round == PokerConstants.SWAP_ROUND then
        self.cards_player_swapped = {}
    end
    self.player_on_turn = self.player[1] -- erster Spieler am Zug.
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
            self:remove(self.player[i])
            break
        end
    end
end


function PokerGame:startGame()
    self:giveInitialInput()
    self.round = 0
    self:nextPlayer()
end

--- Gibt von jedem Spieler das Startgebot in den Pot.
function PokerGame:giveInitialInput()
    self:letAllPlayerPay(PokerConstants.INITIAL_PAYMENT)
end
