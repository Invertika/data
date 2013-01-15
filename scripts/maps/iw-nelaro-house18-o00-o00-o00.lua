----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------


require "scripts/lua/npclib"
require "scripts/libs/invertika"


local function hobel_talk(npc, ch)
    local queststring = "nelaro_water_quest"
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)
    
    if quest_var == 0 then
        npc_message(npc, ch, "...")
    elseif quest_var == 1 then
        npc_message(npc, ch, "Irac hat dich geschickt?")
        while true do 
            local v =  npc_choice(npc, ch, 
                        "Ja", 
                        "Nein")
            if v == 1 then
                npc_message(npc, ch, "Gut, der ist einer der wenigen, denen ich vertraue.")
                npc_message(npc, ch, "Der einzigste Wasserlieferant der Stadt ist die Familie in der Mitte.")
                npc_message(npc, ch, "Sie können daher die Preise bestimmen, leider.")
                npc_message(npc, ch, "Ich habe Onurn gesagt, dass er die belauschen soll.")
                npc_message(npc, ch, "Kannst du ihn für mich nach dem Wetter fragen?")
                while true do
                    local x = npc_choice(npc, ch,
                      "Ja",
                      "Nein")
                    if x == 1 then
                        npc_message(npc, ch, "Komme danach so schnell wie es geht zurück.")
                        --Set Quest
                        invertika.set_quest_status(ch, queststring, 2)
                        break
                    else
                        npc_message(npc, ch, "Auf Wiedersehen.")
                        break
                    end
                end
                break
            else
                npc_message(npc, ch, "...")
                break
            end
        end
    elseif quest_var == 2 then
        npc_message(npc, ch, "Was stehst du hier so faul rum? Du sollst zum Onurn gehen!")
    elseif quest_var == 3 then
        npc_message(npc, ch, "Was sagte er?")
        while true do
            local c = npc_choice(npc, ch,
                              "Dass die in der Mitte das Wasser aus dem Norden von einem Lieferanten bekommen.",
                              "Dass mit denen alles in Ordnung sei.")
            if c == 1 then
                npc_message(npc, ch, "Ok, das hatte ich bereits vermutet.")
                npc_message(npc, ch, "Kannst du rüber zum Wüstenlager, und dort 5 Wasserflaschen kaufen?")
                while true do
                    local a = npc_choice(npc, ch,
                                      "Ja",
                                      "Nein")
                    if a == 1 then
                        npc_message(npc, ch, "OK, ich gebe dir Geld.")
                        npc_message(npc, ch, "Komme nicht ohne Wasser wieder!")
                        invertika.add_money(ch, 200)
                        --Set Quest
                        invertika.set_quest_status(ch, queststring, 4)
                        break
                    elseif a == 2 then
                        npc_message(npc, ch, "Blöd.")
                        break
                    end
                end
                break
            elseif c == 2 then
                npc_message(npc, ch, "Hmm.")
                npc_message(npc, ch, "RAUS.")
                break
            end
        end
    elseif quest_var == 4 and chr_inv_count(ch, 30037) == 0 then
        npc_message(npc, ch, "Wasser!")
    elseif quest_var == 4 or chr_inv_count(ch, 30037) >= 5 then
        npc_message(npc, ch, "Danke")
        npc_message(npc, ch, "Ein kleines Dankeschön.")
        invertika.add_money(ch, 500)
        invertika.add_items(ch, 30037, -5, "Wasserflasche")
        --Set Quest
        invertika.set_quest_status(ch, queststring, 5)
    elseif quest_var == 5 then
        npc_message(npc, ch, "Hallo")
    end
end

atinit(function()
    hobel = npc_create("Hobel", 60, GENDER_UNSPECIFIED, 33 * TILESIZE + 16, 36 * TILESIZE + 16, hobel_talk, nil)
    invertika.create_npc_talk_random(hobel,
      {"Hilfe! Hilfe! Ein Geist!!",
      "Ich hab ein Brett vorm Kopf.",
      "Kann man das trinken oder ist das Strom?"})
end)
