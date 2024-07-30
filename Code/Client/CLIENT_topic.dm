

/*
https://www.byond.com/docs/ref/#/client/proc/Topic
href
	The topic text (everything after the '?' in the full href).
href_list
	List of key/value pairs in href (produced from params2list(href)).
hsrc
	The object referenced by the "src" parameter in href or null if none.
*/
/client/Topic(href, href_list, hsrc)
	..()
	if(href_list["AdminMSGreply"])
		var/client/target_client = usr
		var/reply_message = input(target_client, "What would you like to reply with?") as message

		if(reply_message)
			reply_message = span_purple("[target_client.key]: [reply_message] (<a href='byond://?src=\ref[target_client];AdminMSGreply=1'>Reply</a>)")
			var/datum/message_data/msg_data = new(target_client, reply_message)
			receive_message(msg_data)


