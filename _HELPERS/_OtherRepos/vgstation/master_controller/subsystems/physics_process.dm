var/datum/subsystem/physics_process/SSPhysicsProcess


/datum/subsystem/physics_process
	name          = "physics process"
	wait          = SS_WAIT_PHYSICSPROCESS
	flags         = SS_TICKER
	priority      = SS_PRIORITY_PHYSICSPROCESS
	display_order = SS_DISPLAY_PHYSICSPROCESS

	var/list/fire_list = list()

/datum/subsystem/physics_process/New()
	NEW_SS_GLOBAL(SSPhysicsProcess)

/datum/subsystem/physics_process/fire(resumed = FALSE)
	for(var/atom/movable/am in fire_list )
		am.physics_process()

/datum/subsystem/physics_process/proc/Add(target)
	fire_list += target

/datum/subsystem/physics_process/proc/Remove(target)
	fire_list -= target