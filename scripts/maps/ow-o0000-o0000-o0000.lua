-- Externe Map Skripting Datei
-- In dieser Datei stehen die entsprechenden externen NPCs, Trigger und anderer Dinge.
--
-- © 2008-2011 by The Invertika Development Team
--
-- This file is part of Invertika. Invertika is free software; you can redistribute
-- it and/or modify it under the terms of the GNU General  Public License as published
-- by the Free Software Foundation; either version 3 of the License, or any later version.

require "scripts/lua/npclib"
require "scripts/libs/datetime"
require "scripts/libs/invertika"
require "scripts/libs/nethek"
require "scripts/libs/seller"
require "scripts/libs/sign"

require "scripts/libs/warp"


--Zeitabhägige Events
-- Weihnachten
local function weihnachtsmann_talk(npc, ch)
    invertika.init_quest_status(ch, "selphi_timlet_santa_clause")

    -- quest get/set functions
    local function get_qstatus() return invertika.get_quest_status(ch, "selphi_timlet_santa_clause") end
    local function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_santa_clause", x) end

    if get_qstatus()==0 then
      npc_message(npc, ch, "Ho Ho Ho. Ich bin der Weihnachtsmann. Meine Geschenke sind schon wieder überall verteilt. Diese Weihnachtsschleime rauben mir den letzten Nerv. Magst du mir helfen sie wieder einzusammeln?")

      while true do
            local v = npc_choice(npc, ch, "Ja.", "Nein.")

          if v == 1 then
            npc_message(npc, ch, "Das ist super ich denke so 25 Stück sollten mir reichen. Ich warte dann hier auf dich.")
            set_qstatus(1)
            break
          elseif v == 2 then
            npc_message(npc, ch, "Schade, dann halt nicht...")
            break
          end
      end
    elseif get_qstatus()==1 then
      local count13 = chr_inv_count(ch, 40013)
      local count14 = chr_inv_count(ch, 40014)
      local count15 = chr_inv_count(ch, 40015)

      local countAll=count13+count14+count15;

      if countAll >= 25 then
        --Nachricht
        npc_message(npc, ch, "Du hast es wirklich geschafft. Ich danke dir. Na das schreit ja geradezu nach einer Belohnung. Da habe ich doch einige Sachen für dich.")

        --Weihnachtsgeschenke entfernen
        invertika.add_items(ch, 40013, -count13, "grünes Geschenk")
        invertika.add_items(ch, 40014, -count14, "blaues Geschenk")
        invertika.add_items(ch, 40015, -count15, "lila Geschenk")

        --Belohnung
        invertika.add_items(ch, 20010, 1, "Santa Clause Mütze")
        invertika.add_items(ch, 30021, 10, "Zuckerstange")
        invertika.add_items(ch, 30022, 10, "Weihnachtskuchen")
        invertika.add_items(ch, 30023, 10, "Lebkuchenmänchen")
        invertika.add_items(ch, 40020, 1, "5000 Aki Scheck")
        set_qstatus(2)
      else
        npc_message(npc, ch, invertika.get_random_element("Na ein paar Geschenke fehlen da noch.",
         "Ich brauche mindestens 25 Geschenke.",
         "Ein paar Weihnachtsschleime wirst du schon noch erledigen müssen."))
      end
    elseif get_qstatus()==2 then
      npc_message(npc, ch, invertika.get_random_element("Danke für deine Hilfe. Wir sehen uns dann nächstes Jahr wieder.",
      "So alle Geschenke wieder sicher verstaut.",
      "Schön das du es den Weihnachtsschleimen mal gezeigt hast.",
      "Nun habe ich für dieses Jahr wieder meine Ruhe.",
      "Jetzt muss ich die Geschenke nur noch verteilen.",
      "Danke für deine großartige Hilfe."))
    end

end

local function rentier_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Mmmmmpppfh.",
        "Bsssss.",
        "Brrrrrr.",
        "Schnauf."))
end

-- Silvester
local function fireworker_talk(npc, ch)
  npc_message(npc, ch, invertika.get_random_element(
    "Willst du ein wenig Feuerwerk sehen?",
    "Willst du ein kleines Feuerwerk sehen?",
    "Möchtest du ein kleines Feuerwerk sehen?",
    "Möchtest du ein wenig Feuerwerk sehen?",
    "Möchtest du dir ein kleines Feuerwerk anschauen?",
    "Möchtest du dir ein wenig Feuerwerk anschauen?",
    "Willst du ein kleines Feuerwerk betrachten?",
    "Auf deinen Wunsch hin, beschwöre ich den Gott des Feuerwerkes, und dieser wird es mächtig krachen lassen!"))
  local answer = npc_choice(npc, ch, "Juhuu! Feuerwerk!", "Nee, danke.")
  if answer == 1 then
    local x = posX(npc)
    local y = posY(npc)
      for c = 0, 25 do
        schedule_in (c, function()
          effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
          effect_create(math.random(0, 25), x + math.random(-200, 200), y + math.random(-200, 200))
        end)
      end
  end
end

-- Normale Events
 local function get_wache_say()
        return invertika.get_random_element("Ohne Passierschein geht es hier nicht durch!",
      "Durchgang nur mit Passierschein!",
      "Du hast keinen Passierschein. Deshalb darfst du den Palast nicht betreten!",
      "Halt, du benötigst einen Passierschein!")
 end

 local function wache_trigger(ch, id)
   if (being_type(ch) == TYPE_CHARACTER) then --- Nur Player durchlassen
     local count = chr_inv_count(ch, 40009)

     if count == 0 then
       local x = posX(ch)
       chr_warp(ch, get_map_id(), x, 70 * TILESIZE)

       if (id == 1) then
         being_say(wache1, get_wache_say())
       elseif (id == 2) then
         being_say(wache2, get_wache_say())
       end
     end
  end
 end

local function elmo_talk(npc, ch)
    npc_message(npc, ch, "Willkommen in Selphi Timlet, der Stadt in der Wüste. Sei nett zu den anderen und habe viel Spaß!")
end

local function sam_talk(npc, ch)
    npc_message(npc, ch, "Hi ich bin Sam und ich bin auf der Suche nach der Antwort...")
end

local function julia_talk(npc, ch)
    npc_message(npc, ch, "Hi, was kann ich für dich tun?")

    while true do
        local v = npc_choice(npc, ch, "Kaufen.",
                         "Verkaufen.",
                         "Nichts. Danke.")

        if v == 1 then
            npc_trade(npc, ch, false, { {10001, 10, 19}, {10013, 10, 159}, {10002, 10, 997}, {20001, 10, 30}, {20002, 10, 50}, {20011, 10, 30}, {20012, 10, 30}, {20013, 10, 30}, {20014, 10, 30}, {20015, 10, 50}, {20016, 10, 50}, {20017, 10, 50}, {20018, 10, 50}  })
            break
        elseif v == 2 then
            npc_trade(npc, ch, true)
            break
        elseif v == 3 then
            npc_message(npc, ch, "Ich wünsche dir noch viel Spaß!")
            break
        end
    end
