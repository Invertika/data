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
require "scripts/libs/banker"

atinit(function()
 create_npc("Botschafter", 66, 51 * TILESIZE + 16, 31 * TILESIZE + 16, botschafter_talk, nil)
 create_npc("Banker", 11, 24 * TILESIZE + 16, 28 * TILESIZE + 16, banker.banker_talk, nil)
end)

function botschafter_talk(npc, ch)
    local questname = "selphi_timlet_royal_pass"
    invertika.init_quest_status(ch, questname)
    if (invertika.get_quest_status(ch, "selphi_timlet_royal_pass") == nil) then ---Keine Questvar gesetzt
        do_message(npc, ch, invertika.get_random_element(
          "Ich bin hier der Botschafter. Ich vertrete Selphi Timlet in Roststock.",
          "Ich bin schon viele Jahre hier.",
          "Kenne ich dich?",
          "Was ist denn? Nichts? Gut, dann lass mich weiter arbeiten.",
          "Im Moment nicht, ich bin beschäftigt!",
          "Ich würde gerne mal zum Meer."))
    elseif (invertika.get_quest_status(ch, "selphi_timlet_royal_pass") == 1) then
        local count = mana.chr_inv_count(ch, 40011)

        if count > 0 then
            invertika.add_items(ch, 40011, -1, "Brief an die Botschaft in Roststock")
            invertika.add_items(ch, 40012, 1, "Brief von der Botschaft in Roststock an Averin")
            invertika.set_quest_status(ch, "selphi_timlet_royal_pass", 2)
            do_message(npc, ch, "Oh, ein Brief. Warte einen Moment...")
            do_message(npc, ch, "Hier, nimm diese Antwort und bringe sie zu Averin.")
        else
            do_message(npc, ch, "Ihr seid nicht zufällig der Bote von Averin? Ich erwarte einen wichtigen Brief von ihm!"
        end
    elseif (invertika.get_quest_status(ch, "selphi_timlet_royal_pass") == 2) then
        do_message(npc, ch, invertika.get_random_element(
          "Schnell, bring Averin den Brief!",
          "Worauf wartest du noch?"))
    elseif (invertika.get_quest_status(ch, "selphi_timlet_royal_pass") >= 3) then
        do_message(npc, ch, invertika.get_random_element(
          "Danke für deine Hilfe.",
          "Dankeschön.",
          "Nein, es gibt nichts mehr für dich zu tun.",
          "Ich muss nun weiterarbeiten."))
    end

    do_npc_close(npc, ch)
end
