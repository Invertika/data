----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2011 The Invertika Development Team                        --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"

require "scripts/libs/warp"


local function jurkan_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Irgendwie ist mir zu heiß hier...",
      "Glaub mir, das hier war nicht geplant.",
      "Das habe ich nun davon, seeseekey geholfen zu haben. Wer das ist? Der da drüben!",
      "ICH habe euch geschaffen, das mit Invertika ist alles Quatsch!!!!!",
      "Warum anderen das Leben schwermachen, wenn man es ihnen nehmen kann?",
      "Könnte mir vielleicht nochmal jemand was zu trinken bringen? Mit viel Eis?",
      "Ich steh hier nur so rum, das ist schöpferische Willkür.",
      "while true; do echo Blubb; done; Blubb blubb blubb blubb blubb...",
      "Seit ich hier in der Wüste bin, habe ich Schweissfüße!",
      "Wer kam eigentlich auf die bescheuerte Idee, so viele Blumen in diese Welt zu pflanzen? Und dann auch noch im falschen Layer!",
      "Wenn du einen Bug findest, der dir unendlich Geld bringt, melde ihn bitte zuerst mir. Wahrscheinlich war eh ich das, der den eingebaut hat.",
      "Wusstest du, dass ich damals der erste war, der entdeckt hat, wie man von den Toten wiederauferstehen kann, ohne in den Nex zu kommen? Deshalb tötet seeseekey mich auch immer. Oder setzt mich als Schneemann in eine Wüste. Aber das interessiert dich ja sowieso nicht...",
      "Ich bin depressiv? Was heißt depressiv? Bestimmt was gaaanz schlimmes...",
      "Du willst auch hier stehen? Geht ganz einfach, melde dich im #invertika-Channel im Freenode-IRC-Netzwerk für ein Jahr Zwangsarbeit und die Sache ist gebongt!"))
end

local function holzbein_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Wo ist mein Kamel?",
      "Lieber Arm dran, als Arm ab.",
      "Steck den Spaltenvektor in die Vektorspalte.",
      "Um Pirat zu werden, musst du schon mehr machen als CDs brennen!",
      "Der Tisch ist neidisch auf mein Holzbein.",
      "Wo ist meine Brille?",
      "Nicht zu fassen. Überall diese Dingsbums.",
      "Was hat das zu bedeuten?"))
end

local function seeseekey_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Da sind meine Sprüche schon wieder weg...",
      "Ich hasse Schleichwerbung! Und nun geh bitte ich muss mit meinem Android Telefon auf seeseekey.net gehen.",
      "Mmm wenn ich das so Skripte müsste das alles zusammenpassen. PENG!",
      "Anne wo bist du?",
      "Wenn du mich über 20 mal ansprichst passiert etwas tolles. Oder auch nicht...",
      "So dann wollen wir mal das Development Team motivieren.",
      "Invertika oder Videos drehen? Schwierige Wahl...",
      "C# oder Python. Wähle ... aber entscheide weise...",
      "Coke Vanilla + Waldmeisterbrause - 50 zu 50 - Köstlich, ein Getränk für die Götter.",
      "Soll ich dir ein Geheimnis verraten? Ich sage nur Selphi Timlet...",
      "Eckig Eckig sind alle meine Karten *sing*.",
      "Wie Freitag und schon 19 Uhr? Oh Gott, ich muss zum Bloggerstammtisch.",
      "Wie das gibt es nix für? Dann muss ich mir halt was schreiben.",
      "So die PIN an diese Stelle, den Arduino mit Strom versorgen und schon ... ha, es LEBT!!!",
      "Dwight Schulz ist Republikaner. Murdok vom A-Team ist Republikaner. Reginald Barclay ist Republikaner. Oh Gott die Welt ist so böse..."))
end

