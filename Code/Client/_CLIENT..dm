/* 
	Parent of client shit.... although client can't handle children neways afaik.
	So this is just a place for the shit we define on it so far
*/
/client
	//You could potentially have a admin datum INSIDE OF YOU(r client)
	var/datum/admins/holder = null

/*
	The whole chain is weird
	Basically it firsts calls world/isBanned()
	Then this gets called
	Then mob/login() gets called if theres a key on one it finds

	If null is also returned on this, we jus disconnect the person too
*/
/client/New()
	..()	//calls mob.Login()

	if(connection != "seeker")	//Invalid connection type.
		if(connection == "web") //The webclient hasn't been updated in forever anyways.
			if(!holder)
				return null
		else
			return null

	if(byond_version < CONFIG_SERVER_MIN_BYOND_VERSION)	//Out of date client.
		alert(src,"Your BYOND client is out of date. Please make sure you have have at least version [world.byond_version] installed. Check for a beta update if necessary.", "Update Yo'Self", "OK")
		spawn(5 SECONDS)
			del(src)

	if(!CONFIG_SERVER_GUESTS_ENABLED && IsGuestKey(key)) // Whether you want guests to be able to join or not
		alert(src,"This server doesn't allow guest accounts to play. Please go to http://www.byond.com/ and register for a key.","Guest","OK")
		del(src)
		return

	// If you have another place for people to download the rsc
	preload_rsc = CONFIG_SERVER_RSC_URL

	// So the user doesn't complain if they see stuff slowly loading in as they download the rsc
	src_msg("If the title screen is black, resources are still downloading. Please be patient until the title screen appears.")

	//Admin Authorisation
	var/static/list/localhost_addresses = list("127.0.0.1","::1")
	if(CONFIG_SERVER_LOCALHOST)
		if((!address && !world.port) || (address in localhost_addresses))
			var/datum/admins/new_holder = new("Host", R_HOST, src.ckey)
			new_holder.associate(src)
			src_msg("HELLO LOCALHOST [holder]")

	if(admin_datums[src.ckey])
		var/datum/admins/holder = admin_datums[src.ckey]
		holder.associate(src)

	

/*
	Same deal here, we are apparently calling Logout() on a mob we are leaving
*/
/client/Del()
	if(holder)
		holder.owner = null

	return ..()