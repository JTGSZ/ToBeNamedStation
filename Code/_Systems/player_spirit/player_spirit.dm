/*

	Ok so when someone disconnects, their client immediately clears out. 
	Thus we need another place to hold data
	Except we also need to bring it along if they hop like 20 mobs, or become some weird shit.
	Thus we condense all of it here in ss13 its called the mind I guess.

	Theres two ways to go about it, you can call it the mind body and soul
	Or we can go with the christian shit and go with spirit body and soul.

	The spirit is your connection to god, your soul is the thing that drives you, and your body is the wrapper around all of it.

	The actual ghost will be a players_soul and you can indeed split everything asunder deeply fucking them (and your world up in the process)

	Adversely, to further explain what we are being transferred with we have two vars on each mob tied to the player themselvs 
	on client they are read only
	on mobs they are not
	Key - value of players key and basically the desired one if they ain't ingame rn, basically if you hop back on this forces you into this one.
	Ckey - key w some formatting, aka lowercase and stripped down of shit apparently canonical or somethin
*/

/datum/player_spirit
	//Basically this is the key of the player we are tied towards.
	var/owners_key = null

	//The soul we are currently linked to
	var/mob/player_soul/current_soul = null


//Its BRAND NEW
/datum/player_spirit/New(key)
	owners_key = key //Put the key unto us for trackin
	list_of_player_spirits["[key]"] = src //Then we add ourselves to a global assc list with the key and the src
	..()


/datum/player_spirit/Destroy()
	current_soul = null
	..()

/*
	Helper to transfer this to something else
*/
/datum/player_spirit/proc/transfer_player_to_target(mob/player_soul/M)
	M.current_spirit = src
	M.key = owners_key

	world << "Spirit transfer performed"
