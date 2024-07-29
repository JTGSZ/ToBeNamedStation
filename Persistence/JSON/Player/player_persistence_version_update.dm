



/datum/Persistence_JSON/proc/player_data_version_update(given_assc_list)
	var/list/modified_external_data = given_assc_list

	// We don't hold the version in the cache during runtime
	// It gets dumped into the external file during saving
	var/temp_data_version = given_assc_list["version"]

	/* 
		EX:
			if(temp_data_version == 0)
				modified_external_data["cock"] = 12
				temp_data_version += 1
			if(temp_data_version == 1)
				modified_external_data["balls"] = 99
				temp_data_version += 1

			if(temp_data_version == CONFIG_PERSIST_PLAYER_DATA_VERSION) // Now we are up to date, and we send it back over to be loaded, and shit don't break.
				return modified_external_data

	*/

	if(temp_data_version == CONFIG_PERSIST_PLAYER_DATA_VERSION)
		return modified_external_data