var/datum/subsystem/GenericProcess/SSGenericProcess


/datum/subsystem/GenericProcess
	name          = "Generic Process"
	wait          = SS_WAIT_GENERICPROCESS
	flags         = SS_TICKER
	priority      = SS_PRIORITY_GENERICPROCESS
	display_order = SS_DISPLAY_GENERICPROCESS

	var/list/fire_list = list()

/datum/subsystem/GenericProcess/New()
	NEW_SS_GLOBAL(SSGenericProcess)

/datum/subsystem/GenericProcess/fire(resumed = FALSE)
	for(var/datum/d in fire_list)
		d.Process()

/datum/subsystem/GenericProcess/proc/Add(target)
	fire_list += target

/datum/subsystem/GenericProcess/proc/Remove(target)
	fire_list -= target