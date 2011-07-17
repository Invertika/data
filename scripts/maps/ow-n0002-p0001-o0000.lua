----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2011 The Invertika Development Team                          --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/nethek"
require "scripts/libs/sign"

dofile("data/scripts/libs/warp.lua")

atinit(
function()
    create_inter_map_warp_trigger(19, 7, 17, 29) --- Intermap warp
    nethek.create_netheksaeule(162 * TILESIZE, 25 * TILESIZE + 16) --- Netheksäule

    sign_entrance = "Qakari"
    sign.create_sign(83, 188, sign_entrance) --- Schild Ortseingang
    sign.create_sign(95, 188, sign_entrance) --- Schild Ortseingang

    create_npc("Gabriel", 46, 59 * TILESIZE + 16, 160 * TILESIZE + 16, gabriel_talk, nil) --- Gabriel
    create_npc("Patrick", 46, 92 * TILESIZE + 16, 180 * TILESIZE + 16, patrick_talk, nil) --- kevin
    create_npc("Peter", 63, 109 * TILESIZE + 16, 167 * TILESIZE + 16, peter_talk, nil) --- Peter
    create_npc("Maximilian", 57, 86 * TILESIZE + 16, 139 * TILESIZE + 16, maximilian_talk, nil) --- 
end)


function gabriel_talk(npc, ch)
    do_message(npc, ch, "Ich bin Totengräber und habe schon lange keine neuen Aufträge mehr bekommen. Warum mussten auch die Untoten über die Stadt kommen. Mir tun sie komischerweise nichts. Vielleicht, weil ich Ihre Gräber schon seit langem pflege? Manchmal habe ich das Gefühl, sie wollen mit mir sprechen, aber wenn ich zu ihnen gehe und versuche ihnen zuzuhören, stammeln sie nur unverständliches Gemurmel.")
    do_npc_close(npc, ch)
end

function patrick_talk(npc, ch)
    do_message(npc, ch, "Hallo Fremder, willkommen in Qakari. Sei aber vorsichtig in der Umgebung dieser Stadt; die Untoten reagieren Fremden gegenüber nicht sehr freundlich. Solltest du den Mut haben in die Stadt zu gehen, sei noch vorsichtiger. Auch wenn sie schon gestorben sind, haben sie etwas dagegen, wenn die Gräber von unbekannten Personen besucht werden.")
    do_npc_close(npc, ch)
end


function peter_talk(npc, ch)
    do_message(npc, ch, "Ich erinnere mich noch, als wäre es gestern gewesen, als ich hier mit meinem Bruder aufgewachsen bin. Warum ist er nur so früh gestorben? Seit er untot ist, kann ich mich nicht mehr richtig mit ihm unterhalten.")
    do_npc_close(npc, ch)
end


function maximilian_talk(npc, ch)
    do_message(npc, ch, "Ich frage mich schon lange, wie man untot wird. Die Untoten selber wollen oder können es nicht verraten und in meinen Zauberbüchern steht es nicht drin.")
    do_message(npc, ch, "Hmm...")
    do_message(npc, ch, "Vielleicht liegt es daran, dass ich die Bücher von einem eigenartigem Mann abgekauft habe, der hier mal vorbeikam. Bisher hat noch kein Zauber daraus geklappt. Aber ich habe auch noch nie einen Beweis gesehen, dass je ein Zauber auf Amoneus funktioniert hat. Erzählen können sich die Leute viel.")
    do_npc_close(npc, ch)
end
