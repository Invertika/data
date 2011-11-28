function use(user)
    -- Feuerwerk explodiert bis jetzt lediglich, spielt aber noch keinen Feuerwerkseffekt ab
    local x = mana.posX(user)
    local y = mana.posY(user)
    mana.effect_create(151, x, y)
end
