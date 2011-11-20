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

atinit(function()
    create_npc("Irac", 16, 30 * TILESIZE + 16, 37 * TILESIZE + 16, irac_talk, nil)
    
    create_npc("Würfeltisch", 1, 13 * TILESIZE + 16, 35 * TILESIZE + 16, dice.dicemanager_talk, nil)
    create_npc("Würfeltisch", 1, 20 * TILESIZE + 16, 35 * TILESIZE + 16, dice.dicemanager_talk, nil)
    create_npc("Würfeltisch", 1, 20 * TILESIZE + 16, 39 * TILESIZE + 16, dice.dicemanager_talk, nil)
    
    create_npc("Slotmaschine", 1, 3 * TILESIZE + 16, 35 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    create_npc("Slotmaschine", 1, 16 * TILESIZE + 16, 35 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    create_npc("Slotmaschine", 1, 17 * TILESIZE + 16, 35 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    create_npc("Slotmaschine", 1, 3 * TILESIZE + 16, 40 * TILESIZE + 16, slotmachine.slotmachine_talk, nil)
    
    create_npc("Roulette", 1, 5 * TILESIZE + 16, 35 * TILESIZE + 16, roulette.roulette_talk, nil)
    create_npc("Roulette", 1, 5 * TILESIZE + 16, 39 * TILESIZE + 16, roulette.roulette_talk, nil)
    create_npc("Roulette", 1, 12 * TILESIZE + 16, 39 * TILESIZE + 16, roulette.roulette_talk, nil)
end)

function irac_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Hi, was kann ich für sie tuen?",
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
        local v = do_choice(npc, ch,
          "Kaufen",
        invertika.get_random_element("Quasseln",
          "Reden",
          "Einen Plausch führen."),
        invertika.get_random_element("Nichts",
          "Dies war nur eine Hörprobe!",
          "Ich gehe lieber."))
        if v == 1 then
            mana.npc_trade(npc, ch, false,
              {{30001, 25, 300},
              {30006, 400, 200},
              {30007, 300, 200}})
            break
        elseif v == 2 then
            do_message(npc, ch, invertika.get_random_element("Über was wollen wa den reden?",
              "Über was wollen wir reden?"))
            local w = do_choice(npc, ch, 
              "Über die Familie in der Mitte",
              "Über die Wassernot",
              "Über den Raum nebenan",
              "Über nichts")
            if w == 1 then
                do_message(npc, ch, "Soviel weiß hier keiner über die in der Mitte.")
                do_message(npc, ch, "Sie leben halt sehr zurückgeschieden und lassen kaum einen an sie heran.")
                do_message(npc, ch, "Es gehen aber Gerüchte um...")
                do_message(npc, ch, "Frage dazu bitte den Hobel, der weiß mehr darüber")
                break
            elseif w == 2 then
                do_message(npc, ch, "Einst war hier alles mal grün und fruchtbar.")
                do_message(npc, ch, "Der Fluss im Norden unserer Stadt war voll mit frischen Wasser.")
                do_message(npc, ch, "Woher das kamm, weiß ich nicht.")
                do_message(npc, ch, "Ist aber auch egal.")
                do_message(npc, ch, "Auf jedenfall, war er nach einer stürmischen Nacht ausgetrocknet.")
                do_message(npc, ch, "Mehr weiß ich auch nicht.")
                break
            elseif w == 3 then
                do_message(npc, ch, "Das war vom Vorbesitzer des Laden noch ein Lagerraum.")
                do_message(npc, ch, "Nichts besonderes also.")
                local x = do_choice(npc, ch,
                  "Und wieso ist dann dort eine Klappe nach unten?",
                  "Okay")
                if x == 1 then
                    do_message(npc, ch, "Ich weiß selbst nicht, wohin die führt.")
                    break
                elseif x == 2 then
                    break
                end
            elseif w == 4  then
                break
            end
            break
        elseif v == 3 then
            do_message(npc, ch, invertika.get_random_element("Tschüß",
              "Tschau",
              "Bis Bald",
              "Beehren sie uns bald wieder",
              "Bis irgendwann.",
              "Verschwinde!",
              "Ciao"))
            break
        end
    end
    do_npc_close(npc, ch)
end
