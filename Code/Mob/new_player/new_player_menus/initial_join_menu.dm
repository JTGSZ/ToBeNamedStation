/*
	Placeholder for an initial join menu
	To note It will def need to be aesthetically pleasing later as its gonna the first shit a person looks at
*/

/datum/ui/initial_join_menu

/datum/ui/initial_join_menu/proc/display_initial_join_menu()
	//var/datum/player_persistence_data/persist_data = player_persistence_data_cache["[requestor.ckey]"]
	var/html = ""
	
	html += "THIS HAS NOTHING IN IT, ITS A PLACEHOLDER."
	
	our_window = new(requestor, "pref_ui", "Pref UI", 600, 450, src)
	our_window.html_content = html
	our_window.quickset_stylesheet(STYLESHEET_SS13_COMMON)
	our_window.fire_browser()
