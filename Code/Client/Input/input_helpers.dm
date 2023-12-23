


// Its pretty simple, the /datum/bindcomm_data command name is the key on the players saved data. 
// Then we just make the value the actual keybind, as we can have multiple unbound shit which means duplicate input keys ain't viable, as long as thats same value checking data.
// On list/bindcomm_data_cache the command_name is the key holds a link to a ref to the data object for the command anyways.
/client/proc/rebind_input(target_action, target_keys)
	world_msg("target action: [target_action], target key: [target_keys]")

	
	var/list/persist_data_keymap = persist_data.input_keymap
	if(persist_data_keymap[target_action]) 
		if(target_keys != UNBOUND) 
			// Search for duplicate keybinds in the persist data keymap
			for(var/persist_command in persist_data_keymap)
				if(persist_data_keymap[persist_command] == target_keys) // Found a duplicate
					persist_data_keymap[persist_command] = persist_data_keymap[target_action] // Give the one that had the duplicate the target actions keybind even if its unbound

		// Now we just set it
		persist_data_keymap[target_action] = target_keys

	//Now we sync the client input keymap to the persist data keymap
	sync_input_keymaps()


//To note we are inversing the persist inputmap onto the client inputmap, here.
//as it has the keybinds first and then the command
//The command is used to find a ref to a data object on list/bindcomm_data_cache right now
/client/proc/sync_input_keymaps()

	var/list/persist_data_keymap = persist_data.input_keymap
	input_keymap.Cut() //clean out the old client inputmap
	movement_keymap.Cut() // clean this out too

	for(var/persist_command in persist_data_keymap)
		var/persist_keybind = persist_data_keymap[persist_command]
		var/datum/bindcomm_data/bcumm_d_ref = bindcomm_data_cache[persist_command]

		if(persist_keybind == UNBOUND) // unbound, run unbinding and then skip.
			bcumm_d_ref.on_unbind(src)
			continue

		if(movement_commands[persist_command]) // This is a movement command, we go on a different list than the other keybinds
			
			movement_keymap["[persist_keybind]"] = persist_command
			
			bcumm_d_ref.on_bind(src)
			continue

		//Nothing stopped us, now we just put it on the regular keymap
		input_keymap[persist_keybind] = persist_command
		bcumm_d_ref.on_bind(src)
		





