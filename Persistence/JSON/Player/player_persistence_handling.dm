/*
	One may ask, but why didn't you just seperate it into different files?
	Why didn't you put the prefs on the client?
	My answer is, we PROBABLY will do better if less files are opened/handled. (This is a PROBABLY)
	This includes the fact we should cache these bitches instead of just read the shit and load it everytime the client rejoins in one session of running the server.
	So in a clean way - Client joins, gets multiple jsons handled, leaves saves joins loads leaves saves repeat 5x
	In this annoying way - Client joins, gets one json handled, leaves, comes back and the datas already stored from earlier. When server shuts off it just saves/periodically saves
*/

//this is an assc list, as we can't hold anything that requires utmost precision if a person is in and out/wiping data on the client.
//Also to note the keys are ckeys so player_persistence_data["[ckey]"]
var/global/list/player_persistence_data_cache = list()


/datum/Persistence_JSON/proc/handle_player_data(client/given_client)
	if(!given_client) // If we received no client whats the point?
		return

	var/target_ckey = given_client.ckey
	if(player_persistence_data_cache["[target_ckey]"]) // We see if they have data already stored in the assc list
		return player_persistence_data_cache["[target_ckey]"] // return the datum to the caller
	else // We didn't find anything attached to the key in this assc list

		if(!load_player_data_via_ckey(target_ckey)) //This returns false if it doesn't find shit in the file directory, otherwise it loads the data in
			var/datum/player_persistence_data/xtra_fresh = new() //Time to make a fresh datum
			xtra_fresh.all_persistence_data_to_defaults()// Set everything to the defaults.
			player_persistence_data_cache["[target_ckey]"] = xtra_fresh //cram it in
			return xtra_fresh //And there u go new or pissed off player your clean data.
		else
			return player_persistence_data_cache["[target_ckey]"] //We loaded in found data, just return this


//Get some player data
/datum/Persistence_JSON/proc/get_player_data(given_ckey)
	var/datum/player_persistence_data/found_data = player_persistence_data_cache["[given_ckey]"]
	if(found_data)
		return found_data