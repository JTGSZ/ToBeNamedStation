//The proc can be generalized on a mob
/mob/verb/say_verb(message as text)
	set name = "say"
	set category = "IC"

	message = span_IC_color("[name] : [message]")
	var/datum/message_data/msg_data = new(src, message, world.view)
	route_message_hearers(msg_data)

//But as for a ooc message, we can just handle everything right here.
/client/verb/ooc_verb(message as text)
	set name = "OOC"
	set category = "OOC"

	var/datum/message_data/msg_data = new(src, world.view)
	msg_data.message = span_OOC_color("[key]: [message]")
	route_message_all_clients(msg_data)

/*
Default listen is standard screen size 32x32 from yeller(unless bigger/smaller is better)
Always capped because lmao they are yelling
*/
/mob/verb/yell_verb(message as text)
	set name = "yell"
	set category = "IC"

	message = span_IC_color("[name]: yells \"[message]\"")
	var/datum/message_data/msg_data = new(src, message, 32)
	route_message_distance(msg_data)

/* 
	MISSING:
		Assign face states to prefixes
		“$hey im taco” would display “hey im taco” with a face state associated with it
*/
/mob/verb/emote_verb(message as text)
	set name = "emote"
	set category = "IC"

	message = span_EMOTE_color("[message]")
	var/datum/message_data/msg_data = new(src, message, world.view)
	route_message_hearers(msg_data)

/* 
	MISSING:
		Ability to listen to all whispers
*/
/mob/verb/whisper_verb(message as text)
	set name = "whisper"
	set category = "IC"

	message = span_IC_color("[message]")
	var/datum/message_data/msg_data = new(src, message, 2)
	route_message_hearers(msg_data)


/* 
	MISSING:
		Option to include name or not
		Option to make it one way or two ways
		If two ways, provide a way to respond

*/
/mob/var/telepathy_two_way = FALSE
/mob/verb/telepathy_two_way()
	set name = "Toggle Two Way"
	set category = "Telepathy"

	telepathy_two_way = !telepathy_two_way
	ez_output(src.client, "[telepathy_two_way ? "Telepathic Two-way is ON": "Telepathic Two-way is OFF"]")

/mob/verb/telepathy_verb()
	set name = "telepathic communications"
	set category = "Telepathy"

	var/list/client_mobs = list()
	for(var/mob/M in GLOB.mobs_in_world)
		if(!M.client)
			continue
		client_mobs += M

	var/mob/target_mob = input(usr, "Whomst would you like to communicate with?") as null|anything in client_mobs
	var/message = "ERROR"
	if(target_mob)
		var/target_message = input(usr, "What would you like to send telepathically?") as message
		if(target_message)
			message = target_message
		if(telepathy_two_way)
			message = "[target_message] (<a href='byond://?src=\ref[src];TelepathyREPLY=1'>Reply</a>)"

		message = span_purple(message)
		var/datum/message_data/msg_data = new(src, message, world.view)
		target_mob.client.receive_message(msg_data)
	

/*
Radio (Scouter)
Listener is all those with a radio with the same frequency in inventory
Display as normal talk to others nearby
Ability to rename frequency but keep it associated with a number
If left on map and not in map, will as a speaker in standard say range
*/
/obj/item/scouter
	name = "Scouter"
	icon = 'zAssets/Filler_Icons.dmi' 
	icon_state = "red_x"
	var/toggled_on = FALSE

/obj/item/scouter/proc/toggle()
	toggled_on = !toggled_on
	if(toggled_on)
		icon_state = "green_check"
	else
		icon_state = "red_x"



/*
Think
Invisible to all other players but not admins
Add variable to give the ability to see thinks (read mind)
*/
// In order to see the thoughts
/mob/verb/think_verb(message as text)
	set name = "Think"
	set category = "IC"

	message = span_EMOTE_color("[name] thinks \"[message]\"")
	var/datum/message_data/msg_data = new(src, message, world.view)
	msg_data.comms_flags = list(COMMS_FLAG_THOUGHT)
	route_message_distance(msg_data)

/*
Observe
Display all communicators that are able to be communicated through normal means with [Observer] prefix
Allow emotes, says, yells and whispers
*/
// IDK

