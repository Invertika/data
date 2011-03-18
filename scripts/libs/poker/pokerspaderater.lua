--- Class PokerSpadeRater
-- Eine statische Klasse (kein Konstruktor!) zum
-- Bewerten und Vergleichen von PokerSpade-Objekten
PokerSpadeRater = {}

--- PRIVATE: Gibt den Wert-typ des Blattes zurück
-- (Stattdessen die entsprechende Methode von PokerSpade benutzen)
-- @see PokerSpade.lua
-- @return Wert-typ des Blattes
-- @param spade Blatt das zu Bewerten ist.
function PokerSpadeRater:getSpadeType(spade)
    -- Royal Flush
    if self:isStraight() and self:isFlush() then
        if self:getNumberOfCardsOfSameValue(spade,
          PokerConstants.CARD_VALUES[8]) == 1 then
            return PokerConstants.SPADE_ROYAL_FLUSH
        else
            return PokerConstatns.SPADE_STRAIGHT_FLUSH
        end
    -- Vierling
    elseif self:isOfAKind(spade, 4) then
        return PokerConstants.SPADE_FOUR_OF_A_KIND
    -- Full House
    elseif self:isOfAKind(spade, 3) and self:isOfAKind(spade, 2) then
        return PokerConstants.SPADE_FULL_HOUSE
    -- Flush
    elseif self:getNumberOfCardsOfSameColor(spade) == 5 then
        return PokerConstants.SPADE_FLUSH
    -- Straight
    elseif self:isStraight(spade) then
        return PokerConstants.SPADE_STRAIGHT
    -- Drilling
    elseif self:isOfAKind(spade, 3) then
        return PokerConstants.SPADE_THREE_OF_A_KIND
    -- Zwei Paare
    elseif self:isTwoPair(spade) then
        return PokerConstants.SPADE_TWO_PAIR
    -- Ein Paar
    elseif self.isOfAKind(spade, 2) then
        return PokerConstants.SPADE_ONE_PAIR
    -- High Card
    else
        return PokerConstants.SPADE_HIGH_CARD
    end
end

--- PRIVATE: Gibt die Anzahl der Karten in der Hand zurück die den Wert value haben.
-- @param spade Das Blatt, dass die Karten enthält.
-- @param value Der Wert der Karte vom Typ PokercardValue.
-- @return Menge der Karten in spade, die den Wert value haben.
function PokerSpadeRater:getNumberOfCardsOfSameValue(spade, value)
    local number = 0
    for i, card in ipairs(spade:getCards()) do
        if card:getValue():getValue() == value:getValue() then
            number = number + 1
        end
    end
    return number
end

--- PRIVATE: Gibt die Anzahl der Karten in der Hand zurück die die Farbe color haben.
-- @param spade Das Blatt, dass die Karten enthält.
-- @param color Der Wert der Karte vom Typ PokerCardColor.
-- @return Menge der Karten in spade, die die Farbe color haben.
function PokerSpadeRater:getNumberOfCardsOfSameColor(spade, color)
    local number = 0
    for i, card in ipairs(spade:getCards()) do
        if card:getColor():getColor() == color:getColor() then
            number = number + 1
        end
    end
    return number
end

--- PRIVATE: Gibt zurück ob das Blatt ein Flush ist.
-- @param spade Das Blatt das zu testen ist.
-- @return true wenn das Blatt ein Flush ist.
function PokerSpadeRater:isFlush(spade)
    local cards = spade:getCards()
    for i, card in ipairs(spade:getCards()) do
        if self:getNumberOfCardsOfSameColor(spade, card:getColor()) == 5 then
            return true
        end
    end
    return false
end

--- PRIVATE: Gibt zurück ob das Blatt eine Straße ist.
-- @param spade Das Blatt das zu testen ist.
-- @return true wenn das Blatt eine Straße enthält.
function PokerSpadeRater:isStraight(spade)
    local average = 0
    local cards = spade:getCards()
    for i = 1, spade:getCardCount() do -- Geht alle 5 Karten durch
        average = average + cards[i]:getValue():getValue()
    end
    average = average / 5
    if (average >= 3) and (average <= 6) and (average % 1 == 0) then
        if (same_of_value[average - 2] == 1) and
          (same_of_value[average - 1] == 1) and
          (same_of_value[average] == 1) and
          (same_of_value[average + 1] == 1) and
          (same_of_value[average + 2] == 1) then
            -- Ist eine Straße
            return true
        else
            -- Ist keine Straße
            return false
        end
    end
