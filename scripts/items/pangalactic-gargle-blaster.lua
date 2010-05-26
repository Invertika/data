require "scripts/libs/npclib"
require "scripts/ivklibs/invertika"

function use(user)
	mana.being_say(user, invertika.get_random_element("Galaktisch...",
	  "Jaaa die Antwort ist 42...",
	  "Die Frage ist so simpel...",
	  "Wuuuuuuuuuuuuuush",
	  "Wo ist mein Bademantel?",
	  "Wieviel ist sieben mal sechs?"))
	  
	  local x = mana.posX(user) + 128
	  local y = mana.posY(user)
	  
	  local save = mana.being_get_speed(user)
	  
	  mana.being_walk(user, x , y , 400 )
	  
	  mana.being_set_speed(user, save)
end
