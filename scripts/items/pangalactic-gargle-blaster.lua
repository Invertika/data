require "data/scripts/libs/npclib"
require "data/scripts/ivklibs/invertika"

function use(user)
	mana.being_say(user, invertika.get_random_element("Galaktisch...",
	  "Jaaa die Antwort ist 42...",
	  "Die Frage ist so simpel...",
	  "Wuuuuuuuuuuuuuush",
	  "Wo ist mein Bademantel?",
	  "Wieviel ist sieben mal sechs?"))
	  
	  local x = mana.posX(user)
	  local y = mana.posY(user)
	  
	  mana.being_walk(user, x+128, y, 400)
end