/*
	TURF PARENT
*/
/turf

/turf/floor
	icon = 'zAssets/Turf/desertsand.dmi'
	icon_state = "sand1"
	var/list/cum_list = list("ASS", "TITTIES", 5) // Another test value

/turf/floor/New()
	if(prob(5))
		icon_state = "sand[rand(2,4)]"
	else
		icon_state = "sand1"

/turf/proc/cocks()
	//This is mostly to check the list procs