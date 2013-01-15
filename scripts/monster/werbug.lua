----------------------------------------------------------------------------------
--  Copyright 2011 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/libs/invertika"

local function update(mob)
  local r = math.random(0, 200);
  if r == 0 then
    being_say(mob, invertika.get_random_element(
      "Schlangeneier beim Großmarkthändler Fritz, ganz günstig nur jetzt.",
      "Extrasalat, Extrasalat nur jetzt für 99 Aki.",
      "Bezahlen sie heute, erhalten sie ihre Ware später, nur jetzt!",
      "Diese Anzeige wird ihnen präsentiert von Lokomodorol Injektin Tabletten.",
      "Nach dem nächsten Piepton, kaufen sie Energetika.",
      "Hop und Ex und der Tag ist ein Klecks.",
      "Nur bei ihrer Zentralbank, Zinsen auf ihr eingezahltes Guthaben. Eröffnet jetzt ein Konto.",
      "Gestresst? Dann ab in den Traumurlaub nach Quakari. Nur jetzt für 999 Aki."))
  end
end

local function strike(mob, victim, hit)
  if hit > 0 then
    being_say(mob, "Nimm dies! "..hit.." HP verloren!")
    being_say(victim, "Neeeiiiiiiiiiin!")
  else
    being_say(mob, "Mist, daneben.")
    being_say(victim, "Mhhhhh...")
  end
end

local werbug = get_monster_class("Werbug")
werbug:on_update(update)
werbug:on_damage(strike)
