/*
	TURF PARENT
*/
/turf

/turf/floor
	icon = 'zAssets/Turf/desertsand.dmi'
	icon_state = "sand1"

/turf/floor/New()
	if(prob(5))
		icon_state = "sand[rand(2,4)]"
	else
		icon_state = "sand1"

