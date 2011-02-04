----------------------------------------------------------------------------------
-- Frisör Skript                                                                --
--                                                                              --
-- Dieses Skript stellt Funktionalität für den Frisör zu Verfügung              --
--                                                                              --
-- Beispielaufrufe                                                              --
-- create_npc("Barber", 100, 51 * TILESIZE + 16, 38 * TILESIZE + 16,            --
-- Barber, nil)                                                                 --
--                                                                              --
-- create_npc("Barber 2", 100, 52 * TILESIZE + 16, 38 * TILESIZE + 16,          --
-- npclib.talk(Barber, {14, 15, 16}, {}), nil)                                  --
----------------------------------------------------------------------------------
--  Copyright 2009-2011 The Invertika Development Team                          --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------
--  Copyright 2009 The Mana World Development Team                              --
--                                                                              --
--  This file is part of The Mana World.                                        --
--                                                                              --
--  The Mana World  is free software; you can redistribute  it and/or modify it --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

--Frisörfunktion -> Manasource

local barber_styles = {"Flat ponytail", "Bowl cut","Combed back", "Emo", "Mohawk",
        "Pompadour", "Center parting/Short and slick", "Long and slick", "Short and curly",
        "Pigtails", "Long and curly", "Parted", "Perky ponytail", "Wave", "Mane", "Bun"}

local barber_colors = {"Brunette", "Green", "Dark red", "Light purple", "Gray", "Blonde",
        "Teal", "Light red", "Blue", "Dark purple", "Black"}

