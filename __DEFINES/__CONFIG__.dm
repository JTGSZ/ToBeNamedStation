/*
	A define based configuration file because its the laziest thing you can possibly do.
*/

//Server Config options
#define CONFIG_SERVER_MIN_BYOND_VERSION 514 // Min Byond Version, don't set it low enough for guys to just crash if you usin new byond features
#define CONFIG_SERVER_GUESTS_ENABLED TRUE //Whether guests can join or not
#define CONFIG_SERVER_LOCALHOST FALSE //Whether Localhost autoadmins you or not

//If this is set to a url, the user will attempt to download resources from it
//There are a bunch of options avaliable, but 1 is just standard grab shit from server
// See: https://www.byond.com/docs/ref/#/client/var/preload_rsc
#define CONFIG_SERVER_RSC_URL 1

//World config options
#define CONFIG_WORLD_FPS 32 //Basically how fast we processin shit on the world's end
#define CONFIG_WORLD_ICON_SIZE 32 //Size of the default icon, effects a buncha shit idc to figure out
#define CONFIG_WORLD_VIEW "15x15" //Default viewport range, aka how many squares your player sees

//Persistence Config options
#define CONFIG_PERSIST_BASEFOLDER "Persistence_Data/" //Basefolder for all persistence shit
#define CONFIG_PERSIST_ADMINROSTER_FOLDER "[CONFIG_PERSIST_BASEFOLDER]Admin_Data/" //Directory we targeting for files named after admin_ckeys

// Error handler config options.
#define CONFIG_ERROR_COOLDOWN 600 // The "cooldown" time for each occurrence of a unique error
#define CONFIG_ERROR_LIMIT 9 // How many occurrences before the next will silence them
#define CONFIG_ERROR_SILENCE_TIME 6000 // How long a unique error will be silenced for
#define CONFIG_ERROR_MSG_DELAY 50 // How long to wait between messaging admins about occurrences of a unique error
#define CONFIG_ERROR_USEFUL_LEN 2 // If there aren't at least three lines, there's no info



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