end

local function jane_talk(npc, ch)
    npc_message(npc, ch, string.format("Wie spät es ist? Ähm es ist %s Uhr. Und bevor du fragst, heute ist der %s im übrigen ist das ein %s.", datetime.get_current_time(), datetime.get_current_date(), datetime.get_current_weekday()))
end

local function bruce_talk(npc, ch)
  -- quest init
  invertika.init_quest_status(ch, "selphi_timlet_bruce_quest")
  -- quest get/set functions
  local function get_qstatus() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_bruce_quest")) end
  local function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_bruce_quest", tonumber(x)) end

    if get_qstatus()==0 then
        invertika.add_money(ch, 1000)
        set_qstatus(1)
        npc_message(npc, ch, "Ahhh ich verstehe, du bist neu hier. Hier ein paar Münzen fuer den Anfang...")
    elseif get_qstatus()==1 then
    npc_message(npc, ch, "Siehst du die Maden auf den Straßen? Die reinste Plage! Dieses gefräßige Ungeziefer vernichtet das letzte bisschen Vegetation in der Stadt! Willst du uns helfen, unsere schöne Stadt von diesen ekelhaften Würmern zu befreien?")
    set_qstatus(npc_choice(npc, ch, "Nein.","Ja."))
  end
  if get_qstatus()==2 then
    npc_message(npc, ch, "Bring mir 20 Madenschleim als Beleg für deine Arbeit, dann werde ich dich belohnen.")
    set_qstatus(3)
  elseif get_qstatus()==3 and chr_inv_count(ch, 40005) < 20 then
    npc_message(npc, ch, "Bring mir 20 Madenschleim als Beleg für deine Arbeit, dann werde ich dich belohnen.")
  elseif get_qstatus()==3 and chr_inv_count(ch, 40005) >= 20 then
    npc_message(npc, ch, "Fabelhaft, du hast 20 Madenschleim gesammelt! Danke für deine Hilfe.")
    invertika.add_items(ch, 40005, -20, "Madenschleim")
    invertika.add_exp(ch, 100, 750, 0)
    chat_message(ch, "Du hast 750 Exp im unbewaffneten Kampf erhalten!")
    set_qstatus(4)
  elseif get_qstatus()==4 then
    npc_message(npc, ch, "In der Spielothek findet Danielas Geburtstagsparty statt. Bist du so nett, und bringst ihr mein Geschenk? Ich habe dort Hausverbot, weil ich meine Spielschulden nicht bezahlt habe.")
    set_qstatus(npc_choice(npc, ch, "Nein.","Ja.")+3)
    if get_qstatus()==5 then
      invertika.add_items(ch, 40015, 1, "Geschenk")
      npc_message(npc, ch, "Sehr nett von dir. Die Spielothek ist im süd-westlichen Teil der Stadt. Gib Daniela das Geschenk.")
    end
  elseif get_qstatus()==5 then
    npc_message(npc, ch, "Die Spielothek ist im süd-westlichen Teil der Stadt. Gib Daniela das Geschenk.")
  elseif get_qstatus()==6 then
    npc_message(npc, ch, "Sie hat sich über ihr Geschenk gefreut? Danke, du hast mir sehr geholfen! Nimm diese Flasche Pangalaktischen Donnergurgler als Dank.")
    invertika.add_items(ch, 30008, 1, "Flasche Pangalaktischen Donnergurgler")
    set_qstatus(7)
  elseif get_qstatus()==7 then
    npc_message(npc, ch, "Lust auf eine neue Herausforderung?")
    invertika.add_items(ch, 40002, 1, "IP-Paket")
    set_qstatus(8)
    npc_message(npc, ch, "Ich brauche 50 Skorpionstachel, um ein Faß Wurzelhans zu brauen. Lass dich nicht stechen.")
  elseif get_qstatus()==8 then
    if chr_inv_count(ch, 40004) >= 50 then
      npc_message(npc, ch, "Das hast du gut gemacht! Nimm diesen Hut als Dank!")
      invertika.add_items(ch, 40004, -50, "Skorpionstachel")
      invertika.add_items(ch, 20004, 1, "Hut")
      set_qstatus(9)
    else
      npc_message(npc, ch, "Ich brauche 50 Skorpionstachel. Nicht mehr, und nicht weniger!")
    end
  elseif get_qstatus() == 9 then
    npc_message(npc, ch, "*hust* *hust* *räusper*")
    npc_message(npc, ch, "Mir geht es nicht so gut.")
    npc_message(npc, ch, "Ich muss mir wohl hier in der prallen Hitze eine Erkältung eingefangen haben...")
    npc_message(npc, ch, "Wäre nett wenn du mir ein paar Tabletten besorgen könntest.")
    npc_message(npc, ch, "Diese Energetia sollten ihre Aufgabe tun.")
    npc_message(npc, ch, "Besorg mir doch bitte ein paar von ihnen.")
    set_qstatus(10)
  elseif get_qstatus() == 10 then
    local count = chr_inv_count(ch, 30018)
    if count >= 3 then
        npc_message(npc, ch, "Du hast die Tabletten gegen meinen Husten.")
        npc_message(npc, ch, "Gibst du sie mir?")
        while true do
            local v = npc_choice(npc, ch, "Ja.", "Nein.")
            if v == 1 then
                if invertika.add_items(ch, 30018, -3, "Energetia") then
                    set_qstatus(11)
                    npc_message(npc, ch, "Danke. Das wird meinem Husten helfen.")
                    npc_message(npc, ch, "Nimm dies als Unkostenerstattung.")
                    invertika.add_money(ch, 700)
                end
                break
            else
                npc_message(npc, ch, "Schade.")
                break
            end
        end
    elseif count > 0 then
        npc_message(npc, ch, "Mit so wenigen Tabletten komme ich nicht weit. *Hust*")
    else
        npc_message(npc, ch, "*Hust* *räusper* Hol mir doch bitte ein paar *hust* Tabletten gegen meinen Husten.")
        npc_message(npc, ch, "Diese Energetia sollten es tun.")
    end
  elseif get_qstatus()>=11 then
    npc_message(npc, ch, "Ich habe momentan keine Aufgabe für dich.")
  end

end

