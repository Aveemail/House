/*

Miscellaneous traitor devices

BATTERER


*/

/*

The Batterer, like a flashbang but 50% chance to knock people over. Can be either very
effective or pretty fucking useless.

*/

/obj/item/device/batterer
	name = "mind batterer"
	desc = "A strange device with twin antennas."
	icon_state = "batterer"
	throwforce = 5
	w_class = SIZE_MINUSCULE
	throw_speed = 4
	throw_range = 10
	flags = CONDUCT
	item_state = "electronic"
	origin_tech = "magnets=3;combat=3;syndicate=3"

	var/times_used = 0 //Number of times it's been used.
	var/max_uses = 2


/obj/item/device/batterer/attack_self(mob/living/carbon/user, flag = 0, emp = 0)
	if(!user) 	return
	if(times_used >= max_uses)
		to_chat(user, "<span class='warning'>The mind batterer has been burnt out!</span>")
		return

	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used [src] to knock down people in the area.</font>")

	for(var/mob/living/carbon/human/M in orange(10, user))
		spawn()
			if(prob(50))

				M.Weaken(rand(10,20))
				if(prob(25))
					M.Stun(rand(5,10))
				to_chat(M, "<span class='warning'><b>You feel a tremendous, paralyzing wave flood your mind.</b></span>")

			else
				to_chat(M, "<span class='warning'><b>You feel a sudden, electric jolt travel through your head.</b></span>")

	playsound(src, 'sound/misc/interference.ogg', VOL_EFFECTS_MASTER)
	to_chat(user, "<span class='notice'>You trigger [src].</span>")
	times_used += 1
	if(times_used >= max_uses)
		icon_state = "battererburnt"




