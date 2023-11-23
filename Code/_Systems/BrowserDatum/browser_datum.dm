/*
	Yet another iteration of browser datum,
	Mostly I want this one to be more clear to actually mess with and look at.
*/

/datum/browser
	//CONFIGURATION SEGMENTS
	var/target_user //The user whom we are targetting to send a browser page to. Can be client or mob
	var/topic_target_ref //If you set this, you get whatever automated helpers provided sent to this ref's Topic, for now you just get window_closed
	var/window_id //Basically the ID of the window

	//Window config
	var/window_width = 0 //The width of the window
	var/window_height = 0 // The height of the window
	var/window_options = null //Window options, If we don't set anything it defaults so don't worry so much

	//HTML segments
	var/title = null //Basically doc title
	var/list/html_head_content = list() // Header basically the shit contained in <head> </head> at the top
	var/list/html_content = list() //You put anything into this and its just crammed into the body really.

	//CONFIGURATION END

	//Basically if you use attach_file it just adds it onto the list here.
	//Of course... you could also just add it to this list yourself, theres nothing special about it really.
	//Also it just takes a file path aka 'cock/balls/semen.mp3'
	var/list/attached_external_files = list()

	
//After having just manually set all of the shit with dots, I'll go ahead and let you slop everything into the new call too if you wish
/datum/browser/New(gtarget_user, gwindow_id, gtitle, gwindow_width, gwindow_height, gtopic_target_ref)
	..()
	if(gtarget_user)
		target_user = gtarget_user
	if(gwindow_id)
		window_id = gwindow_id
	if(gtitle)
		title = gtitle
	if(gwindow_width)
		window_width = gwindow_width
	if(gwindow_height)
		window_height = gwindow_height
	if(gtopic_target_ref)
		topic_target_ref = gtopic_target_ref

//We do indeed have refs here, and we do need to clean them up otherwise the shit will never delete on the other end.
//Also remember, this is autocalled when you qdel something.
/datum/browser/Destroy()
	target_user = null
	topic_target_ref = null
	. = ..()

