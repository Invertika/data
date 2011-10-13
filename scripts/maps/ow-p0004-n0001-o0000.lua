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
require "scripts/libs/nethek"
require "scripts/libs/seller"

dofile("data/scripts/libs/warp.lua")

-- Grabstein XY Position in Tiles, und Grabstein-Text
local gravestone_data =
{
 { 49, 34, "Seine letzten Worte waren: \"Keine Angst es ist schon tot\"" },
 { 52, 34, "Schon von weitem fällt das Grab mit drei gleichen Grabsteinen auf.\n Beim Näherkommen ist auf dem linken Stein zu lesen: Hier ruht Hütchenspielerin Eugenie - oder hier - oder hier..." },
 { 55, 34, "Hier ruht der Schornsteinkehrer Horstie - Er kehrt nie wieder" },
 { 58, 34, "Johnny Walker, Jack Daniels, Jim Bean, Maria Kron - Nie wieder Alkohol" },
 { 61, 34, "Nun liege ich hier und bin am verwesen - wo ihr jetzt seid bin ich schon längst gewesen. Doch auch ihr kommt noch dran, drum drängelt nicht und stellt euch hinten an!" },
 { 72, 34, "Der Tod, ein Weltmann und Galant, reichte höflich ihm die Hand. Doch er nahm nicht nur seine Hände, den ganzen Kerl griff er am Ende." },
 { 75, 34, "Hinterher ist man immer schlauer..." },
 { 78, 34, "Hier liegt ein Nichtraucher, kaum zu glauben, die sterben auch!" },
 { 81, 34, "Als er von den schlimmen Folgen des Trinkens laß, gab er sofort das Lesen auf." },
 { 84, 34, "Holt mich hier rauuuuus!" },
 { 49, 38, "Lebe  heute und denke nicht an morgen" },
 { 52, 38, "Hier liegen meine Gebeine, zum ersten mal alleine" },
 { 55, 38, "Immer sagte sie, Ihre Füße bringen sie um, aber keiner hats Ihr geglaubt" },
 { 78, 38, "Im Leben hatte er gern recht\nverdiente jedoch sein Brot als Knecht,\nbis er hier vom Felsen stürzte\nund so das Leben verkürzte." },
 { 81, 38, "Er dachte er würde es schaffen, aber hier liegt er nun." },
 { 84, 38, "Ich lieg hier nur so rum." },
 { 49, 42, "Er starb hier, dann nie mehr." },
 { 52, 42, "Hier ruhen meine Gebeine, ich wollt es wären deine." },
 { 55, 42, "Er schaute in den Schacht, ob der Fahrstuhl fährt. Was dieser auch tat." },
 { 78, 42, "Und er sagte noch:\"Und wenn es das Letzte ist, was ich tue!\"" },
 { 81, 42, "Man kann alles mindestens einmal essen. Irgendwie falsch verstanden..." },
 { 84, 42, "Hier ruht ein Hypochonder - jetzt hat er es aber wirklich übertrieben." },
 { 49, 48, "Besuchszeiten:\nMontags bis Freitags 12:00 - 14:00 Uhr\nAndere Termine nach Vereinbarung." },
 { 52, 48, "Was mich nicht umbringt, macht mich stärker. Mist!" },
 { 55, 48, "Ich wollte aber eingeäschert werden!" },
 { 58, 48, "Auf seine Verbündeten muss man ebenso aufpassen wie auf seine Feinde - hatte er wohl vergessen" },
 { 61, 48, "So tief lag er noch nie" },
 { 72, 48, "Wir werden Ihn nie vergessen, egal, wie er hieß" },
 { 75, 48, "Hier ruht er, schweigen tut er, bis in die Ewigkeit (Wurde auch langsam Zeit)" },
 { 78, 48, "Wenn ihr diesen Text lesen könnt, steht Ihr auf MEEEEIIIIINEEEEEEMMMMMM GRAAAAAAAAB!!!!!" },
 { 81, 48, "Und sie sagte zu mir: \"Wirf mal den Speer rüber\"" },
 { 84, 48, "Gestern standen sie vorm Abgrund. Heute sind sie einen Schritt weiter." },
 { 94, 37, "Mir ist todlangweilig" },
 {103, 37, "Hier liegt begraben unser Organist\nWarum? Weil er gestorben ist." },
 {124, 37, "Der Weg in die Ewigkeit\nist doch garnicht so weit\nUm 7Uhr fuhr er fort\nUm 8Uhr war er dort" },
 {151, 37, "Hier liegt der Arzt Nepomuk - und alle die er nicht heilte neben Ihm." },
 {109, 41, "Auf des Gärtners Grab stand:\nJetzt ist Sense!" },
 {118, 41, "Rest in Pieces" },
 {127, 41, "Nummer 5 lebt!" },
 {139, 41, "Keine Grabinschrift mehr erkennbar" },
 { 94, 45, "Keine Grabinschrift mehr erkennbar" },
 {115, 45, "Keine Grabinschrift mehr erkennbar" },
 {112, 49, "Keine Grabinschrift mehr erkennbar" },
 {121, 49, "Keine Grabinschrift mehr erkennbar" },
 {130, 49, "Keine Grabinschrift mehr erkennbar" },
 {142, 49, "Keine Grabinschrift mehr erkennbar" },
 { 97, 53, "Keine Grabinschrift mehr erkennbar" },
 {124, 53, "Keine Grabinschrift mehr erkennbar" },
 {133, 53, "Keine Grabinschrift mehr erkennbar" }
}
-- Angezeigter Name - keiner
local gravestone_npc_name = "Grabstein"
-- ID des unsichtbaren NPC
local gravestone_npc_id = 1

