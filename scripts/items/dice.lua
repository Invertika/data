require "scripts/libs/invertika"
require "scripts/libs/dice"

function use(user)
    local dice_value = dice.get_new_dice_value()
	mana.being_say(user, invertika.get_random_element(
      string.format("Eine %d!", dice_value),
      string.format("Schon wieder eine %d!", dice_value)
      string.format("%d Augen.", dice_value)))
end

