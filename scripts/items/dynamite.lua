-- Radius der Explosion
DAMAGE_RADIUS = 100
-- Faktor mit dem der Schaden nach einer bestimmten Entfernung bestimmt:
-- damage =  damaga * pow(FACTOR_DECREASE, distance)
DAMAGE_FACTOR_DECREASE = 0.99
-- Schaden der im Zentrum der Explosion entsteht
DAMAGE_DAMAGE = 1000
-- Andere
DAMAGE_DELTA = 30
DAMAGE_ACCURACY = 0.90 -- ACCURACY Angabe richtig?

function use(user)
    -- Feuerwerk explodiert bis jetzt lediglich, spielt aber noch keinen Feuerwerkseffekt ab
    local x = mana.posX(user)
    local y = mana.posY(user)
    affected_beings = mana.get_beings_in_circle(x, y, RADIUS)
    for being in affected_beings do
        local distance = get_distance(x, y, mana.posX(being), mana.posY(being))
        local damage = DAMAGE_DAMAGE * math.pow(DAMAGE_FACTOR_DECREASE, distance)
        mana.being_damage(being, damage, DAMAGE_DELTA, DAMAGE_ACCURACY, 0, 1)
    end
    mana.effect_create(151, x, y)
end

function get_distance(x1, y1, x2, y2)
    -- Satz des Pythargoras: a*a + b*b = c*c
    -- (x2 - x1)^2 + (y2 - y1)^2 = distance^2
    -- sqrt((x2 - x1)^2 + (y2 - y1)^2) = distance
    return math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2))
end
