/*
	Meant to output specifically to one client
*/
/proc/to_client_chat(client/C, message)
	if(C.browser_chat_instance) //We founds a chat instance
		C << output(url_encode(message), "browser_text_output:test_appends") // We sends their browser chat a message
	else
		C << message //the native text output is underneath the browser, so if the first isn't avail. We will get there


/*
	Meant to just be a catchall easy output to whatever target you give it with whatever input you give it
*/
/proc/ez_output(target, given_input)
	if(!target) //we have no target
		return

	if(istext(given_input)) //For now, lets just deal with text
		if(target == world) //a world message which is normally used for people debugging shit anyways
			for(var/client/C in GLOB.clients)
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