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
require "scripts/libs/datetime"
require "scripts/libs/invertika"
require "scripts/libs/nethek"
require "scripts/libs/sign"

require "scripts/libs/warp"


illegalCount=0;

local function wache_trigger(ch, id)
   if (being_type(ch) ~= TYPE_MONSTER) then --- Nur Player durchlassen
     local count = chr_inv_count(ch, 40010)
     
     if count == 0 then
       local x = posX(ch)
       local y = posY(ch)
       chr_warp(ch, get_map_id(), x, 90 * TILESIZE) 
       
       being_say(wache, invertika.get_random_element("Keinen Schritt weiter!",
      "Verlassen sie sofort dieses Gelände!",
      "Kein Zutritt!"))
       
       illegalCount=illegalCount+1
       
       being_damage(ch, 500, 250, 10075, 0, 0)
     else
       if illegalCount==0 then
         being_say(wache, invertika.get_random_element("Willkommen Sir.",
        "Sir.",
        "Keine besonderen Vorkommnise, Sir."))
       else
         being_say(wache, "Sir, es wurden " + tostring(illegalCount) + " illegale Übertritte registriert.")
         illegalCount=0
       end
     end
  end
 end
 
local function wache_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Verschwinden Sie!",
        "Kein Zutritt!"))
end

atinit(function()
 create_inter_map_warp_trigger(70, 82, nil, 60) --- Intermap warp
 nethek.create_netheksaeule(96 * TILESIZE, 113 * TILESIZE + 16) --- Netheksäule
 
 -- Schilder
 local signText="Sperrgebiet! Betreten sowie Fotographie verboten! Wachen sind zur Anwendung tödlicher Gewalt befugt!"
 sign.create_sign(78, 100, signText) -- Warnschild
 sign.create_sign(78, 93, signText) -- Warnschild
 sign.create_sign(78, 86, signText) -- Warnschild
 sign.create_sign(78, 79, signText) -- Warnschild
 sign.create_sign(78, 72, signText) -- Warnschild
 sign.create_sign(86, 72, signText) -- Warnschild
 sign.create_sign(96, 72, signText) -- Warnschild
 sign.create_sign(106, 72, signText) -- Warnschild
 sign.create_sign(115, 72, signText) -- Warnschild
 sign.create_sign(126, 72, signText) -- Warnschild
 sign.create_sign(135, 72, signText) -- Warnschild
 sign.create_sign(135, 78, signText) -- Warnschild
 sign.create_sign(135, 84, signText) -- Warnschild
 sign.create_sign(135, 92, signText) -- Warnschild
 sign.create_sign(135, 99, signText) -- Warnschild

 -- Wachen
 wache = npc_create("Wache", 29, GENDER_UNSPECIFIED, 96 * TILESIZE + 16, 96 * TILESIZE + 16, wache_talk, nil) --- Wache
 npc_create("Wache", 29, GENDER_UNSPECIFIED, 106 * TILESIZE + 16, 96 * TILESIZE + 16, wache_talk, nil) --- Wache
 
 -- Trigger für die Überwachung des Torbereiches
 trigger_create(98 * TILESIZE, 93 * TILESIZE, 7 * TILESIZE, 6 * TILESIZE, wache_trigger, 1, true) --- Trigger Tor
 
end)
