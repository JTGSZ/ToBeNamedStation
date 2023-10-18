/*
	These are simple defaults for your project.
 */

/world
	mob = /mob/player_essence
	turf = /turf/floor

	fps = CONFIG_WORLD_FPS		// 25 frames per second
	icon_size = CONFIG_WORLD_ICON_SIZE	// 32x32 icon size by default

	//view = 6		// show up to 6 tiles outward from center (13x13 view)
	view = CONFIG_WORLD_VIEW
	movement_mode = PIXEL_MOVEMENT_MODE

// Make objects move 8 pixels per tick when walking
/*
	Area 
	Turf
	Atom/Movable news occur here
	Basically the map loads in before this is called
*/
/world/New()
	. = ..()
	world_msg("Hello world") //hehe a helloworld
	Persistence_Controller = new()
	
	Persistence_Controller.admin_json_directory_to_datumlist()

/*
	When the world is told to shutdown this gets called, everything is still there for you to fucks with
	after it returns everythings dumped out of memory and everything goes byebye
*/
/world/Del()



