----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/sign"
require "scripts/libs/invertika"

dofile("data/scripts/libs/warp.lua")

atinit(function()
    create_inter_map_warp_trigger(97, 107, 95, 85) --- Intermap warp

    sign_entrance = "Narva"
    sign.create_sign(154, 128, sign_entrance) --- Schild Ortseingang
    sign.create_sign(62, 106, sign_entrance) --- Schild Ortseingang
    sign.create_sign(95, 47, sign_entrance) --- Schild Ortseingang

    create_npc("Awond", 120, 159 * TILESIZE, 40 * TILESIZE, awond_talk, nil)
    mordyno = create_npc("Mordyno", 141, 101 * TILESIZE + 16, 109 * TILESIZE + 16, mordyno_talk, mordyno_update)
    invertika.create_npc_talk_random(mordyno,
          {"Kauft Leute! Kauft!", 
          "Hier gibt es nur beste Ware!",
          "Kommen sie meine Herren, Kommen sie meine Damen!",
          "Messer von feinster Qualität, nur 50 Aki das Stück! 140 Aki in der Luxusvariante!",
          "Dolche, der stetige Begleiter gegen die Gefahren der Wüste, nur 1000 Aki!",
          "Einen Holzstab zum Üben im Umgang mit Stabwaffen, nur 1690 Aki!",
          "Baumwollkleidung, in allen Farben, nur 250 Aki das Stück!",
          "Die neuste Mode zu Spottpreisen! Kaufen sie, so lange der Vorrat reicht.",
          "Messer jetzt reduziert für nur 50 Aki das Stück! Greifen sie zu!"})

    create_npc("Bache", 45, 116 * TILESIZE + 16, 61 * TILESIZE + 16, bache_talk, nil)
    create_npc("Cloina", 79, 94 * TILESIZE + 16, 105 * TILESIZE + 16, cloina_talk, nil)
    create_npc("Brielm", 72, 109 * TILESIZE + 16, 102 * TILESIZE + 16, brielm_talk, nil)
end)

function awond_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Sei gegrüßt Reisender!",
      "Das war ein harter Tag.",
      "Ich hoffe meine Frau macht schonmal das Abendessen.",
      "Setz dich doch zu mir."))
    do_npc_close(npc, ch)
end

function mordyno_talk(npc, ch)
    mana.npc_trade(npc, ch, false, {
      {10001, 30, 50},
      {10013, 30, 140},
      {10002, 30, 1000},
      {10009, 30, 1690},
      {20001, 30, 250},
      {20002, 30, 250},
      {20011, 30, 250},
      {20012, 30, 250},
      {20013, 30, 250},
      {20014, 30, 250},
      {20015, 30, 250},
      {20016, 30, 250},
      {20017, 30, 250},
      {20018, 30, 250},
      {20009, 30, 500} })
    do_npc_close(npc, ch)
end

function mordyno_update(npc)
    npclib.walkaround_wide(npc)
    invertika.npc_talk_random(npc)
end

function bache_talk(npc, ch)
    local quest_string = "narva_bache_quest"
    invertika.init_quest_status(ch, quest_string)
    function get_qstatus() return invertika.get_quest_status(ch, quest_string) end
    function set_qstatus(x) invertika.set_quest_status(ch, quest_string, x) end
    if get_qstatus() == 0 then
        do_message(npc, ch, "Sei gegrüßt Fremder.")
        do_message(npc, ch, "Ich bin auf der Suche nach brauchbarem Bauholz")
        do_message(npc, ch, "Leider ist das Palmen holz hier nicht zu gebrauchen...")
        do_message(npc, ch, "Ich muss mich wohl auf eine weitere Reise machen.")
        while true do
            local v = do_choice(npc, ch, "Soll ich Holz für dich besorgen?", "Viel Glück bei der Reise.")
            if v == 1 then
                set_qstatus(1)
                do_message(npc, ch, "Das würdest du tun? Hm... Ich kann dir aber nicht viel als Belohnung geben...")
                break
            elseif v == 2 then
                do_message(npc, ch, "Danke.")
                break
            end
        end
    elseif get_qstatus() == 1 then
        local count = mana.chr_inv_count(ch, 40040)
        if count > 0 then
            do_message(npc, ch, "Du hast Holz!")
            do_message(npc, ch, "Würdest du mir es überlassen?")
            while true do
                local v = do_choice(npc, ch, "Nimm es dir.", "Nein. Das brauch ich selber.")
                if v == 1 then
                    local count = mana.chr_inv_count(ch, 40040)
                    if count == 0 then break end
                    set_qstatus(2)
                    invertika.add_items(ch, 40040, -count, "Holz")
                    do_message(npc, ch, "Vielen Dank.")
                    do_message(npc, ch, "Ich kann dir leider nicht viel geben...")
                    do_message(npc, ch, "Aber nimm diese Axt. Hier kann ich mit der nicht viel anfangen.")
                    invertika.add_items(ch, 10014, 1, "Axt")
                    break
                elseif v == 2 then
                    do_message(npc, ch, "Schade.")
                    break
                end
            end
        else
            do_message(npc, ch, invertika.get_random_element(
              "Ich nehme es dir nich übel wenn du das Holz nicht besorgst.",
              "Du musst das Holz nicht besorgen.")) -- TODO: Mehr Auswahl.
        end
    elseif get_qstatus() == 2 then
        do_message(npc, ch, "Vielen Dank für das Holz! Ich werde das nie vergessen.")
    end
    do_npc_close(npc, ch)
end

function cloina_talk(npc, ch)
    do_message(npc, ch, "Ich verkaufe hier Heilmittel aus meinen selbstangebauten Kräutern.")
    do_npc_close(npc, ch)
    mana.npc_trage(npc, ch, false,
     { {30001, 30, 300},
       {30002, 30, 100},
       {30008, 30, 200},
       {30015, 30, 250},
       {30016, 30, 500},
       {30018, 30, 250},
       {30019, 30, 550},
       {30023, 30, 150},
       {30025, 30, 1000} }
end

function brielm_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element(
      "Willkommen in Narva",
      "Wir leben hier vom Handel zwischen den Wüstenbewohnern und denen aus dem Grasland.",
      "Ich hoffe es gefällt dir hier.")) -- TODO: Mehr Auswahl.
    do_npc_close(npc, ch)
end
