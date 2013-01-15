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
require "scripts/libs/invertika"


local function veritas_talk(npc, ch)
    npc_message(npc, ch, "Sei gegrüßt Reisender. Bist du gekommen um eine grausame Wahrheit des Lebens zu erfahren?")
    
        while true do
            local v = npc_choice(npc, ch, "Ja.", "Nein.")
            if v == 1 then
                npc_message(npc, ch, "Wie du willst. Doch eine solche Wahrheit ist nicht umsonst. Bist du bereit 15000 Aki dafür zu zahlen?")
                while true do
                    local vMoney = npc_choice(npc, ch, "Ja.", "Nein.")
                    
                    if vMoney == 1 then
                        local PlayerMoney=chr_money(ch)
                        if PlayerMoney >= 15000 then
                            invertika.add_money(ch, -15000)
                        
                            npc_message(npc, ch, "Ausgezeichnet. Ich hoffe du bist vorbereitet. Ich lese nun eine grausame Wahrheit des Lebens aus diesem Buch.")
                        
                            effect_create(5, 37 * TILESIZE, 19 * TILESIZE)
                            effect_create(5, 44 * TILESIZE, 19 * TILESIZE)
                        
                            npc_message(npc, ch, invertika.get_random_element(
                              "Es gibt keinen Gott!",
                              "Genieße dein Leben, denn nach dem Tod ist es vorbei!",
                              "Nach dem Tod kommt nur noch Dunkelheit!",
                              "Alles ist vergänglich!",
                              "Jeder vergangene Moment könnte der letzte sein!",
                              "Der Tod ist nur einen Fingerzeig entfernt!",
                              "Moral ist nichts weiter als das Klammern an ein universelles Prinzip!",
                              "Nichts wird so sein wie es war!"))
                                                                             
                            npc_message(npc, ch, "Ich hoffe diese Wahrheit konnte dich inspirieren.")
                                                                         
                            effect_create(6, 37 * TILESIZE, 19 * TILESIZE)
                            effect_create(6, 44 * TILESIZE, 19 * TILESIZE)
                        
                            monster_create(31, 36 * TILESIZE, 22 * TILESIZE)
                            monster_create(31, 45 * TILESIZE, 22 * TILESIZE)
                        
                            monster_create(31, 39 * TILESIZE, 18 * TILESIZE)
                            monster_create(31, 42 * TILESIZE, 18 * TILESIZE)
                        
                            monster_create(31, 39 * TILESIZE, 29 * TILESIZE)
                            monster_create(31, 42 * TILESIZE, 29 * TILESIZE)
                        else
                            npc_message(npc, ch, "Du solltest im Besitz der entsprechenden Geldmenge sein. So wirst du die Wahrheit nicht erfahren.")
                        end
                        
                        break
                    elseif vMoney == 2 then
                        npc_message(npc, ch, invertika.get_random_element(
                          "Gut dann gehe deinen Weg...",
                          "Vielleicht ist es besser so...",
                          "So sei es..."))
                        break
                    end
                end
                
                break
            elseif v == 2 then
                npc_message(npc, ch, invertika.get_random_element(
                  "Gut dann gehe deinen Weg...",
                  "Vielleicht ist es besser so...",
                  "So sei es..."))
                break
            end
        end
        
end


atinit(function()
     npc_create("Veritas", 143, GENDER_UNSPECIFIED, 41 * TILESIZE, 20 * TILESIZE + 16, veritas_talk, nil) --- Veritas 
end)
