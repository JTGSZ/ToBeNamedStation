/*
	You may ask yourself, WHY?
	Its because we may need to handle binding/unbinding/press/release/held all differently in seperate amounts.
	Even in the case of like verbs/procs, having to handle params being sent in otherwise retard shit happens sucks.
*/

/datum/bindcomm_data
	var/pretty_name = UNBOUND // The pretty name we have for UIs and dumb shit
	var/command_name = UNBOUND // The default command that comes with this
	var/default_keybind = UNBOUND // The default key that comes with this



/*
	BRO: These are all for when theres a active client/clients inputmap if you are curious if its gonna fire on the persist_inputmap shit
	Ran when we have just binded something to the client inputmap
*/
/datum/bindcomm_data/proc/on_bind(client/target_user)
	return

/*
	Ran when we unbind something from the client inputmap
*/
/datum/bindcomm_data/proc/on_unbind(client/target_user)
	return

/*
	Ran when we press the key on the client inputmap that will be linked to this
*/
/datum/bindcomm_data/proc/on_press(client/target_user)
	winset(target_user, null, "command=\".[command_name] 1\"") //Also note we are sending over a 1 on press, and a 0 on release to the command.
	return

/*
	Ran when we release the key on the client inputmap that will be linked to this
*/
/datum/bindcomm_data/proc/on_release(client/target_user)
	winset(target_user, null, "command=\".[command_name] 0\"")
	return
