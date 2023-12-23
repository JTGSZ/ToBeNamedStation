/*
	The input script and probably entire system definitely needs rewritten, I can feel it in my bones.
*/



/client/verb/display_input_rebinder()
	set name = ".display_input_ui"
	set hidden = 1
	
	var/datum/ui/input_rebinder/ass = new()
	ass.requestor = src
	ass.display_input_rebinder_menu()

/datum/ui/input_rebinder

/datum/ui/input_rebinder/proc/display_input_rebinder_menu()
	var/list/persist_data_keymap = player_persistence_data_cache["[requestor.ckey]"].input_keymap
	var/html = ""
	
	html += "<div id='test'>"
	html += "<a href='?src=\ref[src];reset_prefs_to_defaults=1'>Reset To Defaults</a><br>"
	html += "<b>Press ESC after clicking a button to Unbind something</b> <br><hr>"

	for(var/bustin in bindcomm_data_cache)
		var/datum/bindcomm_data/into_anime_bitches = bindcomm_data_cache[bustin]
		html += "<span>[into_anime_bitches.pretty_name]</span>"
		
		for(var/splort in persist_data_keymap)
			if(splort == into_anime_bitches.command_name)
				var/persist_keybind = persist_data_keymap[splort]
				html += "<button type='button' value='[into_anime_bitches.command_name]' onclick='start_up_rebinding(this.value)'>[persist_keybind]</button>"
			//if(client_input_keymap[target_input] == target_command)
				//html += "<button type='button' value='[target_command]' onclick='start_up_rebinding(this.value)'>[target_input]</button>"

		html += "<br>"

	html += "</div>"
	html += "<div id='cocks'>"
	html += "</div>"

	// Well this is the laziest way to send over a var that has the target ref I guess
	//If you want to do it in another way feel free to try your hand at trying to make C << output("\\ref[src]\", "our_window.window_id:YOUR FUNCTION") work
	html += "<script> var target_ref = \"\ref[src]\";</script>" 
	
	our_window = new(requestor, "input_rebinder", "Input Rebinder", 600, 450, src)
	our_window.attach_file('zHTML/input_ui.js', LOAD_AFTER_HTML_CONTENT)
	our_window.html_content = html
	our_window.quickset_stylesheet(STYLESHEET_SS13_COMMON)
	our_window.fire_browser()

/datum/ui/input_rebinder/Topic(href, href_list)
	. = ..()
	if(href_list["Rebind_Input"])

		if(href_list["Given_Command"] && href_list["Given_Input"])
			var/target_command = href_list["Given_Command"]
			var/target_input = href_list["Given_Input"]
			//world_msg("[target_command]")
			//world_msg("[target_input]")
			target_input = uppertext(target_input) // uppertext it now i guess
			requestor.rebind_input(target_command, target_input)

			display_input_rebinder_menu() // I got no updater system right now, so just reload the page

	if(href_list["reset_prefs_to_defaults"])
		player_persistence_data_cache["[requestor.ckey]"].persistence_inputmap_to_default()
		requestor.sync_input_keymaps()

		display_input_rebinder_menu() // I got no updater system right now, so just reload the page
		



	
