/*
	Yeah yeah, all of this shits gross looking but at least client isn't loaded with a ton of menus sitting on it
	Also special thanks to goonstation for the code
*/
/datum/view_variable_proclist
	var/datum/browser/our_window //Well we need to hold a ref to the browser window due to this setup.
	var/client/requestor
	var/datum/target

/datum/view_variable_proclist/New(requestor_client, target_datum)
	..()
	if(requestor_client)
		requestor = requestor_client
	if(target_datum)
		target = target_datum
	

/datum/view_variable_proclist/proc/show_proc_list() // null for global
	if(!target || !requestor)
		return

	var/list/procs = list_procs(target)
	var/link_target = isnull(target) ? "global" : "\ref[target]"
	var/list/lines = list()
	if(isnull(target))
		lines += "<title>Global procs</title>"
	else
		lines += "<title>Procs of [target] - \ref[target] - [target.type]</title>"
	for(var/type in procs)
		if(type)
			lines += "<b syle='padding-left:20px;'>[type]</b><br>"
		for(var/proc_name in procs[type])
			var/pr = procs[type][proc_name]
			lines += "<a href='byond://?src=\ref[src];CallProc=[link_target];proc_ref=\ref[pr]'>[proc_name]</a><br>"

	lines = jointext(lines, "")

	our_window = new(requestor, "proc_list", null, 600, 450, src)
	our_window.html_content = lines
	our_window.quickset_stylesheet(STYLESHEET_VIEW_VARIABLES)
	our_window.fire()

/datum/view_variable_proclist/Topic(href, href_list)
	. = ..()
	if(href_list["window_closed"])
		qdel(our_window)
		our_window = null
	if(href_list["CallProc"])
		var/target_proc = locate(href_list["proc_ref"])
		if(target_proc)
			VV_Tools.call_proc(requestor, target, target_proc)
	