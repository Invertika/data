-- Example use script. Makes the player character say "*munch*munch*munch*" when using this item.
-- The HP regeneration effect is handled separately based on the heal value in items.xml

require "scripts/libs/datetime"

function use(user)
	mana.being_say(user, string.format("Es es ist %s Uhr, am %s, im übrigen ist das ein %s.", datetime.get_current_time(), datetime.get_current_date(), datetime.get_current_weekday()))
end
