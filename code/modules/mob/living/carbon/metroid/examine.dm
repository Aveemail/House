/mob/living/carbon/slime/examine(mob/user)
	var/msg = "<span class='info'>*---------*\nThis is [bicon(src)] \a <EM>[src]</EM>!\n"
	if (src.stat == DEAD)
		msg += "<span class='deadsay'>It is limp and unresponsive.</span>\n"
	else
		if (getBruteLoss())
			msg += "<span class='warning'>"
			if (getBruteLoss() < 40)
				msg += "It has some punctures in its flesh!"
			else
				msg += "<B>It has severe punctures and tears in its flesh!</B>"
			msg += "</span>\n"

		switch(powerlevel)
			if(2 to 3)
				msg += "It is flickering gently with a little electrical activity.\n"
			if(4 to 5)
				msg += "It is glowing gently with moderate levels of electrical activity.\n"
			if(6 to 9)
				msg += "<span class='warning'>It is glowing brightly with high levels of electrical activity.</span>\n"
			if(10)
				msg += "<span class='warning'><B>It is radiating with massive levels of electrical activity!</B></span>\n"

	if(w_class)
		msg += "It is a [get_size_flavor()] sized creature.\n"

	msg += "*---------*</span>"
	to_chat(user, msg)
