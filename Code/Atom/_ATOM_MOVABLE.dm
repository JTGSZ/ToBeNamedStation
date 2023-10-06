/*
	Atom movable parent and the things below it which would be obj and mob
*/

/atom/movable

//We movin
/atom/movable/Move(NewLoc, Dir, step_x, step_y)
	. = ..()

/*
	Loc is a reference
	Also make sure to cleanup all ur references
*/
/atom/movable/Destroy()
	loc = null
	. = ..()
	