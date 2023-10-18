/*
	MOB PARENT
*/
/mob
	step_size = 8

	//A var to hold the player_spirit which is jus a container of data tied to the player
	// If we don't see any reason to move this to other mobs then it can jus be moved up to player_essence and player_soul
	// We can't move it to atom/movable as theres no place for a key so whats the point
	var/datum/player_spirit/current_spirit = null

/*
	Called when we are first created
*/
/mob/New()
	..()
/*
	Called when we are qdel'd
*/
/mob/Destroy()
	. = ..()
/*
	ON_INITIAL_CONNECTION -
		Basically client/New() calls this before it returns
		Basically theres a few things to note, if ..() is called here it will iterate through every single turf in the world.
		This is in an attempt to force it as close as possible to the coordinate position of 1,1,1 on the map.
	ON_MOB_SWAP - The scenario where you either set key = newshit or client.mob = whatev fuckin mob
		Basically just calls this
*/
/mob/Login()
	//world_msg("Mob Login")
	//..()

/*
	ON_INITIAL_CONNECTION -
		Basically when client/Del() runs this is called on first connect
		It don't do nothin unless you want it to do something.
	ON_MOB_SWAP - The scenario where you either set key = newshit or client.mob = whatev fuckin mob
		Basically just calls this
*/
/mob/Logout()
	//world_msg("Mob Logout")
	..()
	
	