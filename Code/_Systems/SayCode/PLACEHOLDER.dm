/proc/to_chat(target, message)
	return world << "UNHANDLED MSG: Target: [target], Message: [message]"

/mob/verb/say_verb(message as text)
	set name = "Say"
	set category = "IC"
	set hidden = 1

	src.client.test_message("[src.name]: [message]")
/*
	My thoughts - 
		We will use hearers() over view()
		Why - Obj comes in first before mob with view
		Hearers only looks for mobs so we can potentially skim optimization there.

		Background - 
			the saycode i know of uses "virtualhearers" which is basically anything that can hear. 
			this could be an object, a mob, etc. But in reality we don't have many objects we are speaking to in order to utilize this against the cpu time cost.
			So its worth assessing things upon that point, as to whether we will only use mobs or everything.

			Secondly, we need to use the virtualhearers on players to also assess whether we will have audio playing.
			Thusly,
				1. we could have all things capable of hearing recorded into a list.
				2. we can mathematically assess what can hear what based on iterating through the entire thing, and some values (EG: Hearing range, whoa super sensitivity)
				3. In regards to audio, we will signal everything that something is being played at X turf.
				4. Via this we can raise or lower the volume, recalculating upon movement amount segments, or each movement.
*/

/*
	More thoughts - (Specifically about browser chat)
	There needs to be a browser output that is adjusted to a specific area or some shit
*/