local function felix_talk(npc, ch)
    local quest_string = "selphi_timlet_felix_quest"
    invertika.init_quest_status(ch, quest_string)
    local get_qstatus = function() return invertika.get_quest_status(ch, quest_string) end
    local set_qstatus = function(x) invertika.set_quest_status(ch, quest_string, x) end

    if get_qstatus() == 0 then
        npc_message(npc, ch, invertika.get_random_element("Hallo Reisender.", "Guten Tag.", "Hallo.", "Schönes Wetter nicht?"))
        npc_message(npc, ch, "Hättest du Lust für mich etwas zu erledigen?")
        while true do
            local v = npc_choice(npc, ch, "Ja.", "Nein.")
            if v == 1 then
                npc_message(npc, ch, "Ich habe einen alten Freund. Er ist Statiker in Alexia und berechnet Häuser. Sein Name ist Vektor.")
                npc_message(npc, ch, "Er ist zwar nicht der beste aber andere kann ich nicht bezahlen. Er soll das Haus meines Bruders berechnen.")
                npc_message(npc, ch, "Falls du mal nach Alexia kommst kannst du ihm mal Bescheid sagen.")
                npc_message(npc, ch, "Wobei ich die Statik total überbewertet finde.")
                npc_message(npc, ch, "Alles muss genau passen...")
                npc_message(npc, ch, "Dabei interressiert mich reichlich wenig ob ich weiß, dass mein Haus bei 1kg Schnee pro m² zusammenbricht oder nicht. Wann gibt es hier in der Wüste mal Schnee?")
                npc_message(npc, ch, "Völlig überbezahlt der Beruf!")
                npc_message(npc, ch, "Ja, so ist das wohl.")
                npc_message(npc, ch, "Was stehst du hier noch? Du wolltest doch nach Alexia, oder?")
                set_qstatus(1)
                break
            elseif v == 2 then
                break
            end
        end
    elseif get_qstatus() == 1 then
        npc_message(npc, ch, "Wolltest du nicht nach Alexia?")
    elseif get_qstatus() == 2 then
        npc_message(npc, ch, "Danke, dass du Vektor Bescheid gesagt hast.")
        npc_message(npc, ch, "Ich habe hier ein wenig Porzellan Geschirr von Übersee.")
        npc_message(npc, ch, "Nix Wert das Zeug. Nimm du es.")
        invertika.add_items(ch, 40039, 27, "Teller aus Porzellan")
        set_qstatus(3)
    else
        npc_message(npc, ch, invertika.get_random_element("Ja so ist das wohl.",
          "Ich weiß nicht, so schönes Wetter.",
          "Ein Königreich für einen Keks.",
          "Mmm was mache ich jetzt bloß ohne Regenschirm.",
          "Ich muss es tun, jetzt sofort.",
          "Die da du di da?",
          "Wie bitte?",
          "Nicht zu fassen. Überall diese Dingsbums.",
          "Kommt der Sommer schnell und heiß, ähm dann weiß ich auch nicht.",
          "Invertika, ja da war was.",
          "Kann schon sein, muss aber nicht.",
          "Es könnte sein das es stimmt, dann müsste der Fakt das es nicht stimmt aber eine große Rolle spielen da es ja stimmt und gleichzeitig nicht stimmt. Mhn... aber was wäre wenn...",
          "Ich bin Felix und wer bist du?",
          "Mus mus mus. Jaaaaa. Biene fliegt rückwärts.",
          "Mein Kontrabass ist kaputt, aber es lag nicht am Backofen.",
          "Durch die Sonne scheint es immer hell.",
          "Es ist groß und grün.",
          "Je gelber das Telefon desto Hallo. Doch was ist ein Telefon?",
          "Der Frosch wurde rot, denn er war tot.",
          "Fische füttern fördert den Verstand."))
    end
end

local function saria_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Die Wüste ist riesig, drum bleib ich hier.",
      "Hüte dich vor der Wüste. Dort treiben rote Skorpione ihr Unwesen.",
      "Ey da nicht anfassen, da habe ich einen Sonnenbrand.",
      "Alle meine Skorpione, sind in der Wüste.",
      "Ich liebe Städte mit Mauern.",
      "Ich würde mal gerne zum Meer."))
end

local function nobur_talk(npc, ch)
        invertika.init_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers")

    npc_message(npc, ch, "Ich brauche Skorpionstachel. Eine ganze Menge, so zwei Dutzend oder drei, vielleicht auch vier Dutzend. Das wird eine leckere Suppe.")

    local count = chr_inv_count(ch, 40004)

    if count > 0 then
      npc_message(npc, ch, "Ich sehe du hast ein paar Stachel. Magst du sie mir geben?")

          while true do
        local v = npc_choice(npc, ch, "Ja",
                                     "Nein")

        if v == 1 then
            if (invertika.get_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers") == 0) then
              invertika.set_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers", count)
            else
              local dbcount = invertika.get_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers");
              dbcount = dbcount + count
              invertika.set_quest_status(ch, "selphi_timlet_norbur_scorpion_stingers", dbcount)

              if dbcount > 200 then
                npc_message(npc, ch, "Also wenn ich es mir recht überlege, habe ich schon genug Stachel. Trotzdem danke.")
                break;
              end
            end

            invertika.add_items(ch, 40004, -count, "Skorpionstachel")

            if count < 10 then
              npc_message(npc, ch, "Nimm diese Münzen als Dank.")
              invertika.add_money(ch, 50)
              break;
            elseif count < 20 then
              npc_message(npc, ch, "Nimm diese Münzen als Dank.")
              invertika.add_money(ch, 150)
              break;
            elseif count < 30 then
              npc_message(npc, ch, "Nimm diese Münzen als Dank.")
              invertika.add_money(ch, 350)
              break;
            elseif count < 40 then
              npc_message(npc, ch, "Nimm diese Münzen als Dank.")
              invertika.add_money(ch, 500)
              break;
            elseif count < 150 then
              npc_message(npc, ch, "Nimm diesen lustigen Hut als Dankeschön.")
              invertika.add_items(ch, 20004, 1, "lustiger Hut")
              break;
            elseif count >= 150 then
              npc_message(npc, ch, "Nimm diese Münzen als Dank.")
              invertika.add_money(ch, 2500)
              break;
            end

            break
        elseif v == 2 then
            npc_message(npc, ch, "Okay dann muss ich weiter suchen.")
            break
        end
    end

    end
end

local function alex_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Siehst du ihn? Ist er hier irgendwo? Nicht das es mich findet, also pssst!",
      "Was machst du hier? Nicht das du ihn zu mir führst...",
      "Wen ich meine? Na Bahamut.",
      "Ich halte es nicht mehr aus, aber hier bin ich sicher.",
      "Siehst du ihn? Ich sehe ihn überall, hinter jeder Ecke.",
      "Gehörst du zu ihm? Wenn ja dann verschwinde!"))
