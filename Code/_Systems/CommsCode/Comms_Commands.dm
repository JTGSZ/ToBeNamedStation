//The proc can be generalized on a mob
/mob/verb/say_verb(message as text)
	set name = "say"
	set category = "IC"

	message = "[name] : [message]"
	var/datum/message_data/msg_data = new(src, message, world.view)
	msg_data.message_color = client.persist_data.IC_text_color
	send_message(msg_data)

//But as for a ooc message, we can just handle everything right here.
/client/verb/ooc_verb(message as text)
	set name = "OOC"
	set category = "OOC"

	send_message(message)