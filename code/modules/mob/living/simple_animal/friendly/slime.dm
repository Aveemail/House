// shouldn't these be deprecated? ~Luduk
/mob/living/simple_animal/slime
	name = "pet slime"
	desc = "A lovable, domesticated slime."
	icon = 'icons/mob/slimes.dmi'
	icon_state = "grey baby slime"
	icon_living = "grey baby slime"
	icon_dead = "grey baby slime dead"
	speak_emote = list("chirps")
	health = 100
	maxHealth = 100
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"
	emote_see = list("jiggles", "bounces in place")
	var/colour = "grey"
	ventcrawler = 2

	typing_indicator_type = "slime"

	has_head = TRUE
	moveset_type = /datum/combat_moveset/slime

/mob/living/simple_animal/adultslime
	name = "pet slime"
	desc = "A lovable, domesticated slime."
	icon = 'icons/mob/slimes.dmi'
	health = 200
	maxHealth = 200
	icon_state = "grey adult slime"
	icon_living = "grey adult slime"
	icon_dead = "grey baby slime dead"
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"
	emote_see = list("jiggles", "bounces in place")
	w_class = SIZE_HUMAN
	var/colour = "grey"

	typing_indicator_type = "slime"

	has_head = TRUE
	moveset_type = /datum/combat_moveset/slime

/mob/living/simple_animal/adultslime/atom_init()
	. = ..()
	add_overlay("aslime-:33")
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_SLIME)


/mob/living/simple_animal/slime/adult/death()
	var/mob/living/simple_animal/slime/S1 = new /mob/living/simple_animal/slime (src.loc)
	S1.icon_state = "[src.colour] baby slime"
	S1.icon_living = "[src.colour] baby slime"
	S1.icon_dead = "[src.colour] baby slime dead"
	S1.colour = "[src.colour]"
	var/mob/living/simple_animal/slime/S2 = new /mob/living/simple_animal/slime (src.loc)
	S2.icon_state = "[src.colour] baby slime"
	S2.icon_living = "[src.colour] baby slime"
	S2.icon_dead = "[src.colour] baby slime dead"
	S2.colour = "[src.colour]"
	med_hud_set_health()
	med_hud_set_status()
	qdel(src)