/*
Countdown
Starts a timer based on a number you input
Prompts whenever time is quarter way through its count rounded down.
*/
/mob/var/next_countdown_cooldown
/mob/verb/countdown_verb()
	set name = "Countdown"
	set category = "OOC"

	var/target_number = input(usr, "What number are you going to countdown from?") as null|num
	if(target_number && target_number <= 100 && world.time >= next_countdown_cooldown) // Max limit of 100 seconds for now?
		begin_verbal_countdown(target_number)
		next_countdown_cooldown = world.time + (target_number SECONDS)

/mob/proc/begin_verbal_countdown(number)
	set waitfor = 0
	for(var/i = number, i >= 0, i--)
		var/datum/message_data/msg_data = new(src, span_EMOTE_color("[i]"), world.view)
		route_message_hearers(msg_data)
		sleep(1 SECONDS)

/*
AdminPM
Direct admin whisper that shows admin key
Can be responded
Not single line please for the love of god
*/

/client/verb/admin_MSG()
	set name = "AdminMSG"
	set category = "Admin"

	var/list/client_mobs = list()
	for(var/mob/M in GLOB.mobs_in_world)
		if(!M.client)
			continue
		client_mobs += M

	var/mob/target_mob = input(usr, "Which client mob would you like to message?") as null|anything in client_mobs
	if(target_mob)
		var/target_message = input(usr, "What would you like to send?") as message
		if(target_message)
			target_message = span_purple("[src.key]: [target_message] (<a href='byond://?src=\ref[src];AdminMSGreply=1'>Reply</a>)")

			var/datum/message_data/msg_data = new(src.mob, target_message)
			target_mob.client.receive_message(msg_data)	
			


/*
Admin Announce
Sends message to all clients
Center the message
Include admin key at top
Blue Text
*/
/client/verb/admin_Announce(message as text)
	set name = "Global Announce"
	set category = "Admin"

	message = span_midblue(message)
	var/datum/message_data/msg_data = new(src, message)
	route_message_all_clients(msg_data)
/*
Admin Narrate
Yellow message to all those 64 tiles away from admin character
Only those in the vicinity can see it
Do not include key
Yellow Text
*/
/client/verb/admin_Narrate(message as text)
	set name = "Local Narrate"
	set category = "Admin"

	message = span_midblue(message)
	var/datum/message_data/msg_data = new(src.mob, message, 64)
	route_message_distance(msg_data)
/*
Admin Z-Message
Similar to Narrate but its the entire map
Red Text
*/
/client/verb/admin_ZLEVEL_Narrate(message as text)
	set name = "Map Narrate"
	set category = "Admin"

	message = span_redtext(message)
	var/datum/message_data/msg_data = new(src.mob, message, INFINITY)
	route_message_distance(msg_data)
/*
Admin Global Message
Message to everyone’s client in similar format to narrate
Green Text
*/
/client/verb/admin_Global_MSG(message as text)
	set name = "Global Narrate"
	set category = "Admin"

	message = span_neongreen(message)
	var/datum/message_data/msg_data = new(src.mob, message, world.view)
	route_message_all_clients(msg_data)

/*
Admin Secret Speech
Similar to AdminPM
Does not include key
Purple Text
*/
/client/verb/admin_secret_speech()
	set name = "Subtle Text"
	set category = "Admin"

	var/list/client_mobs = list()
	for(var/mob/M in GLOB.mobs_in_world)
		if(!M.client)
			continue
		client_mobs += M

	var/mob/target_mob = input(usr, "Which client controlled mob would you like to send a message to?") as null|anything in client_mobs
	var/message = "ERROR"
	if(target_mob)
		var/target_message = input(usr, "What message are you wanting to send?") as message
		if(target_message)
			message = target_message

		message = span_purple(message)
		var/datum/message_data/msg_data = new(src.mob, message, world.view)
		target_mob.client.receive_message(msg_data)


/*
	Idk I accidentally made this one trying to make adminPMs
*/
/client/verb/admin_ticket(message as text)
	set name = "Admin Ticket"
	set category = "OOC"

	GLOB.admin_tickets.new_ticket(src, message)