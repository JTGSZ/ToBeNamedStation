/*
	We write admin panel ere
*/
/client/proc/admin_rights_panel()
	set name = "Admin Management"
	set category = "SuperAdmin"
	set desc = "Manage staff and rights here"

	if(admin_data)
		if(check_admin_rights(ADMIN_RIGHTS_SUPER))
			var/datum/ui/admin_rights/ass = new()
			ass.requestor = src
			ass.display_admin_rights_UI()

/datum/ui/admin_rights


/datum/ui/admin_rights/proc/display_admin_rights_UI()
	var dat = {"
	<table class='one_hundred_percent'>
		<tr>
			<td>Admin Management</td> 
			<td class='far_right_td'><a class='toggled_on' href='?src=\ref[src];add_new_ckey=1'>Add New Admin (CKEY Input)</a></td>
		</tr>
	</table>
	"}
	dat += "<div> Green - They have the right, Red - They do not have the right</div>"
	//dat += "<table>"
	var/list/all_admin_rights = ADMIN_RIGHTS_ALL_RIGHTS
	for(var/current_ckey in GLOB.admin_datums)
		var/datum/admin_data/cur_admin_data = GLOB.admin_datums[current_ckey]
		//dat += "<tr>"
		dat += "<div class='one_segment'>"

		dat += "<table class='one_hundred_percent'><tr>"
		dat += "<td class='segment_percent_td'><span class='label_segment'>ckey: </span>[cur_admin_data.ckey_of_owner]</td>"
		dat += "<td class='segment_percent_td'><span class='label_segment'>title: </span><a class='standard' href='?src=\ref[src];target_ckey=[cur_admin_data.ckey_of_owner];change_cosmetic_rank=1'>[cur_admin_data.cosmetic_rank]</a></td>"
		dat += "<td class='far_right_td'><a class='toggled_off' href='?src=\ref[src];target_ckey=[cur_admin_data.ckey_of_owner];delete_admin_data=1'>DELETE</a></td>"
		dat += "</tr></table>"

		dat += "<div>"
		for(var/rights_str in all_admin_rights)
			if(rights_str in cur_admin_data.admin_rights)
				dat += "<a class='toggled_on' href='?src=\ref[src];target_ckey=[cur_admin_data.ckey_of_owner];toggle_off_right=[rights_str]'>[rights_str]</a>"
			else
				dat += "<a class='toggled_off' href='?src=\ref[src];target_ckey=[cur_admin_data.ckey_of_owner];toggle_on_right=[rights_str]'>[rights_str]</a>"
		dat += "</div>"

		dat += "</div>"


	our_window = new(requestor, "Admin_Management", "Admin Management", 500, 500, src)
	our_window.html_content = dat
	our_window.quickset_stylesheet(STYLESHEET_ADMIN_RIGHTS_MENU)
	our_window.fire_browser()

/datum/ui/admin_rights/Topic(href, href_list)
	. = ..()

	var/client/user = usr.client

	if(!check_admin_rights(ADMIN_RIGHTS_SUPER))
		return

	var/datum/admin_data/target_data

	if(href_list["add_new_ckey"])
		var/new_ckey = input(user,"Type in the CKEY you would like to make data for", "Add Admin") as null|text
		if(new_ckey)
			target_data = new("Admin", ADMIN_RIGHTS_ADMIN, new_ckey) // We make the datum
			GLOB.admin_datums[new_ckey] = target_data

			// If they are currently ingame also link them to their new admin data
			for(var/client/C in GLOB.clients) 
				if(C.ckey == new_ckey)
					target_data.link_to_client(C)

		display_admin_rights_UI(user)

	if(href_list["target_ckey"])
		target_data = GLOB.admin_datums[href_list["target_ckey"]]
		
		if(target_data)
			if(href_list["change_cosmetic_rank"])
				var/new_cosmetic_rank = input(user, "Type in the new COSMETIC RANK you'd like to give this person") as null|text
				if(new_cosmetic_rank)
					target_data.cosmetic_rank = new_cosmetic_rank
			if(href_list["delete_admin_data"])
				target_data.unlink_from_client()
				fdel("[CONFIG_PERSIST_ADMINROSTER_FOLDER][href_list["target_ckey"]].json")
				GLOB.admin_datums.Remove(href_list["target_ckey"])
				qdel(target_data)
			if(href_list["toggle_off_right"])
				target_data.admin_rights -= href_list["toggle_off_right"]
			if(href_list["toggle_on_right"])
				if(!(href_list["toggle_on_right"] in target_data.admin_rights)) // I don't want there to somehow accidentally be multiples of the same right saved onto a list ok
					target_data.admin_rights += href_list["toggle_on_right"]

		if(target_data && !href_list["delete_admin_data"])
			Persistence_Controller.admin_datum_to_json(target_data)

		display_admin_rights_UI(user)
