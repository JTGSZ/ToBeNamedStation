// Subsystem defines.
// All in one file so it's easier to see what everything is relative to.

/*
	The Order we are initialized in on startup
*/
#define SS_INIT_GARBAGE            	23
#define SS_INIT_PHYSICSPROCESS		1
#define SS_INIT_UNSPECIFIED        	0
/*
	The priority we have on cpu resources
*/
#define SS_PRIORITY_PHYSICSPROCESS 	1000
#define SS_PRIORITY_UNSPECIFIED    	30
#define SS_PRIORITY_GENERICPROCESS 	3
#define SS_PRIORITY_GARBAGE        	2

/*
	The Time to wait between each fire if we are a ticking subsystem.
*/
//#define SS_WAIT_FAST_OBJECTS        0.5 SECONDS
//#define SS_WAIT_TICKER              2 SECONDS
#define SS_WAIT_PHYSICSPROCESS 		0.2 SECONDS
#define SS_WAIT_GENERICPROCESS		1 SECONDS

/*
	The display order we are shown on the stats panel
*/
#define SS_DISPLAY_GARBAGE        	-100
#define SS_DISPLAY_PHYSICSPROCESS 	100
#define SS_DISPLAY_GENERICPROCESS 	99
#define SS_DISPLAY_UNSPECIFIED     	0