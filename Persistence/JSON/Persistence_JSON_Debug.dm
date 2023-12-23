/*
	Just some debug helpers here, prob worthless as shit
*/
/mob/verb/save_player_data()
	set category = "DEV-Debug"
	Persistence_Controller.save_player_data_to_json_via_ckey(src.ckey)

/mob/verb/load_player_data()
	set category = "DEV-Debug"
	Persistence_Controller.load_player_data_via_ckey(src.ckey)