-- Radius der Explosion
DAMAGE_RADIUS = 15 * TILESIZE
-- Faktor mit dem der Schaden nach einer bestimmten Entfernung bestimmt:
-- damage =  damaga * pow(FACTOR_DECREASE, distance)
DAMAGE_FACTOR_DECREASE = 0.99
-- Schaden der im Zentrum der Explosion entsteht
DAMAGE_DAMAGE = 50000
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
    local affected_beings = get_beings_in_circle(my_x, my_y, DAMAGE_RADIUS)
    -- being_say(my_user, table.getn(affected_beings))
    for nr, being in pairs(affected_beings) do
        local distance = get_distance(my_x, my_y, posX(being), posY(being))
        local damage = DAMAGE_DAMAGE * math.pow(DAMAGE_FACTOR_DECREASE, distance)
        -- being_say(being, string.format("Name: %s, Distanz: %s, Damage: %s",
        --                being_get_name(being), distance, damage))
        being_damage(being, damage, DAMAGE_DELTA, DAMAGE_ACCURACY, DAMAGE_PHYSICAL, ELEMENT_FIRE)
    end
    effect_create(151, my_x, my_y)
end

function use(user)
    -- being_say(user, "Debug 1")
    x = posX(user)
    y = posY(user)
    -- chr_set_quest(user, "debug", 1)
    -- being_say(user, get_quest_var(user, "debug"))
    schedule_in(5, kaboom(user, x, y))
end
