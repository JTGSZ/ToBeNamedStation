/*
	Basically these are definition placeholders for anything thats gonna see a big refactor down the road
	You'll be able to just search and get all of it at once.
*/

//#define world_msg(msg) world << "[msg]"
#define src_msg(msg) ez_output(src, "[msg]")
#define usr_msg(msg) ez_output(usr, "[msg]")
#define dd_msg(msg) world.log << "[msg]"
#define TODO(msg) ez_output(world, "TODO: [msg]")

//A dumb macro to just iterate a list and put the contents in a world msg
#define list_debug_msg(target_list) var/index = 0; for(var/i in target_list){index++; ez_output(world, "Index: [index], Value:[i]")};
#define assc_list_debug_msg(target_list) var/index = 0; for(var/i in target_list){index++; ez_output(world, "Index: [index], Key: [i], Value: [target_list[i]]")};

// world message for the world
#define world_msg(msg) ez_output(world, msg)

// This basically will log a custom error into the runtime viewer too
#define ERROR_MSG(msg) world.Error(EXCEPTION("ERROR: [msg]"))

// Just sends a message to all admins
#define admin_msg(msg) for(var/cur_ckey in GLOB.admin_datums){var/datum/admin_data/amsg_target = GLOB.admin_datums[cur_ckey]; if(amsg_target.linked_client){ez_output(amsg_target.linked_client, msg)}}


