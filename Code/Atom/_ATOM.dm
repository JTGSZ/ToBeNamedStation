/*
	Atom Parent
	Theres an icon and no state on it yeah.
	If shit appears in the world thats invisible, then by default the no name icon in that file will be set onto it which is a error message
*/
/atom
	name = "ERROR"
	desc = "If you see this then I fucked up"
	icon = 'zAssets/Filler_Icons.dmi' 
	
	var/needs_comms_listener = FALSE //can we take comms output? Most things 
	var/mob/comms_listener/comms_listener //slot for a listening object, a comms listening object.

/atom/New()
	if(needs_comms_listener)
		comms_listener = new(src)
	. = ..()

/atom/Destroy()
	..()
	if(comms_listener)
		qdel(comms_listener) //That'll actually handle all the refs (I hope)

	invisibility = 101 //WE are trying to delete it, why let people even attempt to see or fucks with it
	

//You don't HAVE to use this you know?
//All it does is make a datum which holds a bunch of data and gives it to route message to be delivered
/atom/proc/send_message(message)
	message = "[name]: [message]"
	var/datum/message_data/msg_data = new(src, message, world.view)
	route_message_local(msg_data)

//Theres no uniform way we handle receiving a message down here.
/atom/proc/receive_message(message_data)
	return

//We clicked the thing, we can tell the user it happened and they clicked on something too
/atom/Click(location, control, params)
	usr.clicked_an_atom(src, params)
	