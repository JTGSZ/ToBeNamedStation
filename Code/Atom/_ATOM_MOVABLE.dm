/*
	Atom movable parent and the things below it which would be obj and mob
*/

/atom/movable
	//Deletion check
	var/hard_deleted
//We movin
/atom/movable/Move(NewLoc, Dir, step_x, step_y)
	. = ..()

/*
	Loc is a reference, on atom is apparently a constant value, so we nab it here right below obj and mob
	Also make sure to cleanup all ur references
*/
/atom/movable/Destroy()
	loc = null
	..()
	

//atom/movable/verb/say_verb()