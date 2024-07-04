/mob/verb/make_runtime()
	set category = "DEV-Debug"

	var/list/cock = list("a", "b")
	world_msg("[cock[5]]")

/*
	This gets exceptions sent to it if a error occurs
	An important thing to note is you only get the file and line in the world error exception if debugging information is enabled on the dme file
	#define DEBUG
	
*/
/world/Error(exception/EX)

	// a convenient way to get a key
	var/datum/error_data/cur_data = GLOB.error_viewer.error_data["[EX.file][EX.line]"]
	if(cur_data) // Eh... same error we've seen before
		cur_data.error_last_seen = world.time
		cur_data.error_desc_log[WORLD_TIMESTAMP] = "[EX.desc]"

		return

	// A BRAND NEW NEVER BEFORE SEEN ERROR!
	cur_data = new()
	var/cur_timestamp = WORLD_TIMESTAMP // Make sure we don't move forward during instructions and desync
	cur_data.name = "\[[cur_timestamp]\]: [EX.name] FILE: [EX.file]:[EX.line]"
	cur_data.error_desc_log[cur_timestamp] = "[EX.desc]"
	GLOB.error_viewer.error_data["[EX.file][EX.line]"] = cur_data
	admin_msg({"<b>NEW RUNTIME: [EX.name] <br> File:[EX.file] Line:[EX.line] <a href='?src=\ref[cur_data];timestamp_key=[cur_timestamp]'>(VIEW)</a></b>"})
	
	







