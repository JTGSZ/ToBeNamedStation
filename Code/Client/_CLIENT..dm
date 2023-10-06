/* 
	Parent of client shit.... although client can't handle children neways afaik.
	So this is just a place for the shit we define on it so far
*/
/client


/*
	The whole chain is weird
	Basically it firsts calls world/isBanned()
	Then this gets called
	Then mob/login() gets called if theres a key on one it finds

	If null is also returned on this, we jus disconnect the person too
*/
/client/New()
	. = ..()	//calls mob.Login()

/*
	Same deal here, we are apparently calling Logout() on a mob we are leaving
*/
/client/Del()
	return ..()