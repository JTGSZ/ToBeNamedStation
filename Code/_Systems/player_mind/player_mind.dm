/*
	This is basically a IC data holder for things relating to the mind of the character.
	We got a split on the body/mind really. BRAIN POWER or some shit
*/

/*
	A assc list of all player_minds currently in the game
	Which is where we store needed runtime data tied to the player themselves.
	See: player_mind.dm
	CONTENTS:
		"KEY" - /datum/player_mind
*/
var/global/list/list_of_player_minds = list()


/datum/player_mind
	//Basically this is the key of the player we are tied towards.
	var/owners_key = null

	//The soul we are currently linked to
	var/mob/player_soul/current_soul = null


//Its BRAND NEW
/datum/player_mind/New(key)
	owners_key = key //Put the key unto us for trackin
	list_of_player_minds["[key]"] = src //Then we add ourselves to a global assc list with the key and the src
	..()


/datum/player_mind/Destroy()
	current_soul = null
	..()

/*
	Helper to transfer this to something else
*/
/datum/player_mind/proc/full_transfer_to(mob/player_soul/M)
	M.player_mind = src
	M.key = owners_key

	world << "Spirit transfer performed"
