/*
	Verb for setting up a initial admin_roster list with a host.
*/
/mob/verb/gen_initial_admin_ckeys()
	var/datum/admins/new_holder = new("Host", R_HOST, src.ckey)
	//Persistence_Controller.admin_datum_to_json(new_holder)
	//var/list/testing = list()
	//testing["TEST"] = 400
	//save_list_to_jsonfile(CONFIG_PERSIST_ADMINROSTER_FOLDER, testing)
	Persistence_Controller.admin_datum_to_json(new_holder)


/mob/verb/report_my_loc()
	world_msg("[loc]")

/mob/player_essence/verb/test_transfer()
	src.Essence_Unto_Soul()