/*
	Maybe in the future, this can be rolled into the browser datum system. That actually could benefit from targetted controls.
	Either that or the file handling can be extended elsewhere.
*/

/datum/browser_chat
	//The client whomst owns this bitch, you may wonder why not universal. Each chat setup could be DIFFERENT. You know? (If any of us decide to work on it)
	var/client/linked_client
	//This should be a global, if we never put any instance of custom file loading per client into the chat instance


/datum/browser_chat/New(target_client)
	linked_client = target_client
	..()

/datum/browser_chat/proc/Load_Browser_Chat()
	//The owner took off really fast, lets get out of here.
	if(!linked_client) 
		return FALSE

	//We reveal our shitty browser datum, and enable its activity right here.
	winset(linked_client, "browser_text_output", "is-disabled=false")
	winset(linked_client, "browser_text_output", "is-visible=true")

	//Reminder if we are running into failures to load the script/assets, we just fuckin slam this cunt into a loop
	linked_client << browse_rsc('zHTML/browser_chat/browser_chat.js', "browser_chat.js")
	linked_client << browse_rsc('zHTML/browser_chat/dumb_test_image.png', "dumb_test_image.png")

	linked_client << browse(file("zHTML/browser_chat/browser_chat.html"), "window=browser_text_output")

//We are more than capable of handling our own topic calls... sometimes-thank u very much
/datum/browser_chat/Topic(href, href_list)
	. = ..()
	
//Initial testing of sending data and displaying it on the browser page
/client/proc/test_message(test_message)
	var/testing = 0

	switch(testing)
		if(0)
			// The syntax be gay, but its basically controlname:function in that string
			//The first thing is basically solvin the space issue, and it auto cram in things as like a list2params too if that ever fucks w u
			src << output(url_encode(test_message), "browser_text_output:test_appends") 
		if(1)
			//In the offchance the browser datum ain't used, we have a regular native text output right underneath it.
			src << output(test_message, "native_text_output")

	