/*
	This basically just holds data related to one instance of an error
*/
/datum/error_data
	var/name = "ERROR"
	var/error_last_seen = 0
	var/list/error_desc_log = list()
	
/datum/error_data/proc/display_menu(client/requestor)
	var/html = ""

	for(var/cur_timestamp in error_desc_log)
		html += "<div><a href='?src=\ref[src];timestamp_key=[cur_timestamp]'>[name]</a></div>"




	var/datum/browser/our_window = new(requestor, "[name]", "[name]", 600, 450, src)
	our_window.html_content = html
	our_window.quickset_stylesheet(STYLESHEET_SS13_COMMON)
	our_window.fire_browser()

/*
	In case you want to click yet again
*/
/datum/error_data/proc/display_detail_menu(client/requestor, timestamp_key)
	var/html = ""
	var/exception_desc = error_desc_log[timestamp_key]
	var/list/split_desc = splittext(exception_desc, "\n")
	for(var/lines in split_desc)
		html += "[lines]<br>"
	//html += "[error_desc_log[timestamp_key]]"


	var/datum/browser/our_window = new(requestor, "[timestamp_key][name]", "[timestamp_key]:[name]", 600, 450, src)
	our_window.html_content = html
	our_window.quickset_stylesheet(STYLESHEET_SS13_COMMON)
	our_window.fire_browser()

/datum/error_data/Topic(href, href_list)
	. = ..()
	if(href_list["timestamp_key"])
		display_detail_menu(usr, href_list["timestamp_key"])