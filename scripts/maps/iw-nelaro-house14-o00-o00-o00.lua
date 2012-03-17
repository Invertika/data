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
    create_npc("Vodel", 57, 31 * TILESIZE + 16, 37 * TILESIZE + 16, vodel_talk, nil)
end)

function vodel_talk(npc, ch)
    local queststring_vodel = "nelaro_vodel_quests"
    local queststring_water = "nelaro_water_quest"
    --Init Quests
    invertika.init_quest_status(ch, queststring_vodel)
    invertika.init_quest_status(ch, queststring_water)
    --Get Quests
    local quest_var_vodel = invertika.get_quest_status(ch, queststring_vodel)
    local quest_var_water = invertika.get_quest_status(ch, queststring_water)
    
    if quest_var_water == 0 then
        do_message(npc, ch, invertika.get_random_element(
          "Wasser..",
          "Mein Mund besteht aus Staub.",
          "Ich verdurste." ))
    end
    
    if quest_var_vodel == 3 then
        do_message(npc, ch, "Hast du alles erledigt, was dich noch blockierte?")
        while true do
            local x = do_choice(npc, ch, "ja",
              "Nein")
            if x == 1 then
                do_message(npc, ch, "Gut")
                --Set Quest
                invertika.set_quest_status(ch, queststring_vodel, 4) --Es wurde mit Vodel geredet, die Quest angenommen, und die erste Runde wird gestartet.
                break
            elseif x == 2 then
                do_message(npc, ch, "Lass dir ruig soviel Zeit, wie du brauchst.")
                break
            end
        end
    end
    
    if quest_var_vodel == 5 then
        local curr_time = os.date("*t")
        local next_round1_try = os.time{year=d.year, month=d.month, day=15,
                          hour=0, min=00, sec=0}
        if os.difftime(os.time(), start) > 0 then
            --Set Quest
            invertika.set_quest_status(ch, queststring_vodel, 4) --Es wurde mit Vodel geredet, die Quest angenommen, und die erste Runde wird gestartet.
            do_message(npc, ch, "Du konntest Lange genug über die Frage grübeln, du darfst es erneut versuchen.")
        else
            do_message(npc, ch, "Wiege dich in Geduld.")
        end
    end
    
    if quest_var_water >= 5 and quest_var_vodel == 0 or quest_var_water >= 5 and quest_var_vodel == 2 then
    
        do_message(npc, ch, "ahh, danke fürs Wasser.")
        do_message(npc, ch, "...")
        do_message(npc, ch, "...")
        do_message(npc, ch, "Ahrg.")
        do_message(npc, ch, "Wie unhöflich von mir.")
        do_message(npc, ch, "Wenn ich mich vorstellen darf, mein Name ist Vodel.")
        do_message(npc, ch, "Ich gehöre zu einem der wenigen Personen, die die alte, leider aussterbende Kunst, des Rätselns noch beherrscht.")
        do_message(npc, ch, "Ach, das waren noch Zeiten.")
        do_message(npc, ch, "Als jeden Tag ein Turnier stattfand und wir unsere Rätselkünste massen")
        do_message(npc, ch, "Aber ich schweife ab.")
        do_message(npc, ch, "Ich würde dir gerne ein paar Rätsel stellen.")
        do_message(npc, ch, "Natürlich nur, wenn du damit Einverstanden bist.")
        do_message(npc, ch, "Und, wie sieht's aus?")
        while true do
            local a = do_choice(npc, ch, 
              "Ja, ich möchte.",
              "Nein, ich möchte nicht.")
            if a == 1 then
                --Set Quest
                invertika.set_quest_status(ch, queststring_vodel, 2) --Es wurde schon mit dem Vodel geraedet und die quest angenommen.
                
                do_message(npc, ch, "Danke.")
                do_message(npc, ch, "Wollen wir sofort beginnen, oder hast du noch etwas zu erledigen?")
                while true do
                    local v = do_choice(npc, ch, "Lass uns beginnen.",
                      "Ich warte lieber nochmal ein bisschen")
                    if v == 1 then
                        do_message(npc, ch, "ok, danke.")
                        -- Set Quest
                        invertika.set_quest_status(ch, queststring_vodel, 4) --Es wurde mit Vodel geredet, die Quest angenommen, und die erste Runde wird gestartet.
                        break
                    elseif v == 2 then
                        do_message(npc, ch, "Ok, ich will dich ja auch nicht hetzen.")
                        --Set Quest
                        invertika.set_quest_status(ch, queststring_vodel, 3) --Es wurde mit Vodel geredet, die Quest angenommen, die erste Runde sit aber noch nciht gestartet.
                        break
                    end
                end
                break
            elseif a == 2 then
                do_message(npc, ch, "Schade, aber ich kann dich ja nicht zu deinem Glück zwingen.")
                do_message(npc, ch, "Du kannst natürlich gerne wiederkommen, falls du es dir anders überlegst.")
                --Set Quest
                invertika.set_quest_status(ch, queststring_vodel, 1) --Es wurde schon mit dem Vodel geraedet, aber noch nicht angenommen.
                break
            end
        end
    end    

    if quest_var_vodel == 4 then
        local right_counter = 0
        
        do_message(npc, ch, "Wir beginnen jetzt mit der ersten Runde.")
        do_message(npc, ch, "Kommen wir zur ersten, noch recht einfachen Frage..")
        do_message(npc, ch, "Wie heißt unsere Gottheit?")
        while true do
            local s = do_choice(npc, ch, "Egam",
              "Invertika",
              "Kahress")
            if s == 2 then
                right_counter = right_counter + 1
                break
            elseif s > 0 then
                break
            end
        end
        
        do_message(npc, ch, "...")
        do_message(npc, ch, "Wo liegt Selphi Timlet von uns aus?")
        while true do
            local s = do_choice(npc, ch, "Östlich",
            "Nordöstlich",
            "Nördlich")
            if s == 3 then
                right_counter = right_counter + 1
                break
            elseif s > 0 then
                break
            end
        end
        
        do_message(npc, ch, "...")
        do_message(npc, ch, "Eine Riesenmade braucht 5 Minuten für 100 Meter, ein Mammut braucht für dieselbe Strecke 1.5 Minuten.")
        do_message(npc, ch, "Wie oft kann das Mammut eine Srecke von 200 Metern komplett laufen, bevor die Riesenmade dieselbe Strecke geschafft hat?")
        while true do
            local s = do_choice(npc, ch, "3 mal",
              "4 mal",
              "3,34 mal")
            if s == 1 then
                right_counter = right_counter + 1
                break
            elseif s > 0 then
                break
            end
        end
        do_message(npc, ch, "...")
        
        if right_counter == 3 then
            do_message(npc, ch, "Die erste Runde ist beendet.")
            --Set Quest
            invertika.set_quest_status(ch, queststring_vodel, 6) --Es wurde schon mit dem Vodel geraedet, die Quest angenommen, und die erste Runde geschafft.
            do_message(npc, ch, "Hier ein kleiner Preis..")
            invertika.add_money(ch, 100)
        else
            do_message(npc, ch, "Hmm..")
            do_message(npc, ch, "Du kannst später noch einmal dein Glück probieren.")
            --Set Quest
            invertika.set_quest_status(ch, queststring_vodel, 5) --Es wurde schon mit dem Vodel geraedet, die Quest angenommen, und die erste Runde noch nicht geschafft.
        end
    end

    if quest_var_vodel == 6 then
        do_message(npc, ch, "Ich will die Antwort auf Blubb wissen.")
        do_message(npc, ch, "Suche dazu Bolum auf.")
        --Set Quest
        invertika.set_quest_status(ch, queststring_vodel, 7) --Es wurde schon mit dem Vodel geraedet, die Quest angenommen, und die zweite Runde ist begonnen.
    end
    
    if quest_var_vodel == 7 then
        do_message(npc, ch, "Du bist ja schon wieder zurück.")
        do_message(npc, ch, "Die heutigen Generationen sind ja nur noch am hetzen.")
        do_message(npc, ch, "Verstehen, was sie sehen und tuen, das können sie nicht.")
    end
    
    if quest_var_vodel == 8 then
        do_message(npc, ch, "Ah, du bist zurück.")
        do_message(npc, ch, "...")
        do_message(npc, ch, "Blubb ist also die Antwort.")
        do_message(npc, ch, "Hier ein kleiner Preis..")
        invertika.add_money(ch, 200)
        --Set Quest
        invertika.set_quest_status(ch, queststring_vodel, 9) --Es wurde schon mit dem Vodel geraedet, die Quest angenommen, und die zweite Runde ist beendet.
    end
    
    if quest_var_vodel == 9 then
        do_message(npc, ch, "Später werde ich dir ein neues Rätsel stellen, jetzt ist es noch zu früh.")
    end
    do_npc_close(npc, ch) 
end
