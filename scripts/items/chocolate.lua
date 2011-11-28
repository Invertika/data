require "scripts/libs/invertika"

function use(ch)
    local quest_string = "character_chocolate_count"
    invertika.init_quest_status(ch, quest_string)
    
    local count = invertika.get_quest_status(ch, quest_string) + 1
    invertika.set_quest_status(ch, quest_string, count) 

    if count >=15 then
        mana.being_say(ch, invertika.get_random_element(
          "Und wieder tausende Kilokalorien.",
          "Mist, ich wollte doch nicht mehr so viel essen!",
          "Schon wieder Schokolade? Ich will Gurken!",
          "Schokolade, lecker - *mampf*",
          "Schokolade macht glücklich, wie traurig.",
          "Noch drei Stück und ich kann meine Diät vergessen..."))
        invertika.set_quest_status(ch, quest_string, 0)
    end
end
