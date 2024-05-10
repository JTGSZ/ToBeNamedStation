/*
	A datum that handles creating/deleting/apply and tracking a group of screen ui objects.
*/

/datum/screen_object_group
	var/list/screen_object_paths = list(
	)
	var/list/instanced_screen_objects = list()

/datum/screen_object_group/New()
	create_screenobjects()

/*
	Make all the screen objects and put the refs in a list
*/
/datum/screen_object_group/proc/create_screenobjects()
	for(var/cock_paths in screen_object_paths)
		instanced_screen_objects += new cock_paths // We jus maka the objecta and masdfsdfdfgjn 

/*
	Apply all the screenobjects in the datums list to the clients screen
*/
/datum/screen_object_group/proc/apply_screenobjects_to_client(client/C)
	for(var/atom/movable/dumbshit in instanced_screen_objects)
		C.screen += dumbshit
/*
	Remove all the screenobjects in the datums list from the clients screen
*/
/datum/screen_object_group/proc/remove_screenobjects_from_client(client/C)
	for(var/atom/movable/dumbshit in instanced_screen_objects)
		C.screen -= dumbshit


/datum/screen_object_group/mainmenu
	screen_object_paths = list(
		/atom/movable/screen_object/mainmenu_logo,
		/atom/movable/screen_object/button/mainmenu_new_button,
		/atom/movable/screen_object/button/mainmenu_load_button
	)

/*
	Just a shitty type for things that are dedicated screen_objects

	TODO: REFACTOR THESE SO THEY ATTACH TO SOMETHING AND WE CAN JUST USE PIXEL_X AND PIXEL_Y
	THESE MOTHERFUCKERS FUCK THE CLIENT SCREEN IN THE ASS IF THEY GO OFF

	You can technically just make a special winset titlebarless browser window over the lobby screen too for the buttons
	It will respond faster, be easier to deal with, work on and perform better.
*/
/atom/movable/screen_object

/atom/movable/screen_object/mainmenu_logo
//	icon = 'zAssets/UI/logo.png'
	screen_loc = "RIGHT-1,TOP-2"

/atom/movable/screen_object/mainmenu_logo/New()
	//src.transform = matrix(0.75, 0, 0, 0, 0.75, 0)// scale down the hud
	//src.appearance_flags = PIXEL_SCALE
	..()

/*
	Button objects lol
	You click them and they call a proc whoa.... .. . whoa... damn
*/
/atom/movable/screen_object/button

/atom/movable/screen_object/button
	name = "Frezh Buton"

/atom/movable/screen_object/button/proc/button_clicked(client/C)
	world_msg("We hit")


/atom/movable/screen_object/button/Click(location, control, params)
	var/client/C = usr
	button_clicked(C)
	
/atom/movable/screen_object/button/mainmenu_new_button
	name = "New Character"
//	icon = 'zAssets/UI/new.png'
	screen_loc = "LEFT+1,CENTER"

/atom/movable/screen_object/button/mainmenu_load_button
	name = "Load Character"
//	icon = 'zAssets/UI/load.png'
	screen_loc = "RIGHT-2,CENTER"




