/*
	Verb for setting up a initial admin_roster list with a host.
*/
/*

/mob/new_player/verb/test_transfer()
	set category = "DEV-Debug"
	//src.Essence_Unto_Soul()

//You just put the shit there and you get an amount of time it has ran probably.
/mob/verb/benchmark()
	set category = "DEV-Debug"
	var start = world.timeofday

	// Code goes here

	var end = world.timeofday

	var result = end - start
	world_msg("Time Result: [result]")

/mob/verb/output_testing()
	set category = "DEV-Debug"

	world_msg("ASS")
	world_msg("ASS")
	world_msg("ASS")
	world_msg("ASS")
	world_msg("ASS")
	world_msg("ASS")

*/

/mob/verb/output_testing()
	set category = "DEV-Debug"

	if(prob(30))
		world_msg("Cock")
	else(prob(20))
		world_msg("5% cock")