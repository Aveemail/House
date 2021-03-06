/obj/effect/decal/cleanable
	var/list/random_icon_states = list()
	var/targeted_by = null			// Used so cleanbots can't claim a mess.

	var/beauty = 0

/obj/effect/decal/cleanable/atom_init()
	if (random_icon_states && length(random_icon_states) > 0)
		icon_state = pick(random_icon_states)
	. = ..()
	decal_cleanable += src

	AddElement(/datum/element/beauty, beauty)

/obj/effect/decal/cleanable/Destroy()
	decal_cleanable -= src
	return ..()
