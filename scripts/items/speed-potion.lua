require "scripts/lua/npclib"

function use(user)
	  mana.being_set_speed(user, 10.0) -- 10 Tiles pro Sekunde (normalerweise 6)
	  mana.being_apply_status(user, 3, 150) -- Entfernt die Geschwindigkeit später wieder
end
