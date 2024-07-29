GLOB_VAR(datum/error_viewer/error_viewer) = new()

/client/proc/View_Runtimes()
	set name = "View Runtimes"
	set desc = "Open the Runtime Viewer"
	set category = "Debug"

	GLOB.error_viewer.display_menu(src)


/*
	This basically helps us hold runtimes and also display them in a chincy ass browser popup
*/
/datum/error_viewer
	var/list/error_data = list()

/datum/error_viewer/proc/display_menu(client/requestor)
	var/html = ""
	for(var/error_id in error_data)
		var/datum/error_data/cur_error = error_data[error_id]
		html += "<div><a href='?src=\ref[src];error_click=\ref[cur_error]'>[cur_error.name]</a></div>"



	var/datum/browser/our_window = new(requestor, "error_handler", "Error Viewer", 720, 450, src)
	our_window.html_content = html
	our_window.quickset_stylesheet(STYLESHEET_SS13_COMMON)
	our_window.fire_browser()

/datum/error_viewer/Topic(href, href_list)
	. = ..()
	if(href_list["error_click"])
		var/datum/error_data/cur_error = locate(href_list["error_click"])
		cur_error.display_menu(usr)
