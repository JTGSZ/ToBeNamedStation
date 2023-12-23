/client/verb/change_fps()
	set name = ".change_fps"
	set hidden = 1

	var/desiredfps = input(usr, "Choose your desired fps.\n-1 means recommended value (currently:[CONFIG_PREF_RECC_CLIENT_FPS])\n0 means world fps (currently:[world.fps])", "FPS", fps)  as null|num
	if(desiredfps)
		fps = desiredfps

		var/datum/player_persistence_data/found_data = Persistence_Controller.get_player_data(ckey)
		found_data.client_fps = desiredfps

