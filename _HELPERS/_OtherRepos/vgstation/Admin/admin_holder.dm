
/*
	Assc list of loaded admin datums
	admin_datums["ckey"] = datum
	see: admin_holder.dm
*/

var/global/list/admin_datums = list()

/datum/admins
	var/owner_ckey 		= "ERROR" //Their ckey
	var/rank			= "Gay" // This is just a cosmetic rank
	var/client/owner	= null // The client that actually owns this.
	var/rights 			= 0 //Admin rights are bitflags, See: admin_rights.dm
/*
	In new we just setup the relevant information into the admin datum
	We have to associate it to a live client
	You may ask why? Its because we load ALL the datums in on world init
*/
/datum/admins/New(initial_rank = "Gay", initial_rights = 0, ckey)
	if(!ckey)
		world_msg("Admin datum created without a ckey argument. Datum has been deleted. Fuck you")
		qdel(src)
		return
	owner_ckey = ckey
	rank = initial_rank
	rights = initial_rights
	

/* 
	We associate the admin datum with a client
	Provide it with the proper info
*/
/datum/admins/proc/associate(client/C)
	if(istype(C))
		owner = C
		owner.holder = src
		owner.add_admin_verbs()
/*
	We unassociate the admin datum from a client
	Make sure to cleanup etc but we do not delete these normally
*/
/datum/admins/proc/disassociate()
	if(owner)
		owner.remove_admin_verbs()
		owner.holder = null
		owner = null

/*
	Basically you can run admin shit related to hrefs thru the holder which is this,
	Its a form of protection, but at the same time you could just check rights in the topic of whatev too.
	I opted to just dump everything in their relevant files so this doesn't become gargantuan/we can save on whatever hsrc does but its still functional
*/
/datum/admins/Topic(href, href_list)
	..()
	if(usr.client != src.owner || !check_rights(0))
		return

/*
	Rights are bitflags
	you prob don't want to hand certain debug verbs to someone who don't got any reason to use them 
	EX: DB testing without access to the box etc, can also keep their ui sleek when they do have all the admin verbs displayed
*/
/proc/check_rights(rights_required, show_msg=1)
	if(usr && usr.client)
		if(rights_required)
			if(usr.client.holder)
				if(rights_required & usr.client.holder.rights)
					return TRUE
				else
					if(show_msg)
						usr << "Error: You do not have sufficient rights to do that."
		else
			if(usr.client.holder)
				return TRUE
			else
				if(show_msg)
					usr << "Error: You are not an admin."
	return FALSE

/mob/proc/check_rights(rights_required)
	if(src && src.client)
		if(rights_required)
			if(src.client.holder)
				if(rights_required & src.client.holder.rights)
					return TRUE
				else
					usr << "Error: You do not have sufficient rights to do that."
		else
			if(src.client.holder)
				return TRUE
			else
				usr << "Error: You are not an admin."
	return FALSE

