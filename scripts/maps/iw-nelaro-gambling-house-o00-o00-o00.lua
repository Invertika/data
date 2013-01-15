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
require "scripts/libs/dice"
require "scripts/libs/slotmachine"
require "scripts/libs/roulette"


local function irac_talk(npc, ch)
    local queststring = "nelaro_water_quest"
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    
    npc_message(npc, ch, invertika.get_random_element("Hi, was kann ich für sie tuen?",
      "Hi, was gibt es?",
      "Hi, wie kann ich ihnen helfen?",
      "Hallo, was kann ich für sie tuen?",
      "Hallo, was gibt es?",
      "Hallo, wie kann ich ihnen helfen?",
      "Guten Tag, was kann ich für sie tuen?",
      "Guten Tag, was gibt es?",
      "Guten Tag, wie kann ich ihnen helfen?",
      "Moin",
      "Was wollen sie hier?!"))
    while true do
        local v = npc_choice(npc, ch,
          "Kaufen",
        invertika.get_random_element("Quasseln",
          "Reden",
          "Einen Plausch führen."),
        invertika.get_random_element("Nichts",
          "Dies war nur eine Hörprobe!",
          "Ich gehe lieber."))
        if v == 1 then
            npc_trade(npc, ch, false,
              {{30001, 25, 300},
              {30006, 400, 200},
              {30007, 300, 200}})
            break
        elseif v == 2 then
            npc_message(npc, ch, invertika.get_random_element("Über was wollen wa den reden?",
              "Über was wollen wir reden?"))
            while true do
                local w = npc_choice(npc, ch, 
                  "Über die Familie in der Mitte",
                  "Über die Wassernot",
                  "Über nichts")
                if w == 1 then
                    npc_message(npc, ch, "Soviel weiß hier keiner über die in der Mitte.")
                    npc_message(npc, ch, "Sie leben halt sehr zurückgeschieden und lassen kaum einen an sich heran.")
                    npc_message(npc, ch, "Es gehen aber Gerüchte um...")
                    npc_message(npc, ch, "Frage dazu bitte den Hobel, der weiß mehr darüber")
                
                    --Set Quest
                    invertika.set_quest_status(ch, queststring, 1)
                    break
                elseif w == 2 then
                    npc_message(npc, ch, "Einst war hier alles mal grün und fruchtbar.")
                    npc_message(npc, ch, "Der Fluss im Norden unserer Stadt war voll mit frischem Wasser.")
                    npc_message(npc, ch, "Woher das kam, weiß ich nicht.")
                    npc_message(npc, ch, "Ist aber auch egal.")
                    npc_message(npc, ch, "Auf jedenfall, war er nach einer stürmischen Nacht ausgetrocknet.")
                    npc_message(npc, ch, "Mehr weiß ich auch nicht.")
                    break
                elseif w == 3  then
                    break
                end
            end
            break;
        elseif v == 3 then
            npc_message(npc, ch, invertika.get_random_element("Tschüß",
              "Tschau",
              "Bis Bald",
              "Beehren sie uns bald wieder",
              "Bis irgendwann.",
              "Verschwinde!",
              "Ciao"))
            break
        end
    end
end

atinit(function()
    npc_create("Irac", 16, GENDER_UNSPECIFIED, 30 * TILESIZE + 16, 37 * TILESIZE + 16, irac_talk, nil)
    
    npc_create("Würfeltisch", 1, GENDER_UNSPECIFIED, 13 * TILESIZE + 16, 35 * TILESIZE + 16, dice.dicemanager_talk, nil)
    npc_create("Würfeltisch", 1, GENDER_UNSPECIFIED, 20 * TILESIZE + 16, 35 * TILESIZE + 16, dice.dicemanager_talk, nil)
    npc_create("Würfeltisch", 1, GENDER_UNSPECIFIED, 20 * TILESIZE + 16, 39 * TILESIZE + 16, dice.dicemanager_talk, nil)
    
    npc_create("Slotmaschine", 1, GENDER_UNSPECIFIED, 3 * TILESIZE + 16, 35 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    npc_create("Slotmaschine", 1, GENDER_UNSPECIFIED, 16 * TILESIZE + 16, 35 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    npc_create("Slotmaschine", 1, GENDER_UNSPECIFIED, 17 * TILESIZE + 16, 35 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    npc_create("Slotmaschine", 1, GENDER_UNSPECIFIED, 3 * TILESIZE + 16, 40 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    
    npc_create("Roulette", 1, GENDER_UNSPECIFIED, 5 * TILESIZE + 16, 35 * TILESIZE + 16, roulette.roulette_talk, nil)
    npc_create("Roulette", 1, GENDER_UNSPECIFIED, 5 * TILESIZE + 16, 39 * TILESIZE + 16, roulette.roulette_talk, nil)
    npc_create("Roulette", 1, GENDER_UNSPECIFIED, 12 * TILESIZE + 16, 39 * TILESIZE + 16, roulette.roulette_talk, nil)
end)
