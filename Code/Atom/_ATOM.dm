/*
	Atom Parent
	Theres an icon and no state on it yeah.
	If shit appears in the world thats invisible, then by default the no name icon in that file will be set onto it which is a error message
*/
/atom
	name = "ERROR"
	desc = "If you see this then I fucked up"
	icon = 'zAssets/Filler_Icons.dmi' 
	
	var/give_comms_listener = FALSE //can we take comms output? Most things 
	var/mob/comms_listener/attached_comms_listener //slot for a listening object, a comms listening object.

/atom/New()
	if(give_comms_listener)
		attached_comms_listener = new(src)
	. = ..()

/atom/Destroy()
	..()
	if(attached_comms_listener)
		qdel(attached_comms_listener) //That'll actually handle all the refs (I hope)

	invisibility = 101 //WE are trying to delete it, why let people even attempt to see or fucks with it
	

/*
	In an effort to keep things dynamic Ill just make all the normal flag checks here
	To note everything that can listen and that a message reaches will receive it
	But they might not do anything with it.
*/
/atom/proc/receive_message(message_data)
	return FALSE

//We clicked the thing, we can tell the user it happened and they clicked on something too
/atom/Click(location, control, params)
	usr.clicked_an_atom(src, params)
	