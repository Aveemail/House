/obj/item/device/analyzer
	desc = "A hand-held environmental scanner which reports current gas levels."
	name = "analyzer"
	icon_state = "atmos"
	item_state = "analyzer"
	w_class = SIZE_TINY
	flags = CONDUCT | NOBLUDGEON | NOATTACKANIMATION
	slot_flags = SLOT_FLAGS_BELT
	throwforce = 5
	throw_speed = 4
	throw_range = 20
	m_amt = 30
	g_amt = 20
	origin_tech = "magnets=1;engineering=1"

	action_button_name = "Use Analyzer"

	var/advanced_mode = 0

/obj/item/device/analyzer/verb/verbosity(mob/user as mob)
	set name = "Toggle Advanced Gas Analysis"
	set category = "Object"
	set src in usr

	if (!user.incapacitated())
		advanced_mode = !advanced_mode
		to_chat(usr, "You toggle advanced gas analysis [advanced_mode ? "on" : "off"].")

/obj/item/device/analyzer/attack_self(mob/user)

	if (user.incapacitated())
		return

	analyze_gases(user.loc, user,advanced_mode)
	return TRUE

/obj/item/device/analyzer/afterattack(atom/target, mob/user, proximity, params)
	if(!proximity)
		return
	if (user.incapacitated())
		return
	if(!isobj(target))
		return
	var/obj/O = target
	if(O.simulated)
		analyze_gases(O, user, advanced_mode)
