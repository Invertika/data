-- Radius der Explosion
DAMAGE_RADIUS = 7 * TILESIZE
-- Faktor mit dem der Schaden nach einer bestimmten Entfernung bestimmt:
-- damage =  damaga * pow(FACTOR_DECREASE, distance)
DAMAGE_FACTOR_DECREASE = 0.99
-- Schaden der im Zentrum der Explosion entsteht
DAMAGE_DAMAGE = 1000
-- Andere
DAMAGE_DELTA = 30
DAMAGE_ACCURACY = 10000 --

function get_distance(x1, y1, x2, y2)
    -- Satz des Pythargoras: a*a + b*b = c*c
    -- (x2 - x1)^2 + (y2 - y1)^2 = distance^2
    -- sqrt((x2 - x1)^2 + (y2 - y1)^2) = distance
    return math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2))
end

function kaboom(my_user, my_x, my_y)
    local affected_beings = mana.get_beings_in_circle(my_x, my_y, DAMAGE_RADIUS)
    mana.being_say(my_user, table.getn(affected_beings))
    mana.being_say(my_user, "Debug 2")
    for nr, being in pairs(affected_beings) do
        mana.being_say(my_user, "Debug 3")
        local distance = get_distance(my_x, my_y, mana.posX(being), mana.posY(being))
        local damage = DAMAGE_DAMAGE * math.pow(DAMAGE_FACTOR_DECREASE, distance)
        -- mana.being_say(being, string.format("Name: %s, Distanz: %s, Damage: %s",
        --                mana.being_get_name(being), distance, damage))
        mana.being_damage(being, damage, DAMAGE_DELTA, DAMAGE_ACCURACY, DAMAGE_PHYSICAL, ELEMENT_FIRE)
    end
    mana.effect_create(151, my_x, my_y)
end

function use(user)
    -- mana.being_say(user, "Debug 1")
    x = mana.posX(user)
    y = mana.posY(user)
    -- mana.chr_set_quest(user, "debug", 1)
    -- mana.being_say(user, get_quest_var(user, "debug"))
    schedule_in(5, kaboom(user, x, y))
end