function barber1_talk(npc, ch, data)
    local style_ids = nil
    local color_ids = nil

    -- If extra data was passed, let's have a look at it
    if data ~= nil then
        style_ids = data[1]
        if #data > 1 then
            color_ids = data[2]
        end
    end

    -- Setup up default styles (if needed)
    if style_ids == nil then
        style_ids = {}
        for i = 1, 13 do
            style_ids[i] = i
        end
    end

    -- Setup up default colors (if needed)
    if color_ids == nil then
        color_ids = {}
        for i = 1, 11 do
            color_ids[i] = i
        end
    end

    -- Nothing to show? Then we can return
    if #color_ids == 0 and #style_ids == 0 then
        return -- Since we haven't shown any windows, we can safely
               -- return without a do_npc_close
    end

    local result = 0

    local styles = {}

    -- If we have style IDs, lets get their names
    if #style_ids > 0 then
        for i = 1, #style_ids do
            styles[i] = barber_styles[style_ids[i]]
        end
        result = 1
    end

    local colors = {}

    -- If we have color style IDs, lets get their names
    if #color_ids > 0 then
        for i = 1, #color_ids do
            colors[i] = barber_colors[color_ids[i]]
        end

        if result == 0 then
            result = 2
        else
            result = 3
        end
    end

    -- Choose an appropriate message
    if result == 1 then
        do_message(npc, ch, "Hello! What style would you like today?")
    elseif result == 2 then
        do_message(npc, ch, "Hello! What color would you like today?")
    else
        do_message(npc, ch, "Hello! What can I do for you today?")
    end

    print("#styles ==", #styles)

    -- Repeat until the user selects nothing
    repeat
        if (result == 1) then -- Do styles
            result = do_choice(npc, ch, "Bald", styles, "Supprise me", "Never mind")

            result = result -1

            --Random
            if (result == #styles + 1) then
                result = math.random(#styles + 1) - 1
                print("Random")
            end

            print("Style ==", result)

            if (result == 0) then
                mana.chr_set_hair_style(ch, 0)
                result = 1
            elseif (result <= #styles) then
                mana.chr_set_hair_style(ch, style_ids[result])
                result = 1
            else --"Never mind"
                result = 3
            end
        elseif (result == 2) then -- Do colors
            result = do_choice(npc, ch, colors, "Supprise me", "Never mind")

            --Random
            if (result == #colors + 1) then
                result = math.random(#colors)
            end

            if (result <= #colors) then
                mana.chr_set_hair_color(ch, color_ids[result - 1])
                result = 2
            else --"Never mind"
                result = 3
            end
        end

        -- If we have both styles and colors, show the main menu
        if #styles > 0 and #colors > 0 then
            result = do_choice(npc, ch, "Change my style", "Change my color", "Never mind")
        end
    until result >= 3 --While they've choosen a valid option that isn't "Never mind"

    -- Let's close up
    do_message(npc, ch, "Thank you. Come again!")
    do_npc_close(npc, ch)
end

-- Frisörfunktion -> Invertika
function barber2_talk(npc, ch)
    do_message(npc, ch, "Guten Tag da drüben! Was darfs sein? Neuen Haarschnitt? Oder nur die Farbe ändern?")
    while true do
        local v = do_choice(npc, ch, "Neuen Haarschnitt bitte!", "Einmal Färben!", "Nein danke.")
        if v == 1 then
            do_message(npc, ch, "Welcher Schnitt darf es denn sein?")
            while true do
                local v2 = do_choice(npc, ch, "Kurzer Zopf", "Pilzkopf", "Kurzhaar", "Emo", "Irokese", "Schmalzlocke",
                                              "Scheitel", "lang und glatt", "kurze Locken", "Zöpfe",
                                              "lange Locken", "Schulterlang", "Zopf", "Wellen", "Mähne", "Dutt")
                           
                local costs = 0
                if v2 == 1 then
                    costs = 80
                elseif v2 == 2 then
                    costs = 239
                elseif v2 == 3 then
                    costs = 124
                elseif v2 == 4 then
                    costs = 200
                elseif v2 == 5 then
                    costs = 104
                elseif v2 == 6 then
                    costs = 176
                elseif v2 == 7 then
                    costs = 199
                elseif v2 == 8 then
                    costs = 107
                elseif v2 == 9 then
                    costs = 80
                elseif v2 == 10 then
                    costs = 190
                elseif v2 == 11 then
                    costs = 110
                elseif v2 == 12 then
                    costs = 472
                elseif v2 == 13 then
                    costs = 90
                elseif v2 == 14 then
                    costs = 240
                elseif v2 == 15 then
                    costs = 300
                elseif v2 == 16 then
                    costs = 115
                end
                
                if costs ~= 0 then
                    do_message(npc, ch, string.format("Das würde %s Aki kosten! Soll ich dir deine Haare nun schneiden?", costs))
                    while true do
                        local v3 = do_choice(npc, ch, "Ja", "Nein")
                        if v3 == 1 then
                            if mana.chr_money(ch) >= costs then
                                mana.chr_money_change(ch, -costs)
                                mana.chr_set_hair_style(ch, v2)
                                do_message(npc, ch, "Der neue Schnitt steht dir gut!")
                            else
                                do_message(npc, ch, "Du hast nicht genug Geld bei dir!")
                            end
                            break
                        elseif v3 == 2 then
                            do_message(npc, ch, "Auf Wiedersehen")
                            break
                        end
                    end
                    break
                end
            end
            break
        elseif v == 2 then
            do_message(npc, ch, "Welche Farbe willst du?")
            while true do
                local v2 = do_choice(npc, ch, "Blond", "Grün", "Rot", "Violett", "Grau", "Gelb", "Blau", "Braun",
                                               "hell Blau", "dunkel Violett", "Schwarz")
                
                if v2 >= 1 or v2 <= 11 then
                    do_message(npc, ch, "Das Färben kostet 100 Aki!")
                    while true do
                        local v3 = do_choice(npc, ch, "Ok. Fang an!", "Nee, dann doch nicht")
                        if v3 == 1 then
                            if mana.chr_money(ch) >= 100 then
                                mana.chr_money_change(ch, -100)
                                mana.chr_set_hair_color(ch, v2 - 1)
                            else
                                do_message(npc, ch, "Du hast nicht genug Geld dabei!")
                            end
                            break
                        elseif v3 == 2 then
                            do_message(npc, ch, "Auf Wiedersehn!")
                            break
                        end
                    end
                    break
                end
            end
            break
        elseif v == 3 then
            do_message(npc, ch, "Auf Wiedersehn!")
            break
        end
    end
    do_npc_close(npc, ch)
end
