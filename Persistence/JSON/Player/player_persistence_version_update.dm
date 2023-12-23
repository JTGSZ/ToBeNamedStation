



/datum/Persistence_JSON/proc/player_data_version_update(given_assc_list)
	var/list/modified_list = given_assc_list
	var given_data_version = given_assc_list["version"]

	/* 
		EX:
			if(given_data_version == 0)
				modified_list["cock"] = 12
				given_data_version += 1
			if(given_data_version == 1)
				modified_list["balls"] = 99
				given_data_version += 1
			if(given_data_version == CONFIG_PERSIST_PLAYER_DATA_VERSION) // Now we are up to date, and we send it back over to be loaded, and shit don't break.
				return modified_list

	*/

	if(given_data_version == CONFIG_PERSIST_PLAYER_DATA_VERSION)
		return modified_list