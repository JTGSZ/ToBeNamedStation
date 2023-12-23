/datum/bindcomm_data/map_input_focus_swap
	pretty_name = "Activate Input Box"
	command_name = "map_input_focus_swap"
	default_keybind = "TAB"

/datum/bindcomm_data/map_input_focus_swap/on_bind(client/target_user)

	
/datum/bindcomm_data/map_input_focus_swap/on_unbind(client/target_user)

/datum/bindcomm_data/map_input_focus_swap/on_press(client/target_user)
	return

/datum/bindcomm_data/map_input_focus_swap/on_release(client/target_user)
	winset(target_user, null, "command=\".winset \\\"!map_pane.map_pane_map.focus=true?text_output_pane.native_text_input.focus=true:map_pane.map_pane_map.focus=true\\\"")
	return

	
	