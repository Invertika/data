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

dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(1, 57, 3, 13) --- Intermap warp

 create_npc("Jurkan", 33, 80 * TILESIZE + 16, 115 * TILESIZE + 16, jurkan_talk, nil) --- Jurkan
 create_npc("Holzbein", 42, 83 * TILESIZE + 16, 115 * TILESIZE + 16, holzbein_talk, nil) --- Holzbein
 create_npc("seeseekey", 24, 93 * TILESIZE + 16, 118 * TILESIZE + 16, seeseekey_talk, nil) --- seeseekey
 create_npc("Delegan", 87, 81 * TILESIZE + 16, 122 * TILESIZE + 16, delegan_talk, nil) --- Delegan
 create_npc("bulldog98", 53, 87 * TILESIZE + 16, 122 * TILESIZE + 16, bulldog98_talk, nil) --- bulldog98
 create_npc("Saturn", 3, 89 * TILESIZE + 16, 114 * TILESIZE + 16, saturn_talk, nil) --- Saturn
 create_npc("subnet_zero", 19 , 77 * TILESIZE + 16, 118 * TILESIZE + 16, subnet_zero_talk, nil) --- subnet_zero
 create_npc("DJh2o2", 54, 86 * TILESIZE + 16, 114 * TILESIZE + 16, djh2o2_talk, nil) --- DJh2o2
 create_npc("Dark Mage", 72, 84 * TILESIZE + 16, 122 * TILESIZE + 16, darkmage_talk, nil) --- DJh2o2
 create_npc("Ablu", 82, 90 * TILESIZE + 16, 122 * TILESIZE + 16, ablu_talk, nil) --- Ablu
end)

function jurkan_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Irgendwie ist mir zu heiß hier...",
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
	  do_npc_close(npc, ch)
end

function holzbein_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Wo ist mein Kamel?",
	  "Lieber Arm dran, als Arm ab.",
	  "Steck den Spaltenvektor in die Vektorspalte.",
	  "Um Pirat zu werden, musst du schon mehr machen als CDs brennen!",
	  "Der Tisch ist neidisch auf mein Holzbein.",
	  "Wo ist meine Brille?",
          "Nicht zu fassen. Überall diese Dingsbums.",
	  "Was hat das zu bedeuten?"))
	  do_npc_close(npc, ch)
end

function seeseekey_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Da sind meine Sprüche schon wieder weg...",
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
	  "Dwight Schulz ist Republikaner. Murdok vom A-Team ist Republikaner. Reginald Barclay ist Republikaner. Oh Gott die Weit ist so böse..."))
	do_npc_close(npc, ch)
end

function delegan_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Zu eckig, zu pixelig, zu virtuell! Neubauen!",
	  "Ob jeder so einfach Berge, Täler, Seen und Flüsse aus dem nichts erschaffen kann?",
	  "Sonne, Mond und Sterne, ich bau mir eine Taverne.",
	  "Mauszeiger hier, Mauszeiger dort und alles ist hin fort.",
	  "Ups... Sollte hier nicht \"Leretica\" stehen?",
	  "Ich glaube ich habe was vergessen. Naja, sie kommen ja immer noch durch die Fenster rein.",
	  "Ach herje... wo war noch gleich der eingebaute Geheimraum?!",
	  "Muh, Muh, Muh, macht die Kuh, Mäh, Mäh, Mäh, macht das Schaf, Wuff, Wuff, Wuff, macht der Enzyan... dieses doofe Lied... will mir nicht aus dem Kopf...",
	  "Gut, Dann kommt der Berg eben dort hin. Kein Problem. Wird sofort erledigt.",
	  "Brauchen sie einen Urwald mit kurzen Lieferzeiten und für wenig Geld?  Nicht verzagen, Mapper fragen."))
	do_npc_close(npc, ch)
end

function bulldog98_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Wenn du aufhören willst zu rauchen, höre auch auf Windows zu nutzten. Es wird dir dabei helfen.",
	  "(Linux...) Hält, was andere versprechen.",
	  "Die große Welt paßt nicht durch kleine Fenster - Linux!",
	  "Freie Software für eine freie Welt.",
	  "Linux - der Quellcode möge mit dir sein.",
	  "Linux - Wir brauchen keine Fensterputzer.",
	  "Während man in Redmond noch bootet, wird in Villa Pinguin schon gearbeitet...",
	  "Warum können Pinguine nicht fliegen? Was nicht fliegt kann auch nicht abstürzen.",
	  "Linux - damit der Ausnahmefehler nicht zur Regel wird. ",
	  "Durch einen schrecklichen Zufall versterben in einer Woche zuerst Linus Torvalds und, drei Tage später, Bill Gates. Als Gates in den Himmel kommt, sagt Gott zu ihm Hallo, Herr Gates, schön sie zu sehen! In Anbetracht ihrer großen Verdienste um die Entwicklung der PCs kriegen sie hier ihr eigenes Häuschen, und, glauben Sie mir, das kriegt hier nicht jeder!\nGott nimmt Gates an die Hand und führt ihn vor einen kleinen Flachdachbungalow. Die Fußmatte an der Tür ist mit dem Windows-Logo versehen und eine kleine ready-for-windows-Fahne weht im Vorgärtchen. Gates denkt sich Joh, ganz nett, dreht sich um.... und traut seinen Augen nicht. Auf der nächsten Wolke, hoch über ihm, steht ein italienischer Palazzo, komplett mit Balustrade und sechs dorischen Säulen. Der Palazzo ist gelb-schwarz gestrichen, über und über mit Pinguin-Symbolen, Graffiti, -Fahnen und -Transparenten, Marmorpinguinen übersät.\nGates wendet sich an Gott und sagt, schwer brüskiert: Was ist DAS denn? Wieso kriegt der Torvalds so'n Palast da hingestellt? Das billig System von dem benutzt doch keiner!! Häh??? Wieso lebt der hier in so nem Haus??? Gott dreht sich um, schaut Gates tief in die Augen und sagt Das ist nicht Torvalds Haus. Das ist meins."))
	do_npc_close(npc, ch)
end

function saturn_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("What is music? Music is the emotion of sound and the sound of emotion.",
	  "What is sound? Sound is any audible vibration.",
	  "What is emotion? Now that is a tough one."))
	do_npc_close(npc, ch)
end

function subnet_zero_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Reboot tut gut!",
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
	do_npc_close(npc, ch)
end

function djh2o2_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Die Kunst der Komposition ist es, sich an eine Melodie zu erinnern, die es noch nicht gibt."))
	do_npc_close(npc, ch)
end
 
function darkmage_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Why not to use GPS for finding players. I think this scientist can make satellite for it.",
	  "One day, one of the best painters met drunk man on the street. This painter didn't like to put on new clothes, so he put on old hat. Man asked: Erm, is this thing on your head is called hat? Painter answered: Is this thing under your hat called head?"))
	do_npc_close(npc, ch)
end

function ablu_talk(npc, ch)
    do_message(npc, ch, invertika.get_random_element("Pffff.",
      "Du kannst hier ruhigen Gewissens einen Scheck liegen lassen. Ich passe schon darauf auf.",
      "Hüte dich vor dem Schneemann!",
      "Nein. Ich spawne keine Killermaden. Dafür ist der Typ da oben rechts verantwortlich.",
      "Ruhe bitte!"))
    do_npc_close(npc, ch)
end
