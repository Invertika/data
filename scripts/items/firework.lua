function use(user)
    local x = mana.posX(user)
    local y = mana.posY(user)
    for c = 0, 25 do
        schedule_in (c, function()
            mana.effect_create(c, x + math.random(-200, 200), y + math.random(-200, 200))
        end)
    end
end
