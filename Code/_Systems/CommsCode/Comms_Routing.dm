// A cooldown on when we can next update all the listener positions
var/next_listener_loc_update = 0


/*
	Updates the listener positions
*/
/proc/update_listener_locations()
	if(world.time >= next_listener_loc_update) 
		for(var/mob/comms_listener/CL in GLOB.comms_listeners)
			CL.loc = get_turf(CL.attached_to)
		next_listener_loc_update = world.time + 2

/*
	Delivers message data to all comms listeners visible from the turf we are at
*/
/proc/route_message_hearers(datum/message_data/msg_data)
	update_listener_locations()
	//Now we perform the local check for shit, aka what we can see
	for(var/mob/comms_listener/CL in hearers(msg_data.sending_range, get_turf(msg_data.sender)))
		CL.receive_message(msg_data)

/*
	Delivers message data to all comms listeners within a certain distance from the turf we are at
*/
/proc/route_message_distance(datum/message_data/msg_data)
	update_listener_locations()
	for(var/mob/comms_listener/CL in GLOB.comms_listeners)
		if(msg_data.sending_range >= get_dist(msg_data.sender, CL) && CL.z == msg_data.sender.z)
			CL.receive_message(msg_data)


/*
	Delivers message data to all clients in the world
*/
/proc/route_message_all_clients(datum/message_data/msg_data)
	for(var/client/C in GLOB.clients)
		C.receive_message(msg_data)
