require("pokerdealer")
require("pokerconstants")

poker_npc = create_npc(...)

dealer = nil

function poker_npc_talk(npc, ch)
    if dealer == nil then
        dealer = PokerDealer:new(40)
    end
    if dealer.game:playerIsInGame(ch) then
        if dealer.game:playerIsOnTurn(ch) then
            local possibilities =  dealer.game:getPossibilities(ch)
            for i, possibility in ipairs(possibilities) do
                local choices = {}
                if possibility == PokerConstants.POSSIBILITY_FOLD then
                    table.insert(choices, "Karten abgeben - FOLD")
                elseif possibility == PokerConstants.POSSIBILITY_CALL then
                    table.insert(choices, "Mitgehen - CALL")
                elseif possibility == PokerConstants.POSSIBILITY_RAISE then
                    table.insert(choices, "Erhöhen - RAISE")
                end
            end
            while true do
                local v = do_choice(choices)
                if (v >= 1) or (v <= table.getn(choices)) then
                    if possibilities[v] == PokerConstants.POSSIBILITY_FOLD then
                        dealer.game:playerActionFold(ch)
                    elseif possibilities[v] == PokerConstants.POSSIBILITY_CALL then
                        dealer.game:playerActionCall(ch)
                    elseif possibilities[v] == PokerConstants.POSSIBILITY_RAISE then
                        local min = dealer.game:getMoneyPlayerHasToRaise(ch)
                        local max = dealer.game:getMaxMoneyPlayerCanRaise(ch)
                        local amount = do_ask_integer(npc, ch, min, max, min)
                        dealer.game:playerActionRaise(ch, amount)
                    end
                    break
                end
            end
        end
    end
end
