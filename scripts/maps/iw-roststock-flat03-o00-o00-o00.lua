----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                          --
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
 create_npc("Marle", 67, 27 * TILESIZE + 16, 29 * TILESIZE + 16, marle_talk, nil)
end)

function marle_talk(npc, ch)
    local quest_string = "roststock_marle_quest"
    invertika.init_quest_status(ch, quest_string)
    local get_qstatus = function() return invertika.get_quest_status(ch, quest_string) end
    local set_qstatus = function(x) invertika.set_quest_status(ch, quest_string, x) end
    if get_qstatus() == 0 then
        local count = mana.chr_inv_count(ch, 40039)
        if count > 0 then
            do_message(npc, ch, "Porzellan! Ich sehe du hast Teller aus Porzellan.")
            do_message(npc, ch, "Diese Teller haben unschätzbaren Wert!")
            do_message(npc, ch, "Gibst du mir diese Koststücke?")
            while true do
                local v = do_choice(npc, ch, "Ja.", "Nein.")
                if v == 1 then
                    invertika.add_items(ch, 40039, -count, "Teller aus Porzellan")
                    invertika.add_items(ch, 40028, math.ceil(count / 2), "antike Münze")
                    do_message(npc, ch, "Vielen Dank! Nimm dies als Dank.")
                    set_qstatus(1)
                    break
                else
                    do_message(npc, ch, "Schade.")
                    do_message(npc, ch, "Bedenke, dass niemand außer mir den Wert dieser Teller erkennt.")
                    break
                end
            end
        else
            do_message(npc, ch, invertika.get_random_element(
              "Ich sammle gerne Porzellan.",
              "Willst du mal meine Porzellansammlung sehen?",
              "Wenn du altes Porzellan findest, bringe es mir bitte. Du kriegst auch was dafür."))
        end
    else
        do_message(npc, ch, invertika.get_random_element(
          "Ich würde gerne mal Effendi besuchen.",
          "Die beste Freundin von Effendi ist Anne. Habe ich zumindestens gehört.",
          "Eigentlich heißt er garnicht Effendi sondern Effendi der Erste.",
          "Du hättest dir ruhig die Schuhe abputzen können. Jetzt ist hier alles voller Sand.",
          "In den westlichen Gegenden soll es manchmal sogar Schnee geben habe ich gehört.",
          "Früher sammelte ich Porzellanfiguren.")) 
    end
     do_npc_close(npc, ch)
end
