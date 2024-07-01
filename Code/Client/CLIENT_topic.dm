


/client/Topic(href, href_list)
	..()
	if(href_list["AdminMSGreply"])
		var/client/target_client = usr
		var/reply_message = input(target_client, "What would you like to reply with?") as message

		if(reply_message)
			reply_message = "[target_client.key]: [reply_message] (<a href='byond://?src=\ref[target_client];AdminMSGreply=1'>Reply</a>)"
			var/datum/message_data/msg_data = new(target_client, reply_message)
			msg_data.message_color = "#940080"
			receive_message(msg_data)


