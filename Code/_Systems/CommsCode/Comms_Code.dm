
var/next_listener_loc_update = 0

//We find the listeners based on how the msg_data is setup and just deliver it to them.
/proc/route_message_local(datum/message_data/msg_data)
	//Time to update the positions of everything (if theres a ton of stationary shit, time for a split to another list based on non-moving)
	if(world.time >= next_listener_loc_update) //Time to update all the listener positions everywhere.
		for(var/mob/comms_listener/CL in comms_listeners)
			CL.loc = get_turf(CL.attached_to)
		next_listener_loc_update = world.time + 2

	//Now we perform the local check for shit
	for(var/mob/comms_listener/CL in hearers(world.view, get_turf(msg_data.sender))) 
		CL.attached_to.receive_message(msg_data)


//this is for ooc for now probably, could use it for announcements or some shit idk.
/proc/route_message_all_clients(datum/message_data/msg_data)
	for(var/client/C in clients)
		C.receive_message(msg_data)

//To note, this is just meant to send shit specifically to the clients chat
/proc/to_client_chat(client/C, message)
	if(C.browser_chat_instance) //We founds a chat instance
		C << output(url_encode(message), "browser_text_output:test_appends") // We sends their browser chat a message
	else
		C << message //the native text output is underneath the browser, so if the first isn't avail. We will get there


//This is just haphazardly meant to get the job done.
/proc/ez_output(target, given_input)
	if(!target) //we have no target
		return

	if(istext(given_input)) //For now, lets just deal with text
		if(target == world) //a world message which is normally used for people debugging shit anyways
			for(var/client/C in clients)
				if(istext(given_input))
					if(C.browser_chat_instance)
						C << output(url_encode(given_input), "browser_text_output:test_appends")
						continue
				C << given_input
			return // We stop here

		var/client/C
		if(isclient(target))
			C = target
		else if(ismob(target))
			var/mob/cur_mob = target
			if(cur_mob.client)
				C = cur_mob.client
		if(C)
			if(C.browser_chat_instance)
				C << output(url_encode(given_input), "browser_text_output:test_appends") 
			else
				C << given_input
