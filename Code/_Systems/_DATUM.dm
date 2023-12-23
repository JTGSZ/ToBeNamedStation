/*
	Datum Parent
		These gonna be used for too many abstract purposes for me to really keep a track on in one folder
		This basically the parent of everything other than like client world and apparently list
		So you pretty gucci to stick overreaching procs here
*/

/datum

/*
	Also we don't have queue deletion yet mayb soon
	Our Qdel pre-step, clean up ur references to other things here.
*/
/*
/datum/proc/Destroy()
	return TRUE

/*
	Temp holder for when i finally put it in
*/
/proc/qdel(datum/del_target)
	if(!del_target.Destroy())
		world << "del_target didn't supercall in Destroy()"
		del del_target
	else
		world << "del_target destroy chain complete."
*/
/datum/proc/Process()