end

local function inard_talk(npc, ch)
    invertika.init_quest_status(ch, "selphi_timlet_inard_training");
    invertika.init_quest_status(ch, "selphi_timlet_orkana_feierabend");

    -- quest get/set functions
    local function get_qstatus() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_inard_training")) end
    local function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_inard_training", tonumber(x)) end

    local function get_feierabend() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_orkana_feierabend")) end

    if get_qstatus() == 0 then
        npc_message(npc, ch, "Ahhh. Was ein herrlicher Tag und ich hänge hier im Innenhof rum! Wie gerne würde ich mal wieder eine Stunde trainieren!")
        while true do
            local v = npc_choice(npc, ch, "Ich könnte mit dir trainieren.", "Auf Wiedersehen")
            if v == 1 then
                npc_message(npc, ch, "Du? Dich kenne ich doch kaum. Aber du könntest zu Ortana laufen und ihn fragen wann er mal Zeit hat.")
                while true do
                    v2 = npc_choice(npc, ch, "Mach ich!", "Da habe ich grade keine Zeit für.")
                    if v2 == 1 then
                        npc_message(npc, ch, "Danke. Du findest ihn bei der Arena.")
                        set_qstatus(1)
                        break
                    elseif v2 == 2 then
                        npc_message(npc, ch, "Schade.")
                        break
                    end
                end
                break
            elseif v == 2 then
                npc_message(npc, ch, "Schönen Tag noch.")
                break
            end
        end
    elseif get_qstatus() == 1 then
        npc_message(npc, ch, invertika.get_random_element("Wolltest du nicht zu Ortana und ihn fragen ob er Lust hat mit mir zu trainieren?",
                                                         "Ortana findest du an der Arena beim Besuchereingang."))
    elseif get_qstatus() == 2 then
        npc_message(npc, ch, "Ortana weiß nicht wann er frei hat? Dann frag seinen Chef, Estech. Du findest ihn vermutlich im VIP-Bereich der Arena.")
    elseif get_qstatus() == 3 then
        npc_message(npc, ch, "Das du weißt wann er frei hat bringt mir nicht viel. Geh zu ihn und frag ihn ob es ihm passt.")
    elseif get_qstatus() == 4 then
        npc_message(npc, ch, "Und wann hat er Zeit?")
        while true do
            local v = npc_choice(npc, ch, "Um 10 Uhr.", "Um 15 Uhr.", "Um 20 Uhr.")
            if v == get_feierabend() then
                npc_message(npc, ch, "Ok. Danke. Hier nimm diesen Ring als Dank.")
                invertika.add_items(ch, 20005, 1, "Ring der Stärke")
                set_qstatus(5)
                break
            else
                npc_message(npc, ch, "Das glaube ich nicht! Ortana hat nie zu dieser Zeit frei. Frag am besten nochmal nach.")
                break
            end
        end
    else
        npc_message(npc, ch, invertika.get_random_element("Ach ja... Ich mach erstmal ne Pause.", "Danke für die Hilfe.", "Genug trainiert."))
    end
end

local function belart_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Ich komme aus Narva. Es ist schön dort. Ich vermisse es ein wenig.",
      "Hast du schonmal Unbal getrunken? Es ist köstlich.",
      "Ich hatte mal eine wunderschöne Rüstung. Leider musste ich sie verkaufen.",
      "Du siehst aus als wenn du neu hier bist. Willkommen in Selphi Timlet.",
      "Ich kannte mal jemanden der sah fast so aus wie du. Aber das ist lange her.",
      "Mein Name ist Belart und ich komme aus Narva. Und du?"))
end

local function imangi_talk(npc, ch)
    invertika.init_quest_status(ch, "twin_house_quest")
    local q_status = invertika.get_quest_status(ch, "twin_house_quest")
    if q_status == 3 then
        if chr_inv_count(ch, 20019) > 0 then
            npc_message(npc, ch, "Möchtest du mir etwas sagen?")
            while true do
                local v = npc_choice(npc, ch, "Ich habe hier einen Ring für dich.", "Nein. nichts.")
                if v == 1 then
                    invertika.set_quest_status(ch, "twin_house_quest", 4)
                    invertika.add_items(ch, 20019, -1, "Imangis's Verlobungsring")
                    npc_message(npc, ch, "Wie... ein Ring...?")
                    npc_message(npc, ch, "Er möchte mich Heiraten?")
                    npc_message(npc, ch, "ich... ich...")
                    npc_message(npc, ch, "*nach Luft schnapp*")
                    npc_message(npc, ch, "muss nachdanken!")
                    npc_message(npc, ch, "Bitte sag ihm das...")
                    npc_message(npc, ch, "Nimm diese Äpfel als Dank.")
                    invertika.add_items(ch, 30012, 10, "Äpfel")
                    break
                elseif v == 2 then
                    break
                end
            end
        end
    elseif (q_status == 4) or (q_status == 5) then
        npc_message(npc, ch, "Ich freue mich schon ihn zu treffen.")
    else
        npc_message(npc, ch, invertika.get_random_element("Ich verkaufe nichts.",
        "Hier gibt es nichts zu sehen.",
        "Ich kann dir nicht helfen.",
        "Geh weg.",
        "Ich kenne dich nicht, also will ich auch nix mit dir zu tun haben.",
        "Nein, nein, nein und nochmal nein."))
    end
end

