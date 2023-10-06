/*
	Atom has both icon and icon_state on it.
	We also don't plan on letting people actively interact with these as they just 
*/

/obj/map_mark
	name = "Map Marker"
	desc = "A marker for a MAP HEH"
	// The map marker spirit cannot be seen, perceived, or interacted with
	invisibility = INVISIBILITY_SPIRITSPACE

/obj/map_mark/New()
	handle_map_markers_list()
	..()

//For futures sake im gonna stick this here
/obj/map_mark/proc/handle_map_markers_list()
	//If we find a key, and the thing attached to it is a list we r good to go
	if( (map_mark_list["[name]"]) && (islist(map_mark_list["[name]"])) )
		map_mark_list["[name]"] += src
	else //In the offchance we can't find the key, and a list isn't in there we handle it ourselves
		map_mark_list["[name]"] = list()
		map_mark_list["[name]"] += src


/obj/map_mark/new_player_start
	name = MAPMARK_NEWPLAYERSTART