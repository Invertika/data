-- Modul Postmen

module("postmen", package.seeall)

require "scripts/lua/npclib"
require "scripts/libs/invertika"

postman = {}
GIFTS = {{id=40005, name="Madenschleim"}, {id=40004, name="Skorpionstachel"}, {id=40006, name="Casino Münzen"}}

function create_postman_npc(id, name, sprite, x, y, possible_designations, itemid)
    new_postman = create_npc("Postmann_" .. name, sprite, x, y, postman_talk, nil)
    postman[new_postman] = {id=id, name=name, designations=possible_designations, item=itemid}
end

--- Prüft was für einen Auftrag der Spieler von dem NPC hat.
-- @param npc Der Postmann NPC
-- @param ch Der Spieler
-- @return Das Ziel, dass von dem npc vergeben wurde.
function get_order_designation(npc, ch)
    return invertika.get_quest_status_string(ch, string.format("%s_order_designation", postman[npc].id))
end

--- Gibt das Ziel eines Auftrag der durch den Postboten mit einer id vergeben wurde
-- @param ch Der Spieler
-- @param id Id des Auftraggebers
-- @return Id des Ziels das durch den Auftraggeber id vergeben wurde
function get_designation_by_startid(ch, id)
    return invertika.get_quest_status_string(ch, string.format("%s_order_designation", id))
end

--- Prüft ob bei dem NPC ein Auftrag erfüllt werden kann.
-- @param npc Der Postmann NPC
-- @param ch Der Spieler
-- @return (true, npc) wenn ein Auftrag erfüllt werden kann, false wenn nicht.
function can_do_order(npc, ch)
    for i, v in pairs(postman) do
        if get_order_designation(npc, ch) == postman[npc].id then
            return true, i
        end
    end
    return false
end

--- Prüft ob ein Paket für den NPC im Inventar ist.
-- @param npc Der Postmann NPC
-- @param ch Der Spieler
-- @return true wenn ja
function has_package_for_npc(npc, ch)
    return mana.chr_inv_count(ch, postman[npc].item) > 0
end

--- Sucht ein neues Ziel aus.
-- @param npc Der Postmann NPC
-- @param ch Der Spieler
-- @return Id des neuen Postbotens
function get_new_designation(npc)
    return invertika.get_random_element(postman[npc].designations).id
end

--- Gibt den Namen für die Id zurück.
-- @param id Die Id.
-- @return den lesbaren Namen für die Id
function get_name_by_id(id)
    for i, v in pairs(postman) do
        if v.id == id then
            return v.name
        end
    end
end


--- Gibt die Distanz vom Start zum Ziel zurück.
-- @param ch Der Spieler
-- @param npc_start Auftraggeber NPC
-- @return Distanz vom Start des Spielers zum Ziel
function get_distance(ch, npc_start)
    local designation = get_order_designation(npc, ch)
    for i, v in pairs(postman[npc_start].designations) do
        if v.id == designation then
            return v.distance
        end
    end
    return nil
end

--- Gibt die ItemId zurück die von dem Ziel erwartet wird.
-- @param designation Die Id des Ziels
-- @return ItemId die vom Ziel erwartet wird
function get_desired_itemid(designation)
    for i, v in pairs(postman) do
        if v.id == designation then
            return v.item
        end
    end
end

--- Talk Funktion
function postman_talk(npc, ch)
    do_message(npc, ch, "Hallo.")
    -- Quest-Stati initialisieren
    invertika.init_quest_status_string(ch, string.format("%s_order_designation", postman[npc].id))
    invertika.init_quest_status(ch, string.format("%s_order_done", postman[npc].id))
    
    local designation = get_order_designation(npc, ch)
    
    do_message(npc, ch, "##")
    if has_package_for_npc(npc, ch) then
        do_message(npc, ch, "1")
        local has_order, start_npc = can_do_order(npc, ch)
        if has_order then
            do_message(npc, ch, "2")
            do_message(npc, ch, invertika.get_random_element("Schon wieder ein Paket für mich? Gib mal her!",
              string.format("Ein Paket von der Poststelle %s... Das kommt auf diesen Stapel.", postman[start_npc].name)))
            do_message(npc, ch, "Paket abgeben?")
            while true do
                local v = do_choice(npc, ch, "Ja.", "Nein.")
                if v == 1 then
                    do_message(string.format("%s_order_done", postman[start_npc].id))
                    invertika.add_items(ch, postman[npc].item, -1, string.format("Paket für Poststelle %s", postman[npc].name))
                    invertika.set_quest_status(ch, string.format("%s_order_done", postman[start_npc].id), 1)
                    do_message(npc, ch, "Danke.")
                    break
                elseif v == 2 then
                    break
                end
            end
        end
    elseif designation ~= "" then
        do_message(npc, ch, "3")
        if invertika.get_quest_status(ch, string.format("%s_order_done")) == 0 then
            do_message(npc, ch, string.format("Du musst noch das Paket bei der Poststelle %s abgeben", get_name_by_id(designation)))
        else
            invertika.set_quest_status(ch, string.format("%s_order_done"), 0)
            do_message(npc, ch, "Danke, dass du das Paket da abgegeben hast.")
            local gift = invertika.get_random_element(GIFTS)
            local number = get_distance(ch, npc)
            do_message(npc, ch, "Nimm dies als Dank.")
            invertika.add_items(ch, gift.id, number, gift.name)
        end
    else
        do_message(npc, ch, "4")
        local order_designation = get_new_designation(npc)
        do_message(npc, ch, "5")
        do_message(npc, ch, string.format("Würdest du für mich ein Paket zur Poststelle %s bringen?", get_name_by_id(order_designation)))
        while true do
            local v = do_choice(npc, ch, "Ja.", "Nein.")
            if v == 1 then
                invertika.set_quest_status_string(ch, string.format("%s_order_designation", postman[npc].id), order_designation)
                invertika.add_items(ch, get_desired_itemid(order_designation), 1, string.format("Paket für Poststelle %s", get_name_by_id(order_designation)))
                do_message(npc, ch, "Danke.")
                break
            elseif v == 2 then
                break
            end
        end
    end
    do_npc_close(npc, ch)
end

