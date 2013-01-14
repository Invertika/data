function use(user)
    -- Feuerwerk explodiert bis jetzt lediglich, spielt aber noch keinen Feuerwerkseffekt ab
    local x = posX(user)
    local y = posY(user)
    effect_create(151, x, y)
end
