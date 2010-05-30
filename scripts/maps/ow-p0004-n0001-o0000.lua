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

require "scripts/libs/npclib"

dofile("data/scripts/ivklibs/warp.lua")

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
 { 81, 34, "Als er von den schlimmen Folgen des Trinkens lag, gab er sofort das Lesen auf." },
 { 84, 34, "Holt mich hier rauuuuus!" },
 { 49, 38, "Lebe  heute und denke nicht an morgen" },
 { 52, 38, "Hier liegen meine Gebeine, zum ersten mal alleine" },
 { 55, 38, "Immer sagte sie, Ihre Füße bringen sie um, aber keiner hats Ihr geglaubt" },
 { 78, 38, "Im Leben hatte er gern recht\nverdiente jedoch sein Brot als Knecht,\nbis er hier vom Felsen stürtzte\nund so das Leben verkürzte." },
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
 {124, 37, "Der Weg in die Ewigkeit\nist doch ganricht so weit\nUm 7Uhr fuhr er fort\nUm 8Uhr war er dort" },
 {151, 37, "Hier liegt der Arzt Nepomuk - und alle die er nicht heilte neben Ihm." },
 {109, 41, "Auf des Gärtners Grab stand:\nJetzt ist Sense!" },
 {118, 41, "Rest in Pieces" },
 {127, 41, "Keine Grabinschrift mehr erkennbar" },
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
local gravestone_npc_name = ""
-- ID des unsichtbaren NPC
local gravestone_npc_id = 20001

atinit(function()
 create_inter_map_warp_trigger(105, 111, 101, 89) --- Intermap warp
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[1][1]*32+16, gravestone_data[1][2]*32+16, gravestone_talk01, nil) --- Grabstein1
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[2][1]*32+16, gravestone_data[2][2]*32+16, gravestone_talk02, nil) --- Grabstein2
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[3][1]*32+16, gravestone_data[3][2]*32+16, gravestone_talk03, nil) --- Grabstein3
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[4][1]*32+16, gravestone_data[4][2]*32+16, gravestone_talk04, nil) --- Grabstein4
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[5][1]*32+16, gravestone_data[5][2]*32+16, gravestone_talk05, nil) --- Grabstein5
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[6][1]*32+16, gravestone_data[6][2]*32+16, gravestone_talk06, nil) --- Grabstein6
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[7][1]*32+16, gravestone_data[7][2]*32+16, gravestone_talk07, nil) --- Grabstein7
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[8][1]*32+16, gravestone_data[8][2]*32+16, gravestone_talk08, nil) --- Grabstein8
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[9][1]*32+16, gravestone_data[9][2]*32+16, gravestone_talk09, nil) --- Grabstein9
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[10][1]*32+16, gravestone_data[10][2]*32+16, gravestone_talk10, nil) --- Grabstein10
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[11][1]*32+16, gravestone_data[11][2]*32+16, gravestone_talk11, nil) --- Grabstein11
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[12][1]*32+16, gravestone_data[12][2]*32+16, gravestone_talk12, nil) --- Grabstein12
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[13][1]*32+16, gravestone_data[13][2]*32+16, gravestone_talk13, nil) --- Grabstein13
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[14][1]*32+16, gravestone_data[14][2]*32+16, gravestone_talk14, nil) --- Grabstein14
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[15][1]*32+16, gravestone_data[15][2]*32+16, gravestone_talk15, nil) --- Grabstein15
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[16][1]*32+16, gravestone_data[16][2]*32+16, gravestone_talk16, nil) --- Grabstein16
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[17][1]*32+16, gravestone_data[17][2]*32+16, gravestone_talk17, nil) --- Grabstein17
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[18][1]*32+16, gravestone_data[18][2]*32+16, gravestone_talk18, nil) --- Grabstein18
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[19][1]*32+16, gravestone_data[19][2]*32+16, gravestone_talk19, nil) --- Grabstein19
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[20][1]*32+16, gravestone_data[20][2]*32+16, gravestone_talk20, nil) --- Grabstein20
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[21][1]*32+16, gravestone_data[21][2]*32+16, gravestone_talk21, nil) --- Grabstein21
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[22][1]*32+16, gravestone_data[22][2]*32+16, gravestone_talk22, nil) --- Grabstein22
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[23][1]*32+16, gravestone_data[23][2]*32+16, gravestone_talk23, nil) --- Grabstein23
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[24][1]*32+16, gravestone_data[24][2]*32+16, gravestone_talk24, nil) --- Grabstein24
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[25][1]*32+16, gravestone_data[25][2]*32+16, gravestone_talk25, nil) --- Grabstein25
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[26][1]*32+16, gravestone_data[26][2]*32+16, gravestone_talk26, nil) --- Grabstein26
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[27][1]*32+16, gravestone_data[27][2]*32+16, gravestone_talk27, nil) --- Grabstein27
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[28][1]*32+16, gravestone_data[28][2]*32+16, gravestone_talk28, nil) --- Grabstein28
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[29][1]*32+16, gravestone_data[29][2]*32+16, gravestone_talk29, nil) --- Grabstein29
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[30][1]*32+16, gravestone_data[30][2]*32+16, gravestone_talk30, nil) --- Grabstein30
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[31][1]*32+16, gravestone_data[31][2]*32+16, gravestone_talk31, nil) --- Grabstein31
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[32][1]*32+16, gravestone_data[32][2]*32+16, gravestone_talk32, nil) --- Grabstein32
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[33][1]*32+16, gravestone_data[33][2]*32+16, gravestone_talk33, nil) --- Grabstein33
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[34][1]*32+16, gravestone_data[34][2]*32+16, gravestone_talk34, nil) --- Grabstein34
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[35][1]*32+16, gravestone_data[35][2]*32+16, gravestone_talk35, nil) --- Grabstein35
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[36][1]*32+16, gravestone_data[36][2]*32+16, gravestone_talk36, nil) --- Grabstein36
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[37][1]*32+16, gravestone_data[37][2]*32+16, gravestone_talk37, nil) --- Grabstein37
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[38][1]*32+16, gravestone_data[38][2]*32+16, gravestone_talk38, nil) --- Grabstein38
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[39][1]*32+16, gravestone_data[39][2]*32+16, gravestone_talk39, nil) --- Grabstein39
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[40][1]*32+16, gravestone_data[40][2]*32+16, gravestone_talk40, nil) --- Grabstein40
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[41][1]*32+16, gravestone_data[41][2]*32+16, gravestone_talk41, nil) --- Grabstein41
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[42][1]*32+16, gravestone_data[42][2]*32+16, gravestone_talk42, nil) --- Grabstein42
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[43][1]*32+16, gravestone_data[43][2]*32+16, gravestone_talk43, nil) --- Grabstein43
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[44][1]*32+16, gravestone_data[44][2]*32+16, gravestone_talk44, nil) --- Grabstein44
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[45][1]*32+16, gravestone_data[45][2]*32+16, gravestone_talk45, nil) --- Grabstein45
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[46][1]*32+16, gravestone_data[46][2]*32+16, gravestone_talk46, nil) --- Grabstein46
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[47][1]*32+16, gravestone_data[47][2]*32+16, gravestone_talk47, nil) --- Grabstein47
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[48][1]*32+16, gravestone_data[48][2]*32+16, gravestone_talk48, nil) --- Grabstein48
 create_npc(gravestone_npc_name, gravestone_npc_id, gravestone_data[49][1]*32+16, gravestone_data[49][2]*32+16, gravestone_talk49, nil) --- Grabstein49
