require "data/scripts/libs/npclib"
require "data/scripts/ivklibs/invertika"

function use(user)
	tmw.being_say(user, invertika.get_random_element("Galaktisch...",
	  "Jaaa die Antwort ist 42...",
	  "Die Frage ist so simpel...",
	  "Wuuuuuuuuuuuuuush",
	  "Wo ist mein Bademantel?",
	  "Wieviel ist sieben mal sechs?"))
	  
	  local x = tmw.posX(user)
	  local y = tmw.posY(user)
	  
	  tmw.being_walk(user, x+128, y, 400)
end