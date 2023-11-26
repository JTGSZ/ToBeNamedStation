/*
	Our own iteration of shitty browser chat. Basically we just hold serverside data here for the little browser window the client gets in the bottom right.
	With some targeted helpers I suppose.
	But for now, realize we have both a native output, and a browser that can be ontop of it.
	We need to swap between both depending on what has happened, as we don't want to cuck a user whomst can't load it for no good reason.
	When Its finished, i think only then would we see whether its worthwhile even attempting to move it to the browser datum system.
*/

/datum/browser_chat
	//The client whomst owns this bitch, you may wonder why not universal. Each chat setup could be DIFFERENT. You know? (If any of us decide to work on it)
	var/client/owner_client
	var/list/dumb_resources = list(
		
	)

/datum/browser_chat/New(owner_client)
	..()

/datum/browser_chat/proc/load()
	//If we gots no owner client, then our existence is a net negative to the world.
	if(!owner_client) 
		return FALSE




//We are more than capable of handling our own topic calls... sometimes-thank u very much
/datum/browser_chat/Topic(href, href_list)
	. = ..()
	
//Initial testing of sending data and displaying it on the browser page
/client/proc/test_message(test_message)

	src << output(test_message, "browser_text_output:output")

	