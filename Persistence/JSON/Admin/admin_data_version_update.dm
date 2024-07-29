/*
	Is p simple, if you need to refactor/change a bunch of shit cause its breaking, 
	you move the version number up on the config
	then you put the code to handle updating the data from last version to current version down there.
	It will nab it on the load, and when it gets saved whenever its now updated.
*/



/datum/Persistence_JSON/proc/admin_datum_version_update(given_assc_list)
	var/list/modified_external_data = given_assc_list

	// We don't hold the version in the cache during runtime
	// It gets dumped into the external file during saving
	var/temp_data_version = given_assc_list["version"] 

	if(temp_data_version == 0)
		var/prev_cosmetic_rank = modified_external_data["rank"]
		modified_external_data.Remove("rank")
		modified_external_data.Remove("rights")
		modified_external_data["cosmetic_rank"] = prev_cosmetic_rank
		modified_external_data["admin_rights"] = list(ADMIN_RIGHTS_ADMIN)

		temp_data_version += 1

	/* 
		EX:
			if(temp_data_version == 0)
				modified_external_data["cock"] = 12
				temp_data_version += 1
			if(temp_data_version == 1)
				modified_external_data["balls"] = 99
				temp_data_version += 1

			if(temp_data_version == CONFIG_PERSIST_ADMIN_DATUM_VERSION) // Now we are up to date, and we send it back over to be loaded, and shit don't break.
				return modified_external_data
	*/

	if(temp_data_version == CONFIG_PERSIST_ADMIN_DATUM_VERSION)
		return modified_external_data