local function ortana_talk(npc, ch)
    invertika.init_quest_status(ch, "selphi_timlet_inard_training");
    invertika.init_quest_status(ch, "selphi_timlet_orkana_feierabend");

    local function get_qstatus() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_inard_training")) end
    local function set_qstatus(x) invertika.set_quest_status(ch, "selphi_timlet_inard_training", tonumber(x)) end
    local function get_feierabend() return tonumber(invertika.get_quest_status(ch, "selphi_timlet_orkana_feierabend")) end

    if get_qstatus() == 1 then
        npc_message(npc, ch, "Inard möchte mit mir trainieren? Hm. Sicher hab ich Lust. Ich weiß nur nicht wann ich frei bekomme. Frag doch bitte mal meinen Chef Estech. Du findest ihn in der Arena, vermutlich im VIP-Bereich.")
        set_qstatus(2)
    elseif get_qstatus() == 2 then
        npc_message(npc, ch, "Frag meinen Chef Estech. Der kann dir sagen wann ich frei habe. Du findest ihn in der Arena.")
    elseif get_qstatus() == 3 then
        npc_message(npc, ch, "Und was meinte er wann ich gehen dürfte?")
        while true do
            local v = npc_choice(npc, ch, "Um 10 Uhr.", "Um 15 Uhr.", "Um 20 Uhr.")
            if v == get_feierabend() then
                npc_message(npc, ch, "Danke. Sag Inard das ich komme.")
                set_qstatus(4)
                break
            else
                npc_message(npc, ch, "Das glaube ich nicht! Ich habe nie zu dieser Zeit frei. Frag am besten nochmal nach.")
                break
            end
        end
    elseif get_qstatus() == 4 then
        local zeit = nil
        if get_feierabend() == 1 then
            zeit = "10"
        elseif get_feierabend() == 2 then
            zeit = "15"
        else
            zeit = "20"
        end
        npc_message(npc, ch, string.format("Wann war das nochmal? Ach genau %s Uhr.", zeit))
    elseif get_qstatus() == 5 then
        npc_message(npc, ch, "Inard freut sich? Ich hoffe die ganze Aufregung hat dir nicht zu viel ausgemacht.")
        set_qstatus(6)
    else
        npc_message(npc, ch, invertika.get_random_element("Ich kämpfe ab und zu in der Arena.",
           "Nichts ist so bedeutsam wie der nächste Kampf.",
           "Früher wollte ich Magier werden, aber naja so ist das Leben.",
           "Mein Schwert ist ein Unikat. Es stammt aus der Schmiede von Bolux van Nar.",
           "Schwerthieb auf Schwerthieb, und dann sah ich wie er seine Deckung fallen ließ und nutzte meine Chance. Ein toller Kampf war das.",
           "Das erste Mal sah ich das Colloseum vor 6 Jahren. Das war kurz nachdem es mich nach Selphi Timlet zog."))
    end

end

local function tonver_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Oh nein, ich habe schon wieder alles verspielt.",
      "Ich lasse viel zu viel Geld in diesem Laden.",
      "Nur noch 47 Aki. Naja das muss reichen.",
      "Das nächste Mal gewinne ich ganz bestimmt.",
      "Wenn ich 5 Aki setze und gewinne dann habe ich danach ein paar Aki mehr. Glaube ich...",
      "Alles weg... Schon wieder... Aber beim nächsten mal... Da gewinne ich..."))
end

local function elmes_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Manche Leute rennen im Kreis durch diese Bögen. Warum auch immer sie dies tun.",
      "Ich genieße die Sonne. Deshalb der Hut.",
      "Früher als ich noch jung war, da hatte ich mal einen Kater. Doch er ward eines Tages verschwunden. Er hieß Effendi. Wo er wohl sein wird?",
      "Man erzählt sich von einem Schatz in der Wüste, verborgen in einer Höhle welche tief unter die Erde führt. Oder war die Höhle in der grünen Ebene? Ich weiß es nicht mehr genau.",
      "Das letze mal als es regnete versank ich im Sand. Ich konnte mich erst nach 4 Stunden befreien.",
      "Sei vorsichtig wenn du dich durch die große Wüste begibst."))
    -- Hinweis auf Torbögen => Quest freischalten
    invertika.init_quest_status(ch, "selphi_timlet_archway_quest")
end

local function nepuret_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Ich bin Nepuret.",
      "Das ist das Haus von Averin, dem Chef der königlichen Palastwache.",
      "Ich bewache dieses Haus.",
      "Nein, ich stehe hier nicht zum Spaß. Ich achte darauf das niemand gefährliches sich diesem Haus nähert.",
      "Man muss immer achtsam sein, sonst ist man plötzlich weg vom Fenster.",
      "Ich diene bereits seit vielen Jahren als persönliche Wache von Averin."))
end

local function nero_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Wo man den königlichen Passierschein bekommt? Ja das weiss ich *kicher*.",
      "Averin vergibt die königlichen Passierscheine.",
      "Ja, ich habe einen königlichen Passierschein! Ob du ihn bekommst? Nein, besorge dir selber einen!",
      "Averin... la la la - Frag dort!",
      "Ich habe es mit dem Feuer... ich kann nicht von ihm lassen.",
      "Averin ist die Person mit der du reden solltest, nicht ich!"))
end

local function colloseumwache_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Das ist das Colloseum auch die Arena genannt.",
      "In der Arena finden Kämpfe statt, manchmal zumindestens.",
      "Aergius war ein großer Kämpfer, bis er fort ging.",
      "Achte auf deine Deckung, sonst kann es dich ganz böse erwischen.",
      "Du siehst stark aus, vielleicht könntest du ein Kämpfer werden?"))
end

local function bankwache_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Wir bewachen die Zentralbank.",
      "Dies ist die Zentralbank. Hier wird eine Menge Geld gelagert.",
      "Wir passen auf das niemand in die Bank einbricht.",
      "Dank uns gab es noch nie einen Einbruch in der Zentralbank.",
      "Denk immer daran: Wir behalten dich im Auge."))
end

