/*
	Basically a holder for admin shit
	Not a particularly revolutionary idea
*/

/datum/admin_holder
	//target_ckey - Ckey that owns our datum
	var/target_ckey = null 
	//admin_rank - Rank we are to decide what we have access to
	var/admin_rank = ADMINRANK_ADMIN

/datum/admin_holder/New()
	..()