atinit(function()
 create_inter_map_warp_trigger(105, 111, 101, 89) --- Intermap warp
 nethek.create_netheksaeule(138 * TILESIZE, 125 * TILESIZE + 16) --- Netheksäule
 
 --NPCs
  create_npc("Donovan", 29, 75 * TILESIZE + 16, 76 * TILESIZE + 16, seller.seller_talk, nil) --- Verkäufer
 
 --- Wachen am Tor
 wache = create_npc("Stadtwache", 26, 84 * TILESIZE + 16, 187 * TILESIZE + 16, stadtwache_talk, nil) --- Stadtwache
 create_npc("Stadtwache", 26, 87 * TILESIZE + 16, 187 * TILESIZE + 16, stadtwache_talk, nil) --- Stadtwache
 mana.trigger_create(85 * TILESIZE, 186 * TILESIZE, 2 * TILESIZE, 2 * TILESIZE, "wache_trigger", 1, true) --- Trigger Tor
 
 -- Grabsteine
 for i, v in ipairs(grave_stone_data) do
    create_npc(gravestone_npc_name, gravestone_npc_id, v[1] * 32 + 16, v[2] * 32 + 16, npclib.talk(v[3]))
 end
end)


--- Stadtwache Sprechfunktion
function stadtwache_talk(npc, ch)
 do_message(npc, ch, invertika.get_random_element("Hier darf niemand durch!",
 "Glaub mir, da willst du nicht rein...",
 "Lyet steht unter Quarantäne. Wegen der Seuche.",
 "Meinen Vorgänger hat die Seuche auch schon erwischt... Aber was soll man machen, so viele Städte gibt es nicht zu bewachen.",
 "Kein Zugang für Minderjährige! Und nein, auch nicht für Volljährige!",
 "Wer eintritt wird eines grausamen und schmerzhaften Todes bestraft. So oder so.",
 "Wieso sollte wer da rein wollen? Sind doch eh schon alle tot..."))
 do_npc_close(npc, ch)
end

--- Stadtwache Trigger
function wache_trigger(ch, id)
 if (mana.being_type(ch) == TYPE_CHARACTER) then --- Nur Spieler beachten
  mana.chr_warp(ch, mana.get_map_id(), mana.posX(ch), 190 * TILESIZE) --- Zurückversetzen des Spielers
  mana.being_say(wache, invertika.get_random_element("Kein Durchgang!",
  "Zwing uns nicht dir weh zu tun! Kein Durchgang!",
  "Du darfst hier nicht durch!",
  "Draußen bleiben!",
  "Zutritt verboten!",
  "Hier darf keiner durch!"))
 end
end