end)


--- Grabstein Sprechfunktionen
function gravestone_talk01(npc, ch) do_message(npc, ch, gravestone_data[1][3]) do_npc_close(npc, ch) end
function gravestone_talk02(npc, ch) do_message(npc, ch, gravestone_data[2][3]) do_npc_close(npc, ch) end
function gravestone_talk03(npc, ch) do_message(npc, ch, gravestone_data[3][3]) do_npc_close(npc, ch) end
function gravestone_talk04(npc, ch) do_message(npc, ch, gravestone_data[4][3]) do_npc_close(npc, ch) end
function gravestone_talk05(npc, ch) do_message(npc, ch, gravestone_data[5][3]) do_npc_close(npc, ch) end
function gravestone_talk06(npc, ch) do_message(npc, ch, gravestone_data[6][3]) do_npc_close(npc, ch) end
function gravestone_talk07(npc, ch) do_message(npc, ch, gravestone_data[7][3]) do_npc_close(npc, ch) end
function gravestone_talk08(npc, ch) do_message(npc, ch, gravestone_data[8][3]) do_npc_close(npc, ch) end
function gravestone_talk09(npc, ch) do_message(npc, ch, gravestone_data[9][3]) do_npc_close(npc, ch) end
function gravestone_talk10(npc, ch) do_message(npc, ch, gravestone_data[10][3]) do_npc_close(npc, ch) end
function gravestone_talk11(npc, ch) do_message(npc, ch, gravestone_data[11][3]) do_npc_close(npc, ch) end
function gravestone_talk12(npc, ch) do_message(npc, ch, gravestone_data[12][3]) do_npc_close(npc, ch) end
function gravestone_talk13(npc, ch) do_message(npc, ch, gravestone_data[13][3]) do_npc_close(npc, ch) end
function gravestone_talk14(npc, ch) do_message(npc, ch, gravestone_data[14][3]) do_npc_close(npc, ch) end
function gravestone_talk15(npc, ch) do_message(npc, ch, gravestone_data[15][3]) do_npc_close(npc, ch) end
function gravestone_talk16(npc, ch) do_message(npc, ch, gravestone_data[16][3]) do_npc_close(npc, ch) end
function gravestone_talk17(npc, ch) do_message(npc, ch, gravestone_data[17][3]) do_npc_close(npc, ch) end
function gravestone_talk18(npc, ch) do_message(npc, ch, gravestone_data[18][3]) do_npc_close(npc, ch) end
function gravestone_talk19(npc, ch) do_message(npc, ch, gravestone_data[19][3]) do_npc_close(npc, ch) end
function gravestone_talk20(npc, ch) do_message(npc, ch, gravestone_data[20][3]) do_npc_close(npc, ch) end
function gravestone_talk21(npc, ch) do_message(npc, ch, gravestone_data[21][3]) do_npc_close(npc, ch) end
function gravestone_talk22(npc, ch) do_message(npc, ch, gravestone_data[22][3]) do_npc_close(npc, ch) end
function gravestone_talk23(npc, ch) do_message(npc, ch, gravestone_data[23][3]) do_npc_close(npc, ch) end
function gravestone_talk24(npc, ch) do_message(npc, ch, gravestone_data[24][3]) do_npc_close(npc, ch) end
function gravestone_talk25(npc, ch) do_message(npc, ch, gravestone_data[25][3]) do_npc_close(npc, ch) end
function gravestone_talk26(npc, ch) do_message(npc, ch, gravestone_data[26][3]) do_npc_close(npc, ch) end
function gravestone_talk27(npc, ch) do_message(npc, ch, gravestone_data[27][3]) do_npc_close(npc, ch) end
function gravestone_talk28(npc, ch) do_message(npc, ch, gravestone_data[28][3]) do_npc_close(npc, ch) end
function gravestone_talk29(npc, ch) do_message(npc, ch, gravestone_data[29][3]) do_npc_close(npc, ch) end
function gravestone_talk30(npc, ch) do_message(npc, ch, gravestone_data[30][3]) do_npc_close(npc, ch) end
function gravestone_talk31(npc, ch) do_message(npc, ch, gravestone_data[31][3]) do_npc_close(npc, ch) end
function gravestone_talk32(npc, ch) do_message(npc, ch, gravestone_data[32][3]) do_npc_close(npc, ch) end
function gravestone_talk33(npc, ch) do_message(npc, ch, gravestone_data[33][3]) do_npc_close(npc, ch) end
function gravestone_talk34(npc, ch) do_message(npc, ch, gravestone_data[34][3]) do_npc_close(npc, ch) end
function gravestone_talk35(npc, ch) do_message(npc, ch, gravestone_data[35][3]) do_npc_close(npc, ch) end
function gravestone_talk36(npc, ch) do_message(npc, ch, gravestone_data[36][3]) do_npc_close(npc, ch) end
function gravestone_talk37(npc, ch) do_message(npc, ch, gravestone_data[37][3]) do_npc_close(npc, ch) end
function gravestone_talk38(npc, ch) do_message(npc, ch, gravestone_data[38][3]) do_npc_close(npc, ch) end
function gravestone_talk39(npc, ch) do_message(npc, ch, gravestone_data[39][3]) do_npc_close(npc, ch) end
function gravestone_talk40(npc, ch) do_message(npc, ch, gravestone_data[40][3]) do_npc_close(npc, ch) end
function gravestone_talk41(npc, ch) do_message(npc, ch, gravestone_data[41][3]) do_npc_close(npc, ch) end
function gravestone_talk42(npc, ch) do_message(npc, ch, gravestone_data[42][3]) do_npc_close(npc, ch) end
function gravestone_talk43(npc, ch) do_message(npc, ch, gravestone_data[43][3]) do_npc_close(npc, ch) end
function gravestone_talk44(npc, ch) do_message(npc, ch, gravestone_data[44][3]) do_npc_close(npc, ch) end
function gravestone_talk45(npc, ch) do_message(npc, ch, gravestone_data[45][3]) do_npc_close(npc, ch) end
function gravestone_talk46(npc, ch) do_message(npc, ch, gravestone_data[46][3]) do_npc_close(npc, ch) end
function gravestone_talk47(npc, ch) do_message(npc, ch, gravestone_data[47][3]) do_npc_close(npc, ch) end
function gravestone_talk48(npc, ch) do_message(npc, ch, gravestone_data[48][3]) do_npc_close(npc, ch) end
function gravestone_talk49(npc, ch) do_message(npc, ch, gravestone_data[49][3]) do_npc_close(npc, ch) end
