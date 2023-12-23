/*
	Is p simple, if you need to refactor/change a bunch of shit cause its breaking, 
	you move the version number up on the config
	then you put the code to handle updating the data from last version to current version down there.
	It will nab it on the load, and when it gets saved whenever its now updated.
*/



/datum/Persistence_JSON/proc/admin_datum_version_update(given_assc_list)
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
			if(given_data_version == CONFIG_PERSIST_ADMIN_DATUM_VERSION) // Now we are up to date, and we send it back over to be loaded, and shit don't break.
				return modified_list

	*/

	if(given_data_version == CONFIG_PERSIST_ADMIN_DATUM_VERSION)
		return modified_list