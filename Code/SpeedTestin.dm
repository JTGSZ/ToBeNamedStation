/*
	Verb for setting up a initial admin_roster list with a host.
*/

/mob/player_essence/verb/test_transfer()
	src.Essence_Unto_Soul()

//You just put the shit there and you get an amount of time it has ran probably.
/mob/verb/benchmark()
	var start = world.timeofday

	// Code goes here

	var end = world.timeofday

	var result = end - start
	world_msg("Time Result: [result]")

/mob/verb/output_testing()
	src.client.test_message("TEST TEST TESTEST ETSTEST TESTESTSETETSETSET")