//All the shit can be seperated into procs and stages in case you want to override it.
//I don't see any particular point in like overriding the send of the browse tho, nor the join of the main html content.
/datum/browser/proc/fire()
	if((!ismob(target_user)) && (!isclient(target_user))) //If you didn't hand us a client or mob then what the fuck do you want us to send a browser page to?
		admin_msg("WE ARE GETTIN AN ATTEMPT TO SEND A BROWSER POPUP TO SOMETHING RETARDED")
		return

	//If you didn't set some config values, we just put in some defaults here.
	if(!window_width) 
		window_width = 400
	if(!window_height)
		window_height = 600
	if(!window_id)
		window_id = "[rand(1,9001)]"
	if(!window_options)
		window_options = "focus=0;can_close=1;can_minimize=1;can_maximize=0;can_resize=1;titlebar=1;"
	if(!title)
		title = ""
	//if(!topic_target_ref) //If they don't provide something else for us to work with the topic on, we will call onclose on ourself.
	//	topic_target_ref = src
	if(!html_head_content.len)
		html_head_content += {"
			<title>[title]</title>

			<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		"}

	var/actual_html_document = "" //We have to piece together everything into one big document.
	

	// In the off-chance you want to cram files into the users rsc via this and then use them in a browser document here you go I guess.
	if(attached_external_files.len) //If we have anything in this list, we better do something about it.
		for(var/cur_itr in attached_external_files)
			if(!isfile(cur_itr))
				admin_msg("A NON-PATH: [cur_itr] MADE IT INTO AN ATTACHED_EXTERNAL_FILES LIST ON A BROWSER FIRE")
				continue

			var/itr_2_str = "[cur_itr]" //Well, we know we got a path. Now to convert it to a string and split it... yeah. If you see this feel free to do somethin

			var/list/gapin_a_bitch = splittext(itr_2_str, ".") //We seperate what we got before and after the dot, this is just to determine what kinda file it is
			var/ass = gapin_a_bitch[gapin_a_bitch.len] //We got a list of two things, whats after the dot is at the end aka hopefully a file extension
			ass = lowertext(ass) //And we lowercase the endtext in the scenario someone tries to send us a cock.JS and we have to put it into our switch statement

			var/list/gapin_another_bitch = splittext(itr_2_str, "/") //We seperate the things related to the path on this one
			var/ass2 = gapin_another_bitch[gapin_another_bitch.len] //the last should be the actual filename
			ass2 = lowertext(ass2) //we lowercase it cause why not

			switch(ass) //Now we have a bunch of options on what to do with the shit, which will probably be either a css or JS file for the moment.
				if("js")
					target_user << browse_rsc(cur_itr, ass2)
					html_head_content += "<script type='text/javascript' src='[ass2]'></script>"
				if("css")
					target_user << browse_rsc(cur_itr, ass2)
					html_head_content += "<link rel='stylesheet' type='text/css' href='[ass2]'>"
				else
					admin_msg("FILE FORMAT:[itr_2_str] NEEDS SUPPORT DIPSHIT")

	
	//We we are done with anything head related we needed to tack on.
	//So just go ahead and merge anything YOU gave us and the shit above here.
	html_head_content = jointext(html_head_content, "")

	//And then we cram it into the header tagss, and also append this string to the list
	actual_html_document += {"
		<html>
			<head>
				[html_head_content]
			</head>
	"}

	//We join anything in the html_content list provided to us together into one gargantuan string too. Perhaps we can handle this better
	html_content = jointext(html_content, "")

	//Slam it in between these tags
	actual_html_document += {"
			<body>
				[html_content]
			</body>
		</html>
	"}

	//And then we merge the giant list into just one colossal string, cause thats what browse wants.
	actual_html_document = jointext(actual_html_document, "")

	//Now that we are done, we then proceed to just send over everything.
	target_user << browse(actual_html_document, "window=[window_id];size=[window_width]x[window_height];[window_options]")

	//If they provide us a ref, we will provide them a way to handle when the window is closed automatically.
	if(topic_target_ref)
		winset_close_signal_href()

//basically we stick a path to a eternal file in right here, it will be processed in the fire proc.
//You could also just not use this helper, nothing special going on here.
/datum/browser/proc/attach_file(file_path)
	attached_external_files += file_path


//It can be a list, or it can be a string who gives a shit we got both cases here.
//Once again you can just not use this at all and append directly to the html_content list anyways.
/datum/browser/proc/attach_content(strings)
	if(islist(strings))
		for(var/cur_string in strings)
			html_content += cur_string
	else
		html_content += strings

//This would basically force the browser window closed If you called it on the datum currently active.
/datum/browser/proc/close()
	target_user << browse(null, "window=[window_id]")

//this basically is called if you provide a topic_target_ref
/client/verb/browser_window_closed(var/atomref as text)
	set hidden = 1
	set name = ".browser_window_close"

	if(!atomref)
		return

	var/hsrc = locate(atomref)
	var/href = "window_closed=1" //The href we are sending to the topic_target_ref's Topic
	//world_msg("Hsrc: [hsrc] | Href: [href] | Atomref: [atomref]")
	if(hsrc)
		usr = src.mob
		src.Topic(href, params2list(href), hsrc) //The default action is to call the hsrc's own topic if we use a supercall in client/topic() apparently
		return

//Sticks a winset call in when they close the browser window, If you set a topic_target_ref this auto-sticks, since we now have a target to do a topic call on
/datum/browser/proc/winset_close_signal_href()
	set waitfor = FALSE
	for(var/i=0, i < 10, i++)
		if(target_user && winexists(target_user, window_id))
			winset(target_user, window_id, "on-close=\".browser_window_close \ref[topic_target_ref]\"")
			break

//Shitty shortcut for stylesheets or other default things
/datum/browser/proc/quickset_stylesheet(selected_sheet)
	switch(selected_sheet)
		if(STYLESHEET_SS13_COMMON)
			attach_file('zHTML/ss13common.css')
		if(STYLESHEET_VIEW_VARIABLES)
			attach_file('zHTML/viewvariable.css')