end


--- PRIVATE: Gibt zurück ob das Blatt n Karten des selben Wertes enthält.
-- @param spade Das Blatt mit den Karten
-- @param n Anzahl der Karten die den gleichen Wert haben müssen.
-- @return true wenn spade n mal eine Karte mit einem gleich hohem Wert enthält.
function PokerSpadeRater:isOfAKind(spade, n)
    local cards = spade:getCards()
    for i, card in ipairs(cards) do
        if getNumberOfCardsOfSameValue(spade, card.getValue()) == n then
            return true
        end
    end
    return false
end

--- PRIVATE: Gibt zurück ob das Blatt ein doppeltes Paar enthält.
-- @param spade Das Blatt.
function PokerSpadeRater:isTwoPair(spade)
    local cards = spade:getCards()
    local count = 0
    for i, card in ipairs(cards) do
        if getNumberOfCardsOfSameValue(spade, card.getValue()) == 2 then
            count = count + 1
        end
        if count == 3 then -- Quick und Dirty
            return true
        end
    end
    return false
end


--- Vergleicht das Blatt mit einem anderen
-- @param spade1 Blatt1
-- @param spade2 Blatt2
-- @return 1=Blatt1 ist besser als other_spade. -1=schlechter, 0=gleich gut.
function PokerSpade:compareSpades(spade1, spade2)
    if spade1.getSpadeType() > spade2.getSpadeType() then
        return true
    elseif self.getSpadeType() < spade2.getSpadeType() then
        return false
    else -- Gleiche Wertung
        local cards1 = spade1.getCards()
        local cards2 = spade2.getCards()
        
        -- Funktioniert, da die Karten in einem Spade immer sortiert sind
        -- (aufsteigend nach Wert und Farbe)
        local highest_value_spade1 = cards1[1]:getValue():getValue()
        local highest_value_spade2 = cards2[1]:getValue():getValue()
        
        if spade1.getSpadeType() == PokerConstants.SPADE_HIGH_CARD then
            for i=1, 5 do
                if cards1[i]:getValue():getValue() > cards2cards1[i]:getValue():getValue() then
                    return 1
                elseif cards1[i]:getValue():getValue() < cards2cards1[i]:getValue():getValue() then
                    return -1
                end
            end
            return 0
        elseif spade1.getSpadeType() == PokerConstants.SPADE_ONE_PAIR then
            for i=1, 5 do
                if self:getNumberOfCardsOfSameValue(cards1, cards1[i]:getValue()) == 2 then
                    for ii=1, 5 do
                        if self:getNumberOfCardsOfSameValue(cards2, cards2[ii]:getValue()) == 2 then
                            if cards1[i]:getValue():getValue() > cards2[ii]:getValue():getValue() then
                                return 1
                            elseif cards1[i]:getValue():getValue() < cards2[ii]:getValue():getValue() then
                                return -1
                            else
                                break -- Paar ist gleich. Weitere Prüfung unötig
                            end
                        end
                    end
                end
            end
            
            -- Paar ist gleich
            local rest_cards1 = {}
            local rest_cards2 = {}
            for i=1, 5 do
                if self:getNumberOfCardsOfSameValue(cards1, cards1[i]:getValue()) ~= 2 then
                    table.insert(rest_cards1, cards1[i])
                end
                if self:getNumberOfCardsOfSameValue(cards2, cards2[i]:getValue()) ~= 2 then
                    table.insert(rest_cards2, cards2[i])
                end
            end
            -- Große Karten an den Anfang
            table.sort(rest_cards1, function(a, b) return a > b end)
            table.sort(rest_cards2, function(a, b) return a > b end)
            for i=1, 3 do
                if rest_cards1[i]:getValue():getValue() > rest_cards2[i]:getValue():getValue() then
                    return 1
                elseif rest_cards1[i]:getValue():getValue() < rest_cards2[i]:getValue():getValue() then
                    return -1
                end
            end
            return 0
        elseif spade1.getSpadeType() == PokerConstants.SPADE_TWO_PAIR then
            
        elseif spade1.getSpadeType() == PokerConstants.SPADE_THREE_OF_A_KIND then
            for i=1, 5 do
                if self:getNumberOfCardsOfSameValue(cards1, cards1[i]:getValue()) == 3 then
                    for ii=1, 5 do
                        if self:getNumberOfCardsOfSameValue(cards2, cards2[ii]:getValue()) == 3 then
                            if cards1[i]:getValue():getValue() > cards2[ii]:getValue():getValue() then
                                return 1
                            elseif cards1[i]:getValue():getValue() < cards2[ii]:getValue():getValue() then
                                return -1
                            else
                                break -- Drilling ist gleich. Weitere Prüfung unötig
                            end
                        end
                    end
                end
            end
            
            -- Drilling ist gleich
            local rest_cards1 = {}
            local rest_cards2 = {}
            for i=1, 5 do
                if self:getNumberOfCardsOfSameValue(cards1, cards1[i]:getValue()) ~= 3 then
                    table.insert(rest_cards1, cards1[i])
                end
                if self:getNumberOfCardsOfSameValue(cards2, cards2[i]:getValue()) ~= 3 then
                    table.insert(rest_cards2, cards2[i])
                end
            end
            -- Große Karten an den Anfang
            table.sort(rest_cards1, function(a, b) return a > b end)
            table.sort(rest_cards2, function(a, b) return a > b end)
            for i=1, 2 do
                if rest_cards1[i]:getValue():getValue() > rest_cards2[i]:getValue():getValue() then
                    return 1
                elseif rest_cards1[i]:getValue():getValue() < rest_cards2[i]:getValue():getValue() then
                    return -1
                end
            end
            return 0
        elseif spade1.getSpadeType() == PokerConstants.SPADE_STRAIGHT then
            if highest_value_spade1 > highest_value_spade2 then
                return 1
            elseif highest_value_spade1 < highest_value_spade2 then
                return -1
            else
                return 0
            end
        elseif spade1.getSpadeType() == PokerConstants.SPADE_FLUSH then
            for i=1, 5 do
                if cards1[i]:getValue():getValue() > cards2cards1[i]:getValue():getValue() then
                    return 1
                elseif cards1[i]:getValue():getValue() < cards2cards1[i]:getValue():getValue() then
                    return -1
                end
            end
            return 0
        elseif spade1.getSpadeType() == PokerConstants.SPADE_FULL_HOUSE then
            
        elseif spade1.getSpadeType() == PokerConstants.SPADE_FOUR_OF_A_KIND then
            for i=1, 5 do
                if self:getNumberOfCardsOfSameValue(cards1, cards1[i]:getValue()) == 4 then
                    for ii=1, 5 do
                        if self:getNumberOfCardsOfSameValue(cards2, cards2[ii]:getValue()) == 4 then
                            if cards1[i]:getValue():getValue() > cards2[ii]:getValue():getValue() then
                                return 1
                            elseif cards1[i]:getValue():getValue() < cards2[ii]:getValue():getValue() then
                                return -1
                            else
                                break -- Vierling ist gleich. Weitere Prüfung unötig
                            end
                        end
                    end
                end
            end
            
            -- Vierling ist gleich
            local rest_cards1 = {}
            local rest_cards2 = {}
            for i=1, 5 do
                if self:getNumberOfCardsOfSameValue(cards1, cards1[i]:getValue()) ~= 4 then
                    table.insert(rest_cards1, cards1[i])
                end
                if self:getNumberOfCardsOfSameValue(cards2, cards2[i]:getValue()) ~= 4 then
                    table.insert(rest_cards2, cards2[i])
                end
            end
            -- Sortieren entfällt, da nur eine Karte
            if rest_cards1[1]:getValue():getValue() > rest_cards2[1]:getValue():getValue() then
                return 1
            elseif rest_cards1[1]:getValue():getValue() < rest_cards2[1]:getValue():getValue() then
                return -1
            else
                return 0
            end
            
        elseif spade1.getSpadeType() == PokerConstants.SPADE_STRAIGHT_FLUSH then
            if highest_value_spade1 > highest_value_spade2 then
                return 1
            elseif highest_value_spade1 < highest_value_spade2 then
                return -1
            else
                return 0
            end
        elseif spade1.getSpadeType() == PokerConstants.SPADE_ROYAL_FLUSH then
            -- Royal Flush => immer Split Pot, alle 4 Möglichen gleich gut
            return 0
        end
end
