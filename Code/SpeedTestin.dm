/*
	Verb for setting up a initial admin_roster list with a host.
*/
/mob/verb/gen_initial_admin_ckeys()
	var/list/fucks = list()
	fucks[src.client.ckey] = ADMINRANK_HOST
	save_list_to_jsonfile(CONFIG_PERSIST_ADMINROSTER, fucks)

/mob/verb/report_my_loc()
	world << "[loc]"

/mob/player_essence/verb/test_transfer()
	src.Essence_Unto_Soul()