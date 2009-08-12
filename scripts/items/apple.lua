-- Example use script. Makes the player character say "*munch*munch*munch*" when using this item.
-- The HP regeneration effect is handled separately based on the heal value in items.xml

function use(user)
	tmw.being_say(user, "*mampf*mampf*mampf*")
end
