/*
	Atom movable parent and the things below it which would be obj and mob
*/

/atom/movable
	var/hard_deleted //Deletion check
	step_size = 6
	
	

/atom/movable/New()
	. = ..()




/*
	Loc is a reference, on atom is apparently a constant value, so we nab it here right below obj and mob
	Also make sure to cleanup all ur references
*/
/atom/movable/Destroy()
	loc = null
	..()

/*
	From we hit key, client has move called on it
	client sees its mob is in a thing, it calls relay move
	Thing sees its in a thing, we continue the chain.
*/
/atom/movable/proc/relayMove(move_inputter, dir)
	if(!isturf(src.loc)) // If we are yet another thing inside of a thing, time to continue relaying the move
		var/atom/movable/vore_mommy = src.loc 
		vore_mommy.relayMove(src, dir)
	else
		step(src, dir)

//If this doesn't return anything, you do in fact not move.
//step will cause the below to be called
/atom/movable/Move(NewLoc, Dir, step_x, step_y)
	glide_size = (CONFIG_WORLD_ICON_SIZE / step_size) * world.tick_lag
	//glide_size = 1
	// TODO: MAKE A WORKING CALCULATION FOR THIS SHIT SOMEDAY
	. = ..()
	
	