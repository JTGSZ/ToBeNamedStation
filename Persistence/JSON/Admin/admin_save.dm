/*
	This is how we save a single admin json datum
*/
/datum/Persistence_JSON/proc/admin_datum_to_json(datum/admins/cur_holder)
	var owners_ckey = cur_holder.owner_ckey //Get the owners ckey from the admin datum

	if(fexists("[CONFIG_PERSIST_ADMINROSTER_FOLDER][owners_ckey].json")) //check if the file already exists
		if(!fdel("[CONFIG_PERSIST_ADMINROSTER_FOLDER][owners_ckey].json")) //delete the old file.
			world_msg("unable to clear [owners_ckey]'s old file!") //Something fucked up happened
			return FALSE //stop here right now

	var/writing = file("[CONFIG_PERSIST_ADMINROSTER_FOLDER][owners_ckey].json") //We are writing the file to this location
	var/list/data_to_save = list() //Of course we are saving a list

	//If they literally have nothing put in for the rank, we shall make them nothing
	if(cur_holder.rank == "")
		cur_holder.rank = "NoRank"

	/*
		Basically theres like three things we want out of a admin datum.
		The CKEY which is saved in the name
		The Cosmetic rank which is just a string aptly on the verb named rank on the datum itself
		And we want the rights which is a bitflag which can also be seen as a int i guess
	*/
	data_to_save["version"] = CONFIG_PERSIST_ADMIN_DATUM_VERSION
	data_to_save["rank"] = cur_holder.rank
	data_to_save["rights"] = cur_holder.rights
	writing << json_encode(data_to_save)