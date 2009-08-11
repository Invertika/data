-- This when applied to a being will spread from one being to another
-- Thats all it does.

function tick(target, ticknumber)
    if (ticknumber % 10 == 0) then
        tmw.being_say(target, "I have the plague! :( = " .. ticknumber)
    end
    local victims = tmw.get_beings_in_circle(tmw.posX(target), tmw.posY(target), 64)
    local i = 1
    while (victims[i]) do
       if (tmw.being_has_status(victims[i], 1) == false) then
           tmw.being_apply_status(victims[i], 1, 6000)
           tmw.being_say(victims[i], "I don't feel so good")
       end
       i = i + 1
    end
end
