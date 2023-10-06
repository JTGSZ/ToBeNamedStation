/*
	Here is our flesh pilot
	the soul part of the trio and its the mob
*/

/mob/player_soul
	name = "ERROR" //These nigas need names
	icon = 'zAssets/Mob/unsorted.dmi'
	icon_state = "ghost"
	desc = "Effectively (probably) two parts of a three part being."

	//We a ghooost(soul)
	alpha = 128
	see_invisible = INVISIBILITY_SOULSPACE
	invisibility = INVISIBILITY_SOULSPACE
	
	density = FALSE

	//The current body we are supposed to be piloting.
	var/atom/movable/the_body = null

/mob/player_soul/New(loc)
	..()


