/*
	Mob topic, kinda shitcode fr but I guess it can be moved later
*/
/mob/Topic(href, href_list)
	. = ..()
	if(href_list["TelepathyREPLY"])
		var/client/target_client = usr
		var/reply_message = input(target_client, "What would you like to reply with?") as message

		if(reply_message)
			reply_message = span_purple(reply_message)
			var/datum/message_data/msg_data = new(target_client, reply_message)
			receive_message(msg_data)