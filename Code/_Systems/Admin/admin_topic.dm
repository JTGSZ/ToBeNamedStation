/*
	Basically you can run admin shit related to hrefs thru the holder which is this,
	Its a form of protection, but at the same time you could just check rights in the topic of whatev too.
	I opted to just dump everything in their relevant files so this doesn't become gargantuan/we can save on whatever hsrc does but its still functional
*/
/datum/admins/Topic(href, href_list)
	..()
	if(usr.client != src.owner || !check_rights(0))
		return

