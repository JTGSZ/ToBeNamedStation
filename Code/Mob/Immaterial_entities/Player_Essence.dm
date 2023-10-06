/*
	The first step in the chain, a player joins and a essence is created.
	It has a spirit, and will soon be turned into a soul forming that union (After they are done with our menus)
*/

/mob/player_essence
	name = "Essence"
	desc = "The first step in the cycle towards a complete being."
	icon_state = "gear"

	density = FALSE


/mob/player_essence/New()
	..()

/mob/player_essence/Destroy()
	. = ..()

/*
	Ok so since we are the first mob that a player is crammed into we have a few priotiesi here
	We need to give them a spirit since that is a abstract data holder for shit that follows them around.
	We also need to give them the titlescreen and menus.

	Also calling parent too far makes us do a worldscan (Past mob) for the closest open turf to 1,1,1 if we don't give them one
	Sensible for laziness but absolutely brutal on cpu.
*/
/mob/player_essence/Login()
	if(!current_spirit)
		current_spirit = new /datum/player_spirit(key)

	if(map_mark_list[MAPMARK_NEWPLAYERSTART] && islist(map_mark_list[MAPMARK_NEWPLAYERSTART]))
		if(map_mark_list[MAPMARK_NEWPLAYERSTART].len)
			var/obj/map_mark/chosen_mark = pick(map_mark_list[MAPMARK_NEWPLAYERSTART])
			loc = chosen_mark.loc
	else
		loc = locate(2,2,1)

	..()

/mob/player_essence/Logout()
	..()

//This proc name sucks
//But its basically us cramming this cunt into another mob.
/mob/player_essence/proc/Essence_Unto_Soul()
	var/mob/player_soul/new_soul = new()
	current_spirit.transfer_player_to_target(new_soul)
	qdel(src)




