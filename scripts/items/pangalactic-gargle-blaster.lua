require "scripts/lua/npclib"
require "scripts/libs/invertika"

function use(user)
    being_say(user, invertika.get_random_element("Galaktisch...",
      "Jaaa die Antwort ist 42...",
      "Die Frage ist so simpel...",
      "Wuuuuuuuuuuuuuush",
      "Wo ist mein Bademantel?",
      "Wieviel ist sieben mal sechs?",
      "Morgen schwebe ich!"))
    effect_create(2, user)
end
