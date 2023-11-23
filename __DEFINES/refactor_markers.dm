/*
	Basically these are definition placeholders for anything thats gonna see a big refactor down the road
	You'll be able to just search and get all of it at once.
*/

#define world_msg(msg) world << "[msg]"
#define src_msg(msg) src << "[msg]"
#define usr_msg(msg) usr << "[msg]"
#define dd_msg(msg) world.log << "[msg]"
#define admin_msg(msg) world << "[msg]"
#define TODO(msg) world << "TODO: [msg]"

//A dumb macro to just iterate a list and put the contents in a world msg
#define list_debug(target_list) for(var/i in target_list) world << "[i]"