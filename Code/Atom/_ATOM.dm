/*
	Atom Parent
	Theres an icon and no state on it yeah.
	If shit appears in the world thats invisible, then by default the no name icon in that file will be set onto it which is a error message
*/
/atom
	name = "ERROR"
	desc = "If you see this then I fucked up"
	icon = 'zAssets/Filler_Icons.dmi' 
		

/atom/Destroy()
	
	invisibility = 101 //WE are trying to delete it, why let people even attempt to see or fucks with it
	..()
	