//get_turf(): Returns the turf that contains the atom.
//Example: A fork inside a box inside a locker will return the turf the locker is standing on.
//Yes, this is the fastest known way to do it.
#define get_turf(A) (get_step(A, 0))

