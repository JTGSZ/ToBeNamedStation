/*
	Basically you got a choice of slamming in 1 billion params
	sending a list over
	Or just making this cunt and transferring a ref with all of the relevant data
	Lets try this first
	I wouldn't use this for mechanical messages (Just output those directly), this is just meant for ic/ooc communication
	Also none of this is final, a lot will prob be removed/added really
*/

/datum/message_data
	var/atom/sender = null //A ref to our sender
	var/message = "No Message" //The message we are storing here.
	var/message_color = FALSE // Do we need to set the message color?
	var/font = FALSE // Do we need to set a font?

	//IC Vars
	var/language = FALSE // PLACEHOLDER FOR NOW, IF I PUT IN DEFINES HOW WILL WE HAVE MODULAR CONTENT FOR IT
	var/needs_vision = FALSE // Are we supposed to see this message with our eyes?
	var/needs_hearing = FALSE // Are we going to hear this message?
	var/sending_range = FALSE // Whats the range we are looking for?

//Idk you probably only really need these three anyways.
/datum/message_data/New(given_sender, given_message, given_sending_range)
	..()
	if(given_sender)
		sender = given_sender
	if(given_message)
		message = given_message
	if(given_sending_range)
		sending_range = given_sending_range

/datum/message_data/Destroy()
	sender = null
	..()
	