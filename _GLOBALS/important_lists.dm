/*
	A place to put global lists that are kinda important
*/

/*
	A assc list of all player_spirit currently in the game
	Which is where we store needed runtime data tied to the player themselves.
	See: player_spirit.dm
	CONTENTS:
		"KEY" - /datum/player_spirit
*/
var/global/list/list_of_player_spirits = list()


/*
	Map_Marker_lists - I imagine jus seperating all of these into their own lists would be more coder friendly
	But instead Ill jus handle it in the most lazy manner I can and automate it on their New()
	CONTENTS:
		"marker_name" = list(its full of /atom/mapmarkers that share the same name)

*/
var/global/list/map_mark_list = list()

/*
	Assc list of loaded admin datums
	admin_datums["ckey"] = datum
	see: admin_holder.dm
*/
var/list/admin_datums = list()