local function delegan_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Zu eckig, zu pixelig, zu virtuell! Neubauen!",
      "Ob jeder so einfach Berge, Täler, Seen und Flüsse aus dem nichts erschaffen kann?",
      "Sonne, Mond und Sterne, ich bau mir eine Taverne.",
      "Mauszeiger hier, Mauszeiger dort und alles ist hin fort.",
      "Ups... Sollte hier nicht \"Leretica\" stehen?",
      "Ich glaube ich habe was vergessen. Naja, sie kommen ja immer noch durch die Fenster rein.",
      "Ach herje... wo war noch gleich der eingebaute Geheimraum?!",
      "Muh, Muh, Muh, macht die Kuh, Mäh, Mäh, Mäh, macht das Schaf, Wuff, Wuff, Wuff, macht der Enzyan... dieses doofe Lied... will mir nicht aus dem Kopf...",
      "Gut, Dann kommt der Berg eben dort hin. Kein Problem. Wird sofort erledigt.",
	  "Wenn ich mich recht entsinne sagte er... *murmel* Binäre Relation, n-äre Relation Komposition von Relation, die leere Menge ist ein Element der leeren Menge wenn sie voll ist.... verwirrend wenn schlau=falsch, falsch=wahr und wa(h)r nicht existent...",
      "Brauchen sie einen Urwald mit kurzen Lieferzeiten und für wenig Geld?  Nicht verzagen, Mapper fragen."))
end

local function bulldog98_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Wenn du aufhören willst zu rauchen, höre auch auf Windows zu nutzen. Es wird dir dabei helfen.",
      "(Linux...) Hält, was andere versprechen.",
      "Die große Welt paßt nicht durch kleine Fenster - Linux!",
      "Freie Software für eine freie Welt.",
      "Linux - der Quellcode möge mit dir sein.",
      "Linux - Wir brauchen keine Fensterputzer.",
      "Während man in Redmond noch bootet, wird in Villa Pinguin schon gearbeitet...",
      "Warum können Pinguine nicht fliegen? Was nicht fliegt kann auch nicht abstürzen.",
      "Linux - damit der Ausnahmefehler nicht zur Regel wird. ",
      "Durch einen schrecklichen Zufall versterben in einer Woche zuerst Linus Torvalds und, drei Tage später, Bill Gates. Als Gates in den Himmel kommt, sagt Gott zu ihm Hallo, Herr Gates, schön sie zu sehen! In Anbetracht ihrer großen Verdienste um die Entwicklung der PCs kriegen sie hier ihr eigenes Häuschen, und, glauben Sie mir, das kriegt hier nicht jeder!\nGott nimmt Gates an die Hand und führt ihn vor einen kleinen Flachdachbungalow. Die Fußmatte an der Tür ist mit dem Windows-Logo versehen und eine kleine ready-for-windows-Fahne weht im Vorgärtchen. Gates denkt sich Joh, ganz nett, dreht sich um.... und traut seinen Augen nicht. Auf der nächsten Wolke, hoch über ihm, steht ein italienischer Palazzo, komplett mit Balustrade und sechs dorischen Säulen. Der Palazzo ist gelb-schwarz gestrichen, über und über mit Pinguin-Symbolen, Graffiti, -Fahnen und -Transparenten, Marmorpinguinen übersät.\nGates wendet sich an Gott und sagt, schwer brüskiert: Was ist DAS denn? Wieso kriegt der Torvalds so'n Palast da hingestellt? Das billig System von dem benutzt doch keiner!! Häh??? Wieso lebt der hier in so nem Haus??? Gott dreht sich um, schaut Gates tief in die Augen und sagt Das ist nicht Torvalds Haus. Das ist meins."))
end

local function saturn_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("What is music? Music is the emotion of sound and the sound of emotion.",
      "What is sound? Sound is any audible vibration.",
      "What is emotion? Now that is a tough one."))
end

local function subnet_zero_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Reboot tut gut!",
      "Never change a running system!",
      "If the helpdesk thinks your question is stupid, we will set you on fire.",
      "Termine sind nicht verbindlich.",
      "Ich flieg mit Jean-Luc.",
      "In welches Layer gehören die Palmen?",
      "Sie haben doch ein Netzwerkplan oder?",
      "Sie haben doch ein Backup gemacht oder?",
      "Sie haben leider keine Backupleitung.",
      "Das Passwort müssen wir ändern. Das haben sie ja per Mail versendet.",
      "Ich leite sie mal an den Kollegen weiter... *klack* Mist, aufgelegt!",
      "Starten sie mal neu. Ja, einfach Stecker ziehen.",
      "Das Gerät ist rot und viereckig.",
      "Was essen wir'n heute?",
      "Verdammter PROXY!",
      "Verdammte AXT!"))
end

local function djh2o2_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Die Kunst der Komposition ist es, sich an eine Melodie zu erinnern, die es noch nicht gibt."))
end
 
local function darkmage_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Why not to use GPS for finding players. I think this scientist can make satellite for it.",
      "One day, one of the best painters met drunk man on the street. This painter didn't like to put on new clothes, so he put on old hat. Man asked: Erm, is this thing on your head is called hat? Painter answered: Is this thing under your hat called head?"))
end

local function ablu_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Pffff.",
      "Du kannst hier ruhigen Gewissens einen Scheck liegen lassen. Ich passe schon darauf auf.",
      "Hüte dich vor dem Schneemann!",
      "Nein. Ich spawne keine Killermaden. Dafür ist der Typ da oben rechts verantwortlich.",
      "Ruhe bitte!"))
end

local function cmur2_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("*meepmeep*",
      "Nicht mal vernünftige Klamotten gibt's hier!"))
end

local function kizu_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Moin",
    "Wird alles Überbewertet",
    "Einstein sagte: 'Fantasie ist wichtiger als Wissen, denn Wissen ist begrenzt'. Dem kann ich nur zustimmen, denn sonst gäbe es diese Welt hier nicht.",
    "Ordnung ist das halbe Leben. Ich lebe aber nunmal auf der anderen Seite",
    "Wsutsset du, dsas du dsas heir lseen knast? Das kmnmot dhear, dsas du ein Wrot als gnezas lesit und nhict jdeen Bcubehsatn eninilzet. Nur der etrse und der lzzete Bacushtbe msüesn simetmn.",
    "Welcher Religion gehörst du an? Linux, Windows oder Mac?"))
end

local function postremus_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Interessant",
      "Faszinierend",
      "Das alles hier hat keinen, hohen, künstlerischen Wert.",
      "Ja, Jim. Es sind schon wieder die Klingonen...",
      "Jim, lange hält die Enterprise diese Geschwindigkeit nicht mehr aus!"
      ))
end
atinit(function()
 create_inter_map_warp_trigger(1, 57, 3, 13) --- Intermap warp

 npc_create("Jurkan", 33, GENDER_UNSPECIFIED, 80 * TILESIZE + 16, 115 * TILESIZE + 16, jurkan_talk, nil) --- Jurkan
 npc_create("Holzbein", 42, GENDER_UNSPECIFIED, 83 * TILESIZE + 16, 115 * TILESIZE + 16, holzbein_talk, nil) --- Holzbein
 npc_create("seeseekey", 24, GENDER_UNSPECIFIED, 93 * TILESIZE + 16, 118 * TILESIZE + 16, seeseekey_talk, nil) --- seeseekey
 npc_create("Delegan", 87, GENDER_UNSPECIFIED, 81 * TILESIZE + 16, 122 * TILESIZE + 16, delegan_talk, nil) --- Delegan
 npc_create("bulldog98", 53, GENDER_UNSPECIFIED, 87 * TILESIZE + 16, 122 * TILESIZE + 16, bulldog98_talk, nil) --- bulldog98
 npc_create("Saturn", 3, GENDER_UNSPECIFIED, 89 * TILESIZE + 16, 114 * TILESIZE + 16, saturn_talk, nil) --- Saturn
 npc_create("subnet_zero", 19 , GENDER_UNSPECIFIED, 77 * TILESIZE + 16, 118 * TILESIZE + 16, subnet_zero_talk, nil) --- subnet_zero
 npc_create("DJh2o2", 54, GENDER_UNSPECIFIED, 86 * TILESIZE + 16, 114 * TILESIZE + 16, djh2o2_talk, nil) --- DJh2o2
 npc_create("Dark Mage", 72, GENDER_UNSPECIFIED, 84 * TILESIZE + 16, 122 * TILESIZE + 16, darkmage_talk, nil) --- DJh2o2
 npc_create("Ablu", 82, GENDER_UNSPECIFIED, 90 * TILESIZE + 16, 122 * TILESIZE + 16, ablu_talk, nil) --- Ablu
 npc_create("cmur2", 59, GENDER_UNSPECIFIED, 78 * TILESIZE + 16, 122 * TILESIZE + 16, cmur2_talk, nil) --- cmur2
 npc_create("Kizu", 120, GENDER_UNSPECIFIED, 77 * TILESIZE + 16, 120 * TILESIZE + 16, kizu_talk, nil) --- kizu
 npc_create("Postremus", 38, GENDER_UNSPECIFIED, 77 * TILESIZE + 16, 116 * TILESIZE + 16, postremus_talk, nil) --- Postremus
end)
