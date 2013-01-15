﻿----------------------------------------------------------------------------------
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


local function rezeptionist_talk(npc, ch)
  quest_name="selphi_timlet_rezeptionist_quest"
  -- quest init
  invertika.init_quest_status(ch, quest_name)
  -- quest get/set functions
  local function get_qstatus() return invertika.get_quest_status(ch, quest_name) end
  local function set_qstatus(x) invertika.set_quest_status(ch, quest_name, x) end

  if chr_inv_count(ch, 40035) > 0 and invertika.get_quest_status(ch, "selphi_timlet_ceech_quest") == 1 then
        npc_message(npc, ch, "Schon wieder eine Klageschrift von Ceech?")
        npc_message(npc, ch, "Er verklagt alles und jeden. Mich hat er wegen den Kokussnüssen dran gekriegt.")
        npc_message(npc, ch, "Es wäre unverantwortlich die Kokusnüsse einfach fallen zu lassen.")
        npc_message(npc, ch, "Gewinnt er diese Klage, so erhält er Anspruch auf die Kokusnuss Ernte.")
        npc_message(npc, ch, "Er hat sich schon viele Feinde hier in der Stadt gemacht.")
        npc_message(npc, ch, "Hör mir mal zu: Du verlierst den Brief einfach. Lass Ceech einfach links liegen.")
        npc_message(npc, ch, "Der Kerl ist geizig und kein guter Freund.")
        invertika.set_quest_status(ch, "selphi_timlet_ceech_quest", 2)
        invertika.add_items(ch, 40018, 1, "Scheck über 1000 Aki")
        npc_message(npc, ch, "Hier nimm diesen Scheck. Dafür lass den Brief irgendwo verschwinden.")
        return
  end

  if get_qstatus() == 0 then
    npc_message(npc, ch, "Willkommen im Hotel. Was kann ich für dich tun?")
      local v = npc_choice(npc, ch, "Hast du Arbeit für mich?","Nichts, danke")
        if v == 1 then
      npc_message(npc, ch, "In der Tat, es gibt da ein paar Dinge, die du für mich erledigen kannst. Mein WLAN Kabel ist undicht, deshalb brauche ich neue IP Pakete. Für die Unkosten gebe ich dir einen Scheck.")
      invertika.add_items(ch, 40017, 1, "500 Aki Scheck")
            set_qstatus(1) --- Erste Quest aktiviert
        elseif v == 2 then
      npc_message(npc, ch, "Wiedersehen")
        end
  elseif get_qstatus() == 1 then
    if chr_inv_count(ch, 40002) >= 10 then
            invertika.add_items(ch, 40002, -10, "IP-Pakete")
            npc_message(npc, ch, "Danke für die IP Pakete! Hier, eine kleine Belohnung.")
            invertika.add_money(ch, 200)
            set_qstatus(2)
        else
            npc_message(npc, ch, "Was stehst du noch hier rum? Bring mir 10 IP Pakete! Du kannst sie beim Manitu kaufen.")
        end
  elseif get_qstatus() == 2 then
        npc_message(npc, ch, "Kannst du mir helfen, die Maden- und Skorpione hier in der Gegend zu töten? Die vertreiben mir die Kundschaft! Als Beweis für deine Dienste hätte ich gerne 10x Skorpionstachel und 10x Madenschleim!")
      local v = npc_choice(npc, ch, "Vergiss es, das ist Tierquälerei!","Hier gibt es Maden?! Ich... muss weg!","Klar, mach ich!")
        if v == 3 then
            npc_message(npc, ch, "Viel Erfolg bei der Jagd!")
            set_qstatus(3)
        else
            npc_message(npc, ch, "Faule Ausreden! Du bist doch nur zu faul zum Arbeiten.")
        end
  elseif get_qstatus() == 3 then
        if chr_inv_count(ch, 40004) >= 10 and chr_inv_count(ch, 40005) >= 10 then
            invertika.add_items(ch, 40004, -10, "Skorpionstachel")
            invertika.add_items(ch, 40005, -10, "Madenschleim")
            npc_message(npc, ch, "Gut gemacht! Nimm diese Schuhe als Dank!")
            invertika.add_items(ch, 20009, 1, "Stiefel")
            set_qstatus(4)
        else
            npc_message(npc, ch, "Bring mir 10 Skorpionstachel und 10 Madenschleim. Vorher gibts keine Belohnung!")
        end
  elseif get_qstatus() == 4 then
            npc_message(npc, ch, "Mein Kühlschrank ist leer. Bring mir 10 Bier und 10 Milch, bitte!")
            set_qstatus(5)
  elseif get_qstatus() == 5 then
        if chr_inv_count(ch, 30006) >= 10 and chr_inv_count(ch, 30007) >= 10 then
            invertika.add_items(ch, 30006, -10, "Bier")
            invertika.add_items(ch, 30007, -10, "Milch")
            npc_message(npc, ch, "Gut gemacht! Nimm dieses Baumwollshirt und diesen Dolch als Dank!")
            invertika.add_items(ch, 20001, 1, "Baumwollshirt")
            invertika.add_items(ch, 10002, 1, "Dolch")
            set_qstatus(6)
        else
            npc_message(npc, ch, "Bring mir 10 Bier und 10 Milch!")
        end
  elseif get_qstatus() == 6 then
        npc_message(npc, ch, "Momentan habe ich keine Arbeit für dich.")
  elseif get_qstatus() == -1 then
        npc_message(npc, ch, "RAUS! Du hast Hausverbot!")
        chr_warp(ch, 61, 76 * TILESIZE, 167 * TILESIZE)
  end

end


atinit(function()
 npc_create("Rezeptionist", 20, GENDER_UNSPECIFIED, 44 * TILESIZE + 16, 57 * TILESIZE + 16, rezeptionist_talk, nil) --- Rezeptionist
end)
