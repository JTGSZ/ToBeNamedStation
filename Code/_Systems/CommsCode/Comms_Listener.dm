/*
	This object basically is on everything that wants to deal in communications
	It updates positions sometimes if the comms global procedures are being used.

	As to what handles what, the comms global procedures dictate whether these guys are even getting a message or not
	And these guys also try to determine whether we can even do anything with the message data received.
*/
GLOB_LIST(comms_listeners) = list()
 
/mob/comms_listener
	name = "comms listener"
	icon = 'zAssets/Filler_Icons.dmi' 
	icon_state = "green_check"
	var/atom/attached_to //The thing we are attached to, whether it be bitch or a tree. All shall be dealt with.
	density = 0
	invisibility = INVISIBILITY_MAXIMUM

	// These are basically just flags to help decide what to do with the shit we are receiving
	var/list/comms_flags = list(COMMS_FLAG_NORMAL)

//We are only on mob for one purpose really, and its the native hearers() check, so no supercall
/mob/comms_listener/New(target_thing)
	attached_to = target_thing
	GLOB.comms_listeners += src
	loc = get_turf(attached_to)
	..()

//cleanup time, if we are at the point of needing to be deleted.
/mob/comms_listener/Destroy()
	attached_to.attached_comms_listener = null
	attached_to = null
	GLOB.comms_listeners -= src
	..()

/*
*/
/mob/comms_listener/receive_message(datum/message_data/msg_data)
	if(msg_data.sender == attached_to) // ofc we can see our own damn messages
		attached_to.receive_message(msg_data)
		return TRUE
	if(msg_data.comms_flags)
		for(var/comms_flag in msg_data.comms_flags)
			if(comms_flag in src.comms_flags)
				attached_to.receive_message(msg_data)