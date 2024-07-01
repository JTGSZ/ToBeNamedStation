/*
	Idk this thing basically is just a datum to hold globals neawys
*/
var/datum/controller/global_holder/GLOB

/datum/controller/global_holder


/datum/controller/global_holder/proc/stat_entry()
	if(!statclick)
		statclick = new /obj/statclick/debug("Initializing...", src)


	stat("Globals:", statclick.update("Total Variables: [vars.len]"))