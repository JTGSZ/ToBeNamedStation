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
			
			//We had a breaking change, and now the old data needs to be fixed before we put it back in.
			if(loaded_list["version"] != CONFIG_PERSIST_ADMIN_DATUM_VERSION)
				loaded_list = admin_datum_version_update(loaded_list)

			var/datum/admins/current_datum = new(loaded_list["rank"], loaded_list["rights"], actualKey) // We make the datum
			GLOB.admin_datums[actualKey] = current_datum //Our current datum