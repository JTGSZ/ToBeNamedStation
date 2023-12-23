/*
	Maybe in the future, this can be rolled into the browser datum system. That actually could benefit from targetted controls.
	Either that or the file handling can be extended elsewhere.
*/

/datum/browser_chat
	//The client whomst owns this bitch, you may wonder why not universal. Each chat setup could be DIFFERENT. You know? (If any of us decide to work on it)
	var/client/linked_client
	//var/browser_chat_html_path = 'zHTML/browser_chat/browser_chat.html' //this caches it into the rsc

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
	//To note this just uses the filename if you don't specify shit at the end.
	linked_client << browse_rsc('zHTML/browser_chat/browser_chat.js')
	linked_client << browse_rsc('zHTML/browser_chat/dumb_test_image.png')

	linked_client << browse('zHTML/browser_chat/browser_chat.html', "window=browser_text_output")


//We are more than capable of handling our own topic calls... sometimes-thank u very much
/datum/browser_chat/Topic(href, href_list)
	. = ..()



	