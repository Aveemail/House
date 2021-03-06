
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// fossils

/obj/item/weapon/fossil
	name = "Fossil"
	icon = 'icons/obj/xenoarchaeology/finds.dmi'
	icon_state = "bone"
	desc = "It's a fossil."
	var/animal = 1

/obj/item/weapon/fossil/base/atom_init()
	..()
	var/list/l = list(
		/obj/item/weapon/fossil/bone = 9,
		/obj/item/weapon/fossil/skull = 3,
		/obj/item/weapon/fossil/skull/horned = 2
		)
	var/t = pickweight(l)
	var/obj/item/weapon/W = new t(loc)
	var/turf/simulated/mineral/T = get_turf(src)
	if(istype(T))
		T.last_find = W

	return INITIALIZE_HINT_QDEL

/obj/item/weapon/fossil/bone
	name = "Fossilised bone"
	icon_state = "bone1"
	desc = "It's a fossilised bone."

/obj/item/weapon/fossil/bone/atom_init()
	. = ..()
	icon_state = "bone[rand(1, 3)]"

/obj/item/weapon/fossil/skull
	name = "Fossilised skull"
	icon_state = "skull"
	desc = "It's a fossilised skull."

/obj/item/weapon/fossil/skull/atom_init()
	. = ..()
	icon_state = "skull[rand(1, 3)]"

/obj/item/weapon/fossil/skull/horned
	icon_state = "hskull"
	desc = "It's a fossilised, horned skull."

/obj/item/weapon/fossil/skull/horned/atom_init()
	. = ..()
	icon_state = "horned_skull[rand(1, 2)]"

/obj/item/weapon/fossil/skull/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/fossil/bone))
		var/obj/o = new /obj/skeleton(get_turf(src))
		var/a = new /obj/item/weapon/fossil/bone
		var/b = new src.type
		o.contents.Add(a)
		o.contents.Add(b)
		qdel(I)
		qdel(src)
		return
	return ..()

/obj/skeleton
	name = "Incomplete skeleton"
	icon = 'icons/obj/xenoarchaeology/finds.dmi'
	icon_state = "uskel"
	desc = "Incomplete skeleton."
	w_class = SIZE_LARGE
	var/bnum = 1
	var/breq
	var/bstate = 0
	var/plaque_contents = "Unnamed alien creature"

/obj/skeleton/atom_init()
	. = ..()
	breq = rand(3) + 2
	desc = "An incomplete skeleton, looks like it could use [src.breq-src.bnum] more bones."

/obj/skeleton/attackby(obj/item/weapon/W, mob/user)
	if(istype(W,/obj/item/weapon/fossil/bone))
		if(!bstate)
			bnum++
			contents.Add(new/obj/item/weapon/fossil/bone)
			qdel(W)
			if(bnum==breq)
				usr = user
				icon_state = "skel"
				src.bstate = 1
				src.density = TRUE
				src.name = "alien skeleton display"
				if(contents.Find(/obj/item/weapon/fossil/skull/horned))
					src.desc = "A creature made of [src.contents.len-1] assorted bones and a horned skull. The plaque reads \'[plaque_contents]\'."
				else
					src.desc = "A creature made of [src.contents.len-1] assorted bones and a skull. The plaque reads \'[plaque_contents]\'."
			else
				src.desc = "Incomplete skeleton, looks like it could use [src.breq-src.bnum] more bones."
				to_chat(user, "Looks like it could use [src.breq-src.bnum] more bones.")
		else
			..()
	else if(istype(W,/obj/item/weapon/pen))
		plaque_contents = sanitize(input("What would you like to write on the plaque:","Skeleton plaque",""))
		user.visible_message("[user] writes something on the base of [src].","You relabel the plaque on the base of [bicon(src)] [src].")
		if(contents.Find(/obj/item/weapon/fossil/skull/horned))
			src.desc = "A creature made of [src.contents.len-1] assorted bones and a horned skull. The plaque reads \'[plaque_contents]\'."
		else
			src.desc = "A creature made of [src.contents.len-1] assorted bones and a skull. The plaque reads \'[plaque_contents]\'."
	else
		..()

//shells and plants do not make skeletons
/obj/item/weapon/fossil/shell
	name = "Fossilised shell"
	icon_state = "shell"
	desc = "It's a fossilised shell."

/obj/item/weapon/fossil/shell/atom_init()
	. = ..()
	icon_state = "shell[rand(1, 2)]"

/obj/item/weapon/fossil/plant
	name = "Fossilised plant"
	icon_state = "plant1"
	desc = "It's fossilised plant remains."
	animal = 0

/obj/item/weapon/fossil/plant/atom_init()
	. = ..()
	icon_state = "plant[rand(1, 4)]"
