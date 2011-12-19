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

atinit(function()
    --TODO Change Sprite ID
    hobel = create_npc("Hobel", 2, 33 * TILESIZE + 16, 36 * TILESIZE + 16, hobel_talk, nil)
    invertika.create_npc_talk_random(hobel,
      {"Hilfe! Hilfe! Ein Geist!!",
      "Ich hab ein Brett vorm Kopf.",
      "Kann man das trinken oder ist das Strom?"})
end)

function hobel_talk(npc, ch)
    local queststring = "nelaro_water_quest"
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)
    
    if quest_var == 0 then
        do_message(npc, ch, "...")
    elseif quest_var == 1 then
        do_message(npc, ch, "Irac hat dich geschickt?")
        local v =  do_choice(npc, ch, 
                    "Ja", 
                    "Nein")
        if v == 1 then
            do_message(npc, ch, "Gut, der ist einer der wenigen, denen ich vertraue.")
            do_message(npc, ch, "Der einzigste Wasserlieferant der Stadt ist die Familie in der Mitte.")
            do_message(npc, ch, "Sie können daher die Preise bestimmen, leider.")
            do_message(npc, ch, "Ich habe Onurn gesagt, dass er die belauschen soll.")
            do_message(npc, ch, "Kannst du ihn für mich nach dem Wetter fragen?")
            local x = do_choice(npc, ch,
              "Ja",
              "Nein")
            if x == 1 then
                do_message(npc, ch, "Komme danach so schnell wie es geht zurück.")
                --Set Quest
                invertika.chr_set_quest(ch, queststring, 2)
            else
                do_message(npc, ch, "Auf Wiedersehen.")
                end
        else
            do_message(npc, ch, "...")
        end
    elseif quest_var == 2 then
        do_message(npc, ch, "Was stehst du hier so faul rum? Du sollst zum Onurn gehen!")
    elseif quest_var == 3 then
        do_message(npc, ch, "Was sagte er?")
        local c = do_choice(npc, ch,
                              "Dass die in der Mitte das Wasser aus dem Norden von einem Lieferanten bekommen.",
                              "Dass mit denen alles in Ordnung sei.")
        if c == 1 then
            do_message(npc, ch, "Ok, das hatte ich bereits vermutet.")
            do_message(npc, ch, "Kannst du rüber zum Wüstenlager, und dort 5 Wasserflaschen kaufen?")
            local a = do_choice(npc, ch,
                                  "Ja",
                                  "Nein")
            if a == 1 then
                do_message(npc, ch, "OK, ich gebe dir Geld.")
                do_message(npc, ch, "Komme nicht ohne Wasser wieder!")
                invertika.add_money(ch, 200)
                --Set Quest
                invertika.chr_set_quest(ch, queststring, 4)
            elseif a == 2 then
                do_message(npc, ch, "Blöd.")
            end
        elseif c == 2 then
            do_message(npc, ch, "Hmm.")
            do_message(npc, ch, "RAUS.")
        end
    elseif quest_var == 4 and mana.chr_inv_count(ch, 30037) == 0 then
        do_message(npc, ch, "Wasser!")
    elseif quest_var == 4 or mana.chr_inv_count(ch, 30037) >= 5 then
        do_message(npc, ch, "Danke")
        do_message(npc, ch, "Eine kleines Dankeschön.")
        invertika.add_money(ch, 500)
        invertika.add_items(ch, 30037, -5, "Wasserflasche")
        --Set Quest
        invertika.chr_set_quest(ch, queststring, 5)
    elseif quest_var == 5 then
        do_message(npc, ch, "Hallo")
    end
    do_npc_close(npc, ch)
end