local function stadtwache_talk(npc, ch)
    local quest_string_number = "selphi_timlet_guards_hunt_number"
    local quest_string_monsterid = "selphi_timlet_guards_hunt_monsterid"
    local quest_string_monster_name = "selphi_timlet_guards_hunt_monstername"
    local quest_string_kills = "selphi_timlet_guards_hunt_kills"

    invertika.init_quest_status(ch, quest_string_number)
    invertika.init_quest_status(ch, quest_string_kills)
    invertika.init_quest_status(ch, quest_string_monsterid)

    local number_of_jobs = invertika.get_quest_status(ch, quest_string_number)
    local new_job = false

    if number_of_jobs == 0 then
        npc_message(npc, ch, "Wir garantieren hier die Sicherheit der Stadt.")
        npc_message(npc, ch, "Übrigens. Der König zahlt regelmäßig Prämien wenn du Ungeziefer tötest.")
        npc_message(npc, ch, "Was zur Zeit getötet werden soll erfährst du bei uns.")
        npc_message(npc, ch, "Wir verteilen auch die Belohnungen.")

        number_of_jobs = number_of_jobs + 1
        invertika.set_quest_status(ch, quest_string_number, number_of_jobs)
        new_job = true
    end

    local required_kills = invertika.get_quest_status(ch, quest_string_kills)

    if required_kills ~= 0 then
        local kills = chr_get_kill_count(ch, invertika.get_quest_status(ch, quest_string_monsterid))
        if kills >= required_kills then
            number_of_jobs = number_of_jobs + 1
            invertika.set_quest_status(ch, quest_string_number, number_of_jobs)
            npc_message(npc, ch, "Danke, dass du die Monster getötet hast. Die Viecher wurden eine echte Plage!")
            invertika.add_money(ch, number_of_jobs * 100)
            new_job = true
        else
            npc_message(npc, ch, string.format("Du musst noch %s %s töten bevor es eine Belohnung gibt.", required_kills - kills, invertika.get_quest_status_string(ch, quest_string_monster_name)))
        end
    end

    if new_job then
        local monster = nil
        if number_of_jobs < 5 then
            monster = { {id=2, name="Maden", factor=11},
              {id=3, name="Skorpione", factor=9},
              {id=6, name="rote Skorpione", factor=2}}
        elseif number_of_jobs < 10 then
            monster = { {id=7, name="schwarze Skorpione", factor=3},
              {id=12, name="Ameisenlöwen", factor=1},
              {id=8, name="Fledermäuse", factor=2},
              {id=5, name="riesen Maden", factor=1},
              {id=13, name="Schlangen", factor=1}}
        else
            monster = { {id=11, name="Zombies", factor=2},
              {id=20, name="Terraniten", factor=4},
              {id=16, name="Sandkriecher", factor=1},
              {id=35, name="Schnecken", factor=2},
              {id=14, name="Sandwürmer", factor=3}}
        end
        local old_id = invertika.get_quest_status(ch, quest_string_monsterid)
        local monster_data = monster[math.random(1, #monster)]
        while monster_data == old_id do
            monster_data = monster[math.random(1, #monster)]
        end
        invertika.set_quest_status(ch, quest_string_monsterid, monster_data.id)
        required_kills = monster_data.factor * (number_of_jobs + 1) + math.random(-2, 2)
        local kills = chr_get_kill_count(ch, invertika.get_quest_status(ch, quest_string_monsterid))
        invertika.set_quest_status(ch, quest_string_kills, required_kills + kills)
        invertika.set_quest_status_string(ch, quest_string_monster_name, monster_data.name)
        npc_message(npc, ch, string.format(invertika.get_random_element(
                   "Als nächstes sollst du %s %s töten.",
                   "Für eine weitere Belohnung erledige bitte %s %s.",
                   "%s %s, dann gibt es eine neue Belohnung."),
                                          required_kills, monster_data.name)
                   )
    end
end

local function palastwache_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Zutritt nur mit königlichen Passierschein!",
      "Du benötigst einen königlichen Passierschein um den Palast zu betreten.",
      "Ohne königlichen Passierschein kein Zutritt!"))
end

local function bernie_talk(npc, ch)
    npc_message(npc, ch, "Hey du, du brauchst ihn doch bestimmt, den Niedermetzler 3000. Das ist genau das richtige für dich, da kannst du garnicht widerstehen. Komm schon für nur 99999 Aki gehört er dir? Oder eine Sonnenbrille? Neuste Mode? 12500 Aki! Ein besonderes Modell!")

    while true do
        local v = npc_choice(npc, ch, "Her mit dem Niedermetzler!",
                                     "Ich will die Sonnenbrille!",
                                     "Lieber nicht...")

        if v == 1 then
            local PlayerMoney=chr_money(ch)
            if PlayerMoney >= 99999 then
            invertika.add_money(ch, -99999)
            invertika.add_items(ch, 10005, 1, "Niedermetzler 3000")
            npc_message(npc, ch, invertika.get_random_element("Viel Spaß mit deinem Niedermetzler 3000.",
      "Nun hast du ihn, den Niedermetzler 3000.",
      "Bitteschön, der Niedermetzler 3000, die ultimative Waffe."))
              break;
            else
              npc_message(npc, ch, invertika.get_random_element("Du hast nicht genug Geld, komm später wieder.",
      "So nicht, das Geld benötigst du schon.",
      "Ne ne ne. Kram erstmal das Geld zusammen!"))
              break;
            end
        elseif v == 2 then
            if chr_money(ch) >= 12500 then
                invertika.add_money(ch, -12500)
                invertika.add_items(ch, 20023, 1, "Sonnenbrille")
                npc_message(npc, ch, "Da. Nimm Sie. Willst du auch einen Niedermetzler 3000?")
            else

              npc_message(npc, ch, invertika.get_random_element("Du hast nicht genug Geld, komm später wieder.",
      "So nicht, das Geld benötigst du schon.",
      "Ne ne ne. Kram erstmal das Geld zusammen!"))
            end
        elseif v == 3 then
            npc_message(npc, ch, invertika.get_random_element("Dann halt nicht. Aber vielleicht später?",
      "Wer nicht will der hat schon...",
      "Okay, ein ander Mal vielleicht."))
            break
        end
    end
end

local function valeria_talk(npc, ch)

    invertika.init_quest_status(ch, "selphi_timlet_valeria_letzteHeilung")
    local letzteHeilung = invertika.get_quest_status(ch, "selphi_timlet_valeria_letzteHeilung")

    npc_message(npc, ch, "Soll ich dich heilen?")

    while true do
        local v = npc_choice(npc, ch, "Alles heilen (1000 Aki)", "Nur 1000 HP (kostenlos)", "Nein ich brauche keine Heilung")

        if v == 1 then
            local PlayerMoney=chr_money(ch)
            if PlayerMoney >= 1000 then
            invertika.add_money(ch, -1000)
            being_heal(ch);
            npc_message(npc, ch, invertika.get_random_element("Du bist vollständig geheilt.",
      "Fertig. Du kannst wieder deines Weges gehen."))
            else
              npc_message(npc, ch, invertika.get_random_element("Du benötigst mehr Aki.",
      "Du hast keine 1000 Aki."))
            end
        elseif v == 2 then
            if letzteHeilung + (60 * 60 * 2) > os.time(t) then
                npc_message(npc, ch, "Nein. Ich heile dich nicht alle paar Minuten kostenlos. Komm doch später vielleicht nochmal vorbei")
                break
            else
                being_heal(ch, 1000)
                npc_message(npc, ch, invertika.get_random_element("Ich habe dir 1000 HP geschenkt.",
          "Du siehst wieder frisch aus."))
                i = os.time(t)
                invertika.set_quest_status(ch, "selphi_timlet_valeria_letzteHeilung", i)
                break
            end
        elseif v == 3 then
            npc_message(npc, ch, invertika.get_random_element("Wie du wünschst.",
      "Entschuldigung, ich wollte mich dir nicht aufdrängen."))
            break
        end
    end
end

local function amulet_trigger(ch, args)
  if (being_type(ch) == TYPE_CHARACTER) then --- Nur Player durchlassen
    local quest_string = string.format("selphi_timlet_amulet_quest_%s", args)
    invertika.init_quest_status(ch, quest_string)

    local function get_qstatus() return tonumber(invertika.get_quest_status(ch, quest_string)) end
    local function set_qstatus(x) invertika.set_quest_status(ch, quest_string, tonumber(x)) end

    if get_qstatus() == 0 then
        set_qstatus(1)
        invertika.add_items(ch, 40029, 1, "Stück eines zerbrochen Amuletts")
    end
  end
end

local function lidi_talk(npc, ch)
    local queststring = "selphi_timlet_lidi_sunglasses"
    invertika.init_quest_status(ch, queststring)
    local get_qstatus = function()
        return invertika.get_quest_status(ch, queststring)
    end
    local set_qstatus = function(x)
        invertika.set_quest_status(ch, queststring, x)
    end

    if get_qstatus() == 0 then
        if chr_inv_count(ch, 20023) > 0 then
            npc_message(npc, ch, "Oh Gott du hast SIE. Ich brauche diese Brille, gibst du sie mir?")
            while true do
                local v = npc_choice(npc, ch, "Ja.", "Nein.")
                if v == 1 then
                    invertika.add_items(ch, 20023, -1, "Sonnenbrille")
                    invertika.add_items(ch, invertika.get_random_element(40030, 40031, 40032, 40033), 1, "Garn")
                    npc_message(npc, ch, "Danke, danke, danke. Hier nimm das als Dankeschön.")
                    set_qstatus(1)
                    break
                elseif v == 2 then
                    npc_message(npc, ch, "Pffffff, dann nicht...")
                    break
                end
            end
        else
            npc_message(npc, ch, "Boah diese Sonnenbrille ist der reinste Wahnsinn. Ich brauche diese, genau diese Brille.")
        end
    elseif get_qstatus() == 1 then
        npc_message(npc, ch, "Sehe ich nicht total fesch mit dieser Brille aus?")
        set_qstatus(2)
    elseif get_qstatus() == 2 then
        npc_message(npc, ch, "Sag mal, hast du meine Sonnenbrille gesehen?")
        set_qstatus(3)
    else
        npc_message(npc, ch, "... sie ist weg. Weeeg! Wie soll ich mich jetzt nur wieder unter die Leute wagen?")
        set_qstatus(0)
    end
end

local function warp_escape_tunnel(obj, arg)
    if(being_type(obj)==TYPE_CHARACTER) then
        chr_warp(obj, 20146, 35 * TILESIZE, 35 * TILESIZE + 16)
    end
end

local function waypoint_archway_1(obj, arg)
    if(being_type(obj)==TYPE_CHARACTER) then
        local archway_quest = chr_get_quest(obj, "selphi_timlet_archway_quest")
        if(not archway_quest) then return false end -- Abbrechen, falls Questvar noch nicht gecached
        being_say(obj, archway_quest)
        if(archway_quest % 2 == 1) then
            --- halbe Umdrehung wird dazugezählt
            invertika.set_quest_status(obj, "selphi_timlet_archway_quest", archway_quest + 1)
            local rounds = (archway_quest+1)/2
            -- eigentlich sollte hier eine 17 stehen, sind nur zu testzwecken lediglich 2 runden
            if(rounds % 2 == 0) then
                being_say(obj, "Jetzt bin ich reich!!! (debug)")
                chat_message(obj, "Vor lauter Langeweile wegen dem ganzen Torbögen-Durchlaufen, findest du ein paar Aki auf der Erde, die du zuvor wahrscheinlich übersehen hast!")
                invertika.add_money(obj, math.random(1, 500)) --- Wenn man davon ausgeht, dass man in 17 Runden wahrscheinlich etwa 50 Maden mit HDW von über 5 = 250 Aki minimum verdienen kann, sind 250 Aki Durchschnittsgewinn beim Durchlaufen der Torbögen OK
            end
        end
    end
end

local function waypoint_archway_2(obj, arg)
    if(being_type(obj)==TYPE_CHARACTER) then
        local archway_quest = chr_get_quest(obj, "selphi_timlet_archway_quest")
        if(not archway_quest) then return false end -- Abbrechen, falls Questvar noch nicht gecached
        being_say(obj, "Ich habe den Wegpunkt passiert")
        being_say(obj, archway_quest)
        if(archway_quest % 2 == 0) then
            --- halbe Umdrehung wird dazugezählt
            invertika.set_quest_status(obj, "selphi_timlet_archway_quest", archway_quest + 1)
        end
    end
end

atinit(function()
 create_inter_map_warp_trigger(62, 72, 56, 6) --- Intermap warp
 nethek.create_netheksaeule(181 * TILESIZE, 125 * TILESIZE + 16) --- Netheksäule
 trigger_create(41 * TILESIZE + 8, 105 * TILESIZE + 8, 1.5 * TILESIZE, 1.5 * TILESIZE, warp_escape_tunnel, 0, true) --- Warp zum Fluchttunnel
 --trigger_create(113 * TILESIZE, 141 * TILESIZE, 2 * TILESIZE, 2 * TILESIZE, waypoint_archway_1, 0, true) --- Rundenzähler Torbögen (Waypoint 1)
 --trigger_create(112 * TILESIZE, 180 * TILESIZE, 5 * TILESIZE, 4 * TILESIZE, waypoint_archway_2, 0, true) --- Rundenzähler Torbögen (Waypoint 2)

 --Schilder
 sign.create_sign(113, 84, "Frisörsalon Umet\
Schneiden, Färben, Waschen, Perücken und mehr.") -- Schild vor dem Friseur
 sign.create_sign(131, 82, "Feinste Waffen zu günstigen Preisen\
Wir müssen darauf hinweisen, dass bei Diebstahl ein Ladenverbot verhängt wird sowie die Hand als Entschädigung einbehalten wird.") -- Schild vor dem Waffenladen
 sign.create_sign(43, 107, "Kein Trinkwasser!") -- Schild vor dem Brunnen
 sign.create_sign(146, 160, "Baden und Angeln verboten!") -- Schild vor dem Wasserloch

 -- NPCs
 npc_create("Elmo", 7, GENDER_UNSPECIFIED, 176 * TILESIZE + 16, 154 * TILESIZE + 16, elmo_talk, nil) --- Elmo
 npc_create("Sam", 7, GENDER_UNSPECIFIED, 183 * TILESIZE + 16, 154 * TILESIZE + 16, sam_talk, nil) --- Sam
 npc_create("Julia", 10, GENDER_UNSPECIFIED, 170 * TILESIZE + 16, 152 * TILESIZE + 16, julia_talk, nil) --- Julia
 npc_create("Jane", 12, GENDER_UNSPECIFIED, 182 * TILESIZE + 16, 145 * TILESIZE + 16, jane_talk, nil) --- Jane
 npc_create("Bruce", 7, GENDER_UNSPECIFIED, 190 * TILESIZE + 16, 160 * TILESIZE + 16, bruce_talk, nil) --- Bruce
 npc_create("Felix", 42, GENDER_UNSPECIFIED, 187 * TILESIZE + 16, 94 * TILESIZE + 16, felix_talk, nil) --- Felix
 npc_create("Saria", 10, GENDER_UNSPECIFIED, 42 * TILESIZE + 16, 100 * TILESIZE + 16, saria_talk, nil) --- Saria
 npc_create("Nobur", 17, GENDER_UNSPECIFIED, 186 * TILESIZE + 16, 179 * TILESIZE + 16, nobur_talk, nil) --- Nobur
 npc_create("Alex", 24, GENDER_UNSPECIFIED, 76 * TILESIZE + 16, 10 * TILESIZE + 16, alex_talk, nil) --- Alex
 npc_create("Inard", 61, GENDER_UNSPECIFIED, 74 * TILESIZE + 16, 142 * TILESIZE + 16, inard_talk, nil) --- Inard
 npc_create("Belart", 41, GENDER_UNSPECIFIED, 108 * TILESIZE + 16, 132 * TILESIZE + 16, belart_talk, nil) --- Belart
 npc_create("Imangi", 67, GENDER_UNSPECIFIED, 138 * TILESIZE + 16, 157 * TILESIZE + 16, imangi_talk, nil) --- Imangi
 npc_create("Ortana", 8, GENDER_UNSPECIFIED, 97 * TILESIZE + 16, 49 * TILESIZE + 16, ortana_talk, nil) --- Ortana
 npc_create("Tonver", 8, GENDER_UNSPECIFIED, 17 * TILESIZE + 16, 181 * TILESIZE + 16, tonver_talk, nil) --- Tonver
 npc_create("Elmes", 46, GENDER_UNSPECIFIED, 114 * TILESIZE + 16, 180 * TILESIZE + 16, elmes_talk, nil) --- Elmes
 npc_create("Nepuret", 30, GENDER_UNSPECIFIED, 90 * TILESIZE + 16, 185 * TILESIZE + 16, nepuret_talk, nil) --- Nepuret
 npc_create("Nero", 24, GENDER_UNSPECIFIED, 162 * TILESIZE + 16, 175 * TILESIZE + 16, nero_talk, nil) --- Nero
 npc_create("Bernie", 40, GENDER_UNSPECIFIED, 13 * TILESIZE + 16, 9 * TILESIZE + 16, bernie_talk, nil) --- Bernie
 npc_create("Valeria", 10, GENDER_UNSPECIFIED, 26 * TILESIZE + 16, 49 * TILESIZE + 16, valeria_talk, nil) --- Valeria

 npc_create("Alaria", 79, GENDER_UNSPECIFIED, 170 * TILESIZE + 16, 182 * TILESIZE + 16, seller.seller_talk, nil) --- Verkäufer
 npc_create("Lidi", 71, GENDER_UNSPECIFIED, 171 * TILESIZE + 16, 79 * TILESIZE + 16, lidi_talk, nil) -- Lidi

 npc_create("Wache", 25, GENDER_UNSPECIFIED, 39 * TILESIZE + 16, 51 * TILESIZE + 16, colloseumwache_talk, nil) --- Colloseumwache
 npc_create("Wache", 25, GENDER_UNSPECIFIED, 44 * TILESIZE + 16, 51 * TILESIZE + 16, colloseumwache_talk, nil) --- Colloseumwache

 npc_create("Wache", 29, GENDER_UNSPECIFIED, 26 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 npc_create("Wache", 29, GENDER_UNSPECIFIED, 31 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 npc_create("Wache", 29, GENDER_UNSPECIFIED, 45 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache
 npc_create("Wache", 29, GENDER_UNSPECIFIED, 49 * TILESIZE + 16, 165 * TILESIZE + 16, bankwache_talk, nil) --- Bankwache

 npc_create("Stadtwache", 27, GENDER_UNSPECIFIED, 110 * TILESIZE + 16, 196 * TILESIZE + 16, stadtwache_talk, nil) --- Stadtwache
 npc_create("Stadtwache", 27, GENDER_UNSPECIFIED, 117 * TILESIZE + 16, 196 * TILESIZE + 16, stadtwache_talk, nil) --- Stadtwache

 wache1 = npc_create("Palastwache", 27, GENDER_UNSPECIFIED, 143 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 npc_create("Palastwache", 27, GENDER_UNSPECIFIED, 150 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 wache2 = npc_create("Palastwache", 27, GENDER_UNSPECIFIED, 181 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache
 npc_create("Palastwache", 27, GENDER_UNSPECIFIED, 188 * TILESIZE + 16, 68 * TILESIZE + 16, palastwache_talk, nil) --- Palastwache

 --- Trigger für die Überwachung des Torbereiches
 trigger_create(145 * TILESIZE, 17 * TILESIZE, 5 * TILESIZE, 52 * TILESIZE, wache_trigger, 1, true) --- Trigger Tor 1
 trigger_create(183 * TILESIZE, 17 * TILESIZE, 5 * TILESIZE, 52 * TILESIZE, wache_trigger, 2, true) --- Trigger Tor 2

 --- Trigger für den Amulet-quest.
 trigger_create(54 * TILESIZE, 10 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 1, true)
 trigger_create(104 * TILESIZE, 82 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 2, true)
 trigger_create(43 * TILESIZE, 116 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 3, true)
 trigger_create(9 * TILESIZE, 79 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 4, true)
 trigger_create(7 * TILESIZE, 60 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 5, true)
 trigger_create(61 * TILESIZE, 152 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 6, true)
 trigger_create(49 * TILESIZE, 182 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 7, true)
 trigger_create(191 * TILESIZE, 119 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 8, true)
 trigger_create(102 * TILESIZE, 141 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 9, true)
 trigger_create(87 * TILESIZE, 151 * TILESIZE, TILESIZE, TILESIZE, amulet_trigger, 10, true)

 ---Weihnachten
 --npc_create("Rentier", 74, GENDER_UNSPECIFIED, 177 * TILESIZE + 16, 185 * TILESIZE + 16, rentier_talk, nil) --- Rentier
 --npc_create("Weihnachtsmann", 9, GENDER_UNSPECIFIED, 184 * TILESIZE + 16, 185 * TILESIZE + 16, weihnachtsmann_talk, nil) --- Weihnachtsman

 ---Neujahr
 ---npc_create("Feuerwerker", 139, GENDER_UNSPECIFIED, 177 * TILESIZE + 16, 185 * TILESIZE + 16, fireworker_talk, npclib.walkaround_small)
end)
