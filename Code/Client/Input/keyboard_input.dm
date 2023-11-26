//PLACEHOLDER ILL COME BACK TO DOING A INPUTMAP
/client/verb/kbkey_pressed(key as text)
	set hidden = 1
	set name = ".kbkey-pressed"
	set instant = 1

	key = uppertext(key)

	//world_msg("[key]")
	var/mob/M = src.mob

	switch(key)
		if("W")
			step(M, NORTH)
		if("A")
			step(M, WEST)
		if("S")
			step(M, SOUTH)
		if("D")
			step(M, EAST)
			
	
//PLACEHOLDER ILL COME BACK TO DOING A INPUTMAP
/client/verb/kbkey_released(key as text)
	set hidden = 1
	set name = ".kbkey-released"
	set instant = 1

	key = uppertext(key)

	//world_msg("[key]")
	//var/mob/M = src.mob

	switch(key)
		if("W")
		if("A")
		if("S")
		if("D")