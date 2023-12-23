/*
	Basically a hastily shit together window so the host can add and remove admins ingame if they don't want to just manually make json files
*/

var/datum/Admin_Add_and_Remove/Admin_Add_and_Remove

/datum/Admin_Add_and_Remove

/*
	We write admin panel ere
*/
/client/proc/permissions_panel()
	set name = "Permissions Panel"
	set category = "Admin"
	set desc = "Giving and taking away permissions"

	if(holder)
		Admin_Add_and_Remove.display_menu(src)

//Basically the shitty replacement to the verb instance
/client/proc/admin_add(mob/p in world)
	set name = "Admin Add"
	set category = "Admin"
	set desc = "Giving admins"

	if(holder)
		Admin_Add_and_Remove.admin_add(p)

/datum/Admin_Add_and_Remove/proc/admin_add(mob/M)
	var/rank = input(usr, "What is their Rank?") as text
	var/datum/admins/new_holder = new(rank, R_ADMIN, M.ckey)
	M.client.holder = new_holder
	new_holder.associate(M.client)
	Persistence_Controller.admin_datum_to_json(new_holder)

/* Be careful unless you enjoy iterating a few tens of thousands of times */
/datum/Admin_Add_and_Remove/proc/display_menu(user)
	var dat = "Admin Permissions List"
	dat += {"
		<div
	"}
	for(var/ass_key in admin_datums)
		var/actualKey = ass_key
		if(findtext(ass_key, ".json"))
			actualKey = splicetext(ass_key, length(ass_key)-4, 0, "")
		var/datum/admins/fuck = admin_datums[ass_key]
		dat += {"
				 <div style="width:100%; background-color:#1f1c1c; border-style:solid; border-color: #999797">
					<b>Ckey:</b> [actualKey]<br>
					<b>Rank:</b> <a href="?src=\ref[src];change_rank=1;ass_key=[ass_key]">[fuck.rank]</a><br>
				"}
		
		dat += {"
				<div style="width:100%; background-color:#470b0b; border-style:solid; border-color: #eb0725">
				 <b>Remove Permission:</b>
				"}

		for(var/i=1, i <= R_MAX_PERMISSIONS, i <<= 1)
			if(fuck.rights & i)
				dat += "<a href=?src=\ref[src];remove_perm=1;bitflag_to_remove=[i];ass_key=[ass_key]>[rights2text(i)]</a>"
			else
				continue

		dat += "</div>"
		
		dat += {"
				<a href=?src=\ref[src];add_perm=1;ass_key=[ass_key]>Add Permission</a>
 				<a href=?src=\ref[src];remove_user=1;ass_key=[ass_key]>Delete Entry</a>
				"}

		dat += "</div>"

	var/datum/browser/popup = new(user, "Permissions Menu", "<div align='center'>Permissions Menu</div>", 500, 500)
	popup.html_content = dat
	popup.quickset_stylesheet(STYLESHEET_SS13_COMMON)
	popup.fire_browser()

/datum/Admin_Add_and_Remove/Topic(href, href_list)
	. = ..()
	var/mob/user = usr

	var/target_key = href_list["ass_key"] //Assc key passed in, don't forget to put safety checks around here tho
	var/datum/admins/target_datum = admin_datums[target_key]

	if(href_list["change_rank"])
		var/change_rank_name = input(usr, "What would you like to change their rank to?", "Permissions Rank Name", null) as text|null
		if(change_rank_name)
			target_datum.rank = change_rank_name

	if(href_list["remove_perm"])
		var/the_flag = text2num(href_list["bitflag_to_remove"])
		target_datum.rights ^= the_flag
		var/client/owner = target_datum.owner //Refresh them if they ingame lol
		target_datum.disassociate()
		target_datum.associate(owner)
	
	if(href_list["add_perm"])
		var/list/permissionlist = list()

		for(var/i=1, i<=R_MAX_PERMISSIONS, i<<=1)		//that <<= is shorthand for i = i << 1. Which is a left bitshift
			permissionlist[rights2text(i)] = i

		var/new_permission = input("Select a permission to turn on/off", "Permission toggle", null, null) as null|anything in permissionlist
		if(!new_permission)
			return
		target_datum.rights ^= permissionlist[new_permission]
		
		var/client/owner = target_datum.owner //Refresh them if they ingame lol
		target_datum.disassociate()
		target_datum.associate(owner)

	if(href_list["remove_user"])
		switch(alert("Are you sure you'd like to remove [target_key] from the permissions?",, "YES","NO"))
			if("YES")
				target_datum.disassociate()
				admin_datums.Remove(target_key)
				qdel(target_datum)
				usr_msg("Removed [target_key] from permissions.")


	Persistence_Controller.admin_datum_to_json(target_datum)
	display_menu(user)