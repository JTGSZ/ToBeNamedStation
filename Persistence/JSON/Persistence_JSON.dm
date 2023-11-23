/*
	Probably unnecessary but why not lol
*/

/datum/Persistence_JSON


/*
	Some JSON helpers so I don't forget how this shit works and its the prelinary way i will save more pre
*/

//Target path must be a string
/proc/get_list_from_jsonfile(target_path)
	var/list/loaded_data = list()

	var/target_file = file(target_path)
	loaded_data = json_decode(target_file)

	return loaded_data

//Target path must be a string
//Will check and do somethin akin to overwriting whats there
/proc/save_list_to_jsonfile(target_path, var/list/data_to_save)
	if(fexists("[target_path]"))  // File exists at target path
		if(!fdel("[target_path]")) // If for some reason we can't delete it we stop here
			return FALSE

	if(!data_to_save.len) // If the list contains nothing at all
		return FALSE // We just stop here

	var/writing = file("[target_path]")
	writing << json_encode(data_to_save)
	return TRUE


/*
	This is how we save a single admin json datum
*/
/datum/Persistence_JSON/proc/admin_datum_to_json(datum/admins/cur_holder)
	world_msg("we began")
	var owners_ckey = cur_holder.owner_ckey //Get the owners ckey from the admin datum

	if(fexists("[CONFIG_PERSIST_ADMINROSTER_FOLDER]/[owners_ckey].json")) //check if the file already exists
		if(!fdel("[CONFIG_PERSIST_ADMINROSTER_FOLDER]/[owners_ckey].json")) //delete the old file.
			world_msg("unable to clear [owners_ckey]'s old file!") //Something fucked up happened
			return FALSE //stop here right now

	var/writing = file("[CONFIG_PERSIST_ADMINROSTER_FOLDER]/[owners_ckey].json") //We are writing the file to this location
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

	data_to_save["rank"] = cur_holder.rank
	data_to_save["rights"] = cur_holder.rights
	writing << json_encode(data_to_save)

/*
	This is how we pull information out of the directory
	Then proceed to dump it into datums which will be put into a global list of admin datums
*/
/datum/Persistence_JSON/proc/admin_json_directory_to_datumlist()
	var/list/admin_flatfiles = flist(CONFIG_PERSIST_ADMINROSTER_FOLDER)
	if(!admin_flatfiles.len)
		world_msg("No Admins detected in admin_json just create a file with the ckey or use the command if it exists or some shit")
	else
		for(var/ckey in admin_flatfiles)
			var/actualKey = splicetext(ckey, length(ckey)-4, 0, "")//We need to remove the file ending here from the string and bring it down to ckey
			var/reading = file("[CONFIG_PERSIST_ADMINROSTER_FOLDER][ckey]")
			var/list/loaded_list = json_decode(file2text(reading))
			//for(var/key in loaded_list)
			//	world.log << "[key][loaded_list[key]]"
			//world.log << "[json_decode(reading)]"

			var/datum/admins/current_datum = new(loaded_list["rank"], loaded_list["rights"], actualKey) // We make the datum
			admin_datums[actualKey] = current_datum //Our current datum

