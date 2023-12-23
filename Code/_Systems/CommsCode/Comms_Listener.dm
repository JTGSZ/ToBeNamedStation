/*
	Basically this object just updates periodically (Not constantly) to stay over where the thing that wants to hear shit is.
	As to why? Imagine we are in the contents of something in the contents of something etc. 
*/
var/global/list/comms_listeners = list()

/mob/comms_listener
	name = "comms listener"
	icon = 'zAssets/Filler_Icons.dmi' 
	icon_state = "green_check"
	var/atom/attached_to //The thing we are attached to, whether it be bitch or a tree. All shall be dealt with.
	density = 0
	invisibility = INVISIBILITY_MAXIMUM

//We are only on mob for one purpose really, and its the native hearers() check, so no supercall
/mob/comms_listener/New(target_thing)
	attached_to = target_thing
	comms_listeners += src
	loc = get_turf(attached_to)
	..()

//cleanup time, if we are at the point of needing to be deleted.
/mob/comms_listener/Destroy()
	attached_to.comms_listener = null
	attached_to = null
	comms_listeners -= src
	..()
	