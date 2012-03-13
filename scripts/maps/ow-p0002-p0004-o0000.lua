----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2011 The Invertika Development Team                          --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/sign"
require "scripts/libs/invertika"
require "scripts/libs/nethek"

require "scripts/libs/warp"

atinit(function()
    create_inter_map_warp_trigger(88, 98, 86, 76) --- Intermap warp

    nethek.create_netheksaeule(127 * TILESIZE, 113 * TILESIZE + 16) ---Netheksäule
    
    sign_entrance = "Lauria"
    sign.create_sign(184, 92, sign_entrance) --- Schild Ortseingang
    sign.create_sign(99, 61, sign_entrance) --- Schild Ortseingang
    sign.create_sign(49, 133, sign_entrance) --- Schild Ortseingang
    
    mana.trigger_create(34 * TILESIZE, 99 * TILESIZE, 1 * TILESIZE, 1 * TILESIZE, "key_trigger", 0, true)
    
    create_npc("Robert", 64, 64 * TILESIZE, 117 * TILESIZE + 16, robert_talk, nil) --- Robert
    create_npc("Issen", 146, 139 * TILESIZE + 16, 113 * TILESIZE + 16, issen_talk, nil) --- Issen
end)

function robert_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Ich bin Steuerberater.",
                                                     "Paragraph 16, königliches Steuergesetz: Milch wird mit 4% des normalen Steuersatzes versteuert.",
                                                     "Das schlimme an Steuergesetzen ist, dass sie keinen Sinn machen...",
                                                     "Ich glaube meine Beratung wird mit 7% versteuert."))
    do_npc_close(npc, ch)
end

function issen_talk(npc, ch)
    local queststring = "lauria_losed_key_quest"
    local queststring_time = "lauria_losed_key_quest_time"
    
    --Init Quests
    invertika.inti_quest_status(ch, queststring)
    invertika.inti_quest_status(ch, queststring_time)
    
    --Get Quests
    local quest_var = invertika.get_quest_status(ch, queststring)
    local quest_var_time = invertika.get_quest_status(ch, queststring_time)
    
    if quest_var == 0 then
        do_message(npc, ch, "Boah, wie das nervt.")
        do_message(npc, ch, "ich habe jetzt schon zum vierten mal in dieser Woche meinen Schlüssel irgendwo verloren.")
        while true do
            do_message(npc, ch, "Hilfst du mir ihn zu suchen?")
            local v = do_choice(npc, ch, 
              "Nein",
              "Ja")
            if v == 1 then
                do_message(npc, ch, "ok, dann suche ich alleine")
                break
            elseif v == 2 then
                do_message(npc, ch, "Ich danke dir.")
                do_message(npc, ch, "Beeile dich bitte, ich habe noch die Heizung in der Wohnung eingeschaltet.")
                do_message(npc, ch, "Ich will nicht, dass es zu heiß da drinne wird.")
                do_message(npc, ch, "In etwa 2 Minuten dürfte dies der Fall sein.")
                
                --Set Quests
                invertika.set_quest_status(ch, queststring, 1)
                invertika.set_quest_status(ch, queststring_time, datetime.get_current_time())
                break
            end
        end
    end
    
    if quest_var == 1 then
        local rest_time = datatime.get_curent_time() - queststring_time
        if rest_time >= 0 and mana.chr_inv_count(ch, 40052) > 0 then
            do_message(npc, ch, "Danke")
            mana.chr_inv_change(ch, 40052, -1)
            mana.chr_money_change(chr, 300)
            --Set Quests
            invertika.set_quest_status(ch, queststring, 2)
        elseif rest_time >= 0 and mana.chr_inv_count(ch, 40052) == 0 then
            do_message(npc, ch, string.format("Du hast noch %d Zeit.", rest_time))
        elseif rest_time < 0 and mana.chr_inv_count(ch, 40052) == 0 then
            do_message(npc, ch, "Jetzt brauche ich den Schlüssel auch nicht mehr, bei der Hitze, die da drinne sein wird.")
        elseif rest_time < 0 and mana.chr_inv_count(ch, 40052) > 0 then
            mana.being_damage(ch, 50, 50, 1, DAMAGE_PHYSICAL, ELEMENT_NEUTRAL)
            mana.chatmessage(ch, "Issen hat dich geohrfeigt.")
            do_message(npc, ch, "Sei nächstes mal schneller.")
            mana.chr_inv_change(ch, 40052, -1)
            
            --Set Quests
            invertika.set_quest_status(ch, queststring, 2)
        end
    end

    if quest_var == 2 then
        do_message(npc, ch, "blubb")
    end

    do_npc_close(npc, ch)
end

function key_trigger(ch, id)
    if mana.being_type(ch) ~= TYPE_MONSTER then
        local queststring = "lauria_losed_key_quest"
        --Init Quest
        invertika.inti_quest_status(ch, queststring)
        --Get Quests
        local quest_var = invertika.get_quest_status(ch, queststring)
        
        if quest_var == 1 then
            if (mana.chr_inv_count(ch, 40052) == 0) then
                mana.chr_inv_change(ch, 40052, 1)
            end
        end
    end
end