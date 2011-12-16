module("guard", package.seeall)

require "scripts/lua/npclib"
require "scripts/libs/invertika"

-- reaction_radius -> Radius in dem die Wache Beings warnimmt
-- fight_radius -> Schlagreichweite
-- old_x -> Anfangsposition - X
-- old_x -> Anfangsposition - Y
-- max_stray -> Maximale Entfernung vom Startpunkt
-- filter(being) -> Funktion, die true returnt wenn das Being ein Feind ist
-- damage -> Schaden der zugefügt werden soll
-- damage_delta -> Streuung des Schadens
-- damage_accuracy -> Trefferquote
-- damage_type -> Schadenstyp
guards = {}

function create_guard(npc, filter, reaction_radius, fight_radius, max_stray,
                      damage, damage_delta, damage_accuracy, damage_type,
                      update_delay)
    guards[npc] = {}
    guards[npc].old_x = mana.posX(npc)
    guards[npc].old_y = mana.posY(npc)
    guards[npc].max_stray = max_stray
    guards[npc].filter = filter
    guards[npc].reaction_radius = reaction_radius
    guards[npc].fight_radius = fight_radius
    guards[npc].damage = damage
    guards[npc].damage_delta = damage_delta
    guards[npc].damage_accuracy = damage_accuracy
    guards[npc].damage_type = damage_type
    schedule_every(update_delay, function() update(npc) end)
end

function create_player_hunter(npc, reaction_radius, fight_radius, max_stray,
                              damage, damage_delta, damage_accuracy,
                              damage_type, update_delay)
    create_guard(npc, function(b)
                   return mana.being_type(b) == TYPE_CHARACTER
                 end, reaction_radius, fight_radius, max_stray, damage,
                 damage_delta, damage_accuracy, damage_type, update_delay)
end

function create_monster_hunter(npc, reaction_radius, fight_radius, max_stray,
                              damage, damage_delta, damage_accuracy,
                              damage_type, update_delay)
    create_guard(npc, function(b)
                   return mana.being_type(b) == TYPE_Monster
                 end, reaction_radius, fight_radius, max_stray, damage,
                 damage_delta, damage_accuracy, damage_type, update_delay)
end

function update(npc)
    local x, y = mana.posX(npc), mana.posY(npc)
    local beings = mana.get_beings_in_circle(x, y, guards[npc].reaction_radius)

    local closestX, closestY, closestBeing = -1
    for _, b in pairs(beings) do
        if (closestX == -1 or
                closestDistance > invertika.get_distance(x, y,
                                                mana.posX(b), mana.posY(b))) and
                guards[npc].filter(b) then
            closestX = mana.posX(b)
            closestY = mana.posY(b)
            closestDistance = invertika.get_distance(x, y, closestX, closestY)
            closestBeing = b
        end
    end
    if closestX ~= -1 then
        mana.being_walk(npc, closestX, closestY, 6)
        if closestDistance <= guards[npc].fight_radius then
            mana.being_damage(b, guards[npc].damage, guards[npc].damage_delta,
                        guards[npc].damage_accuracy, guards[npc].damage_type)
        end
    elseif x ~= guards[npc].old_x or y ~= guards[npc].old_y or 
      invertika.get_distance(x, y, guards[npc].old_x, guards[npc].old_y) then
        mana.being_walk(npc, guards[npc].old_x, guards[npc].old_y, 6)
    end
end
