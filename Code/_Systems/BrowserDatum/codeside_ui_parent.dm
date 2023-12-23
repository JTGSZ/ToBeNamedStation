/*
	Considering how many browser menus ive been making
	Along with the need to repeat code for the other end of it, might as well make a parent to cut down on the work.
*/

/datum/ui
	var/datum/browser/our_window //Well we need to hold a ref to the browser window due to this setup.
	var/client/requestor //Basically the client requesting this shit