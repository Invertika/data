----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2010 The Invertika Development Team                        --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"


local function averin_talk(npc, ch)
        invertika.init_quest_status(ch, "selphi_timlet_royal_pass")
    if (invertika.get_quest_status(ch, "selphi_timlet_royal_pass") == 0) then ---Keine Questvar gesetzt
      npc_message(npc, ch, "Hallo, was ist dein Begehr?")
      while true do
          local v = npc_choice(npc, ch, "Wer bist du?",
                          "Ich suche einen königlichen Passierschein.",
                          "Nichts. Danke.")

          if v == 1 then
              npc_message(npc, ch, invertika.get_random_element("Ich bin Averin, Chef der königlichen Palastwache.",
              "Mein Name ist Averin. Mir untersteht die königliche Palastwache.",
              "Ich bin Averin und bin zuständig für die Sicherheit des Palastes.",
              "Mein Name tut nichs zur Sache, oder doch?",
              "Ich bin für die Sicherheit im Selphi Timlet zuständig.",
              "Ich sichere mit den Palastwachen die Stadt."))
              break
          elseif v == 2 then
              npc_message(npc, ch, "Du möchtest also einen königlichen Passierschein? Nun gut, aber vorher musst du mir einen Gefallen tun. Bringe diesen Brief bitte in die Botschaft in Roststock.")
              invertika.add_items(ch, 40011, 1, "Brief an die Botschaft in Roststock")
              invertika.set_quest_status(ch, "selphi_timlet_royal_pass", 1)
              break
          elseif v == 3 then
              npc_message(npc, ch, "Dann gehe wie du gekommen bist.")
              break
          end
      end
    elseif (invertika.get_quest_status(ch, "selphi_timlet_royal_pass")==1) then --- Hier kann der Quest weitergeführt werden
      npc_message(npc, ch, invertika.get_random_element("Mach die schnell auf den Weg.",
      "Was machst du noch hier? Schnell, der Brief ist wichtig.",
      "Du bist ja immer noch hier? Müsstest du nicht längst auf dem Weg nach Roststock sein?"))
    elseif (invertika.get_quest_status(ch, "selphi_timlet_royal_pass")==2) then
      local count = chr_inv_count(ch, 40012)

      if count > 0 then
          invertika.add_items(ch, 40012, -1, "Brief von der Botschaft in Roststock an Averin")
          invertika.add_items(ch, 40009, 1, "königlicher Passierschein")
          invertika.set_quest_status(ch, "selphi_timlet_royal_pass", 3)
          npc_message(npc, ch, "Danke für deine Hilfe. Hier ist dein königlicher Passierschein.")
      else
          npc_message(npc, ch, invertika.get_random_element("Wo ist das Antwortschreiben?",
          "Du solltest doch eine Antwort von der Botschaft mitbringen?",
          "Hast du das Antwortschreiben vergessen?"))
      end
    elseif (invertika.get_quest_status(ch, "selphi_timlet_royal_pass")==3) then
      npc_message(npc, ch, invertika.get_random_element("Danke für deine Hilfe.",
      "Wenn ich wieder mal jemanden brauche, sage ich es dir.",
      "Im Moment habe ich nichts für dich."))
    end

end

atinit(function()
 npc_create("Averin", 29, GENDER_UNSPECIFIED, 15 * TILESIZE + 16, 15 * TILESIZE + 16, averin_talk, nil) --- Elmo
end)
