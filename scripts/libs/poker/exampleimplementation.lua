require("pokerdealer")

poker_npc = create_npc(...)

dealer = nil

function poker_npc_talk(npc, ch)
    if dealer == nil then
        dealer = PokerDealer:new(40)
    end
    if dealer:playerIsInGame(ch) then
        if self:playerIsOnTurn(ch) then
            local possibilities = 
        end
    end
end
