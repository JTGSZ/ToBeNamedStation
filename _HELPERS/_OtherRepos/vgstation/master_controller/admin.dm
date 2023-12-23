// Clickable stat() button.
/obj/effect/statclick
	var/target
	icon = null

/obj/effect/statclick/New(text, target)
	name = text
	src.target = target

/obj/effect/statclick/proc/update(text)
	name = text
	return src

/obj/effect/statclick/time/Click()
	world_msg("<span class='notice'>The server time is [time2text(world.timeofday, "hh:mm:ss")].</span>")

/obj/effect/statclick/debug
	var/class

/obj/effect/statclick/debug/Click()
	if(!usr.client.holder)
		return
	if(!class)
		if(istype(target, /datum/subsystem))
			class = "subsystem"
		else if(istype(target, /datum/controller))
			class = "controller"
		else if(istype(target, /datum))
			class = "datum"
		else
			class = "unknown"

	usr.client.View_Variable(target)
	admin_msg("Admin [usr.key] is debugging the [target] [class].")


// Debug verbs.
/client/proc/restart_controller(controller in list("Master", "Failsafe", "Supply Shuttle"))
	set category = "Debug"
	set name = "Restart Controller"
	set desc = "Restart one of the various periodic loop controllers for the game (be careful!)"

	if (!holder)
		return

	switch (controller)
		if ("Master")
			new/datum/controller/master()
		if ("Failsafe")
			new /datum/controller/failsafe()

	admin_msg("Admin [usr.key] has restarted the [controller] controller.")



/client/proc/debug_controller(controller in list("Air", "Cameras", "Configuration", "Emergency Shuttle", "failsafe", "Garbage", "Jobs", "Master", "pAI", "Radio", "Sun", "Ticker", "Vote"))
	set category = "Debug"
	set name = "debug controller"
	set desc = "debug the various periodic loop controllers for the game (be careful!)."

	if (!holder)
		return

	switch (controller)
		if ("Master")
			View_Variable(Master)

		if ("failsafe")
			View_Variable(Failsafe)

		//if("Configuration")
		//	debug_variables(config)


	admin_msg("Admin [usr.key] is debugging the [controller] controller.")