/*
	A define based configuration file for the lazy
*/


/*
	WORLD CONFIG - These just cram themselves into _WORLD.dm's definition
		CONFIG_WORLD_FPS - Basically how fast we processin shit on the world's end
			Default - 32
		CONFIG_WORLD_ICON_SIZE - Size of the default icon, effects a buncha shit idc to figure out
			Default - 32
		CONFIG_WORLD_VIEW - Default viewport range, aka how many squares your player sees
			Default - "15x15"
*/
#define CONFIG_WORLD_FPS 32
#define CONFIG_WORLD_ICON_SIZE 32
#define CONFIG_WORLD_VIEW "15x15"

/*
	PERSISTENCE CONFIG - Things related to things that persist session to session. All I got for now is just path macros here though.
		CONFIG_PERSIST_BASEFOLDER - Basefolder for all persistence shit
			Default - "Persistent_Data/"
		CONFIG_PERSIST_ADMINROSTER - File we targeting for admin_ckeys
			Default - "[CONFIG_PERSIST_BASEFOLDER]ADMIN_ROSTER.json"
*/
#define CONFIG_PERSIST_BASEFOLDER "Persistent_Data/"
#define CONFIG_PERSIST_ADMINROSTER "[CONFIG_PERSIST_BASEFOLDER]ADMIN_ROSTER.json"


/*
	CONFIG_COMBAT_TYPE - Entry for the combat type, we got defines but they jus stuck on numbers.
		Default - TYPE_COMBAT_CLICK 0

		[POSSIBLE VALUES]
		TYPE_COMBAT_CLICK - Standard click to do shit ss13
		TYPE_COMBAT_TARGET_AND_HOTBUTTONS - Select a target and hit hotkeys to do things to them.
*/
/* TODO - COMBAT SYSTEM
#define TYPE_COMBAT_CLICK 0
#define TYPE_COMBAT_TARGET_AND_HOTBUTTONS 1
#define CONFIG_COMBAT_TYPE TYPE_COMBAT_CLICK
*/
/*
	TBASSED

*/