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

#define world_msg(msg) ez_output(world, msg)





#define admin_msg(msg) for(var/cur_ckey in GLOB.admin_datums){var/datum/admins/cur_holder = GLOB.admin_datums[cur_ckey]; if(cur_holder.owner){ez_output(cur_holder.owner, msg)}}


