/*
	A define based configuration file because its the laziest thing you can possibly do.
*/

//Server Config options
#define CONFIG_SERVER_MIN_BYOND_VERSION 514 // Min Byond Version, don't set it low enough for guys to just crash if you usin new byond features
#define CONFIG_SERVER_GUESTS_ENABLED 	TRUE //Whether guests can join or not
#define CONFIG_SERVER_LOCALHOST_POWERS 	TRUE //Whether Localhost autoadmins you or not

//If this is set to a url, the user will attempt to download resources from it
//There are a bunch of options avaliable, but 1 is just standard grab shit from server
// See: https://www.byond.com/docs/ref/#/client/var/preload_rsc
#define CONFIG_SERVER_RSC_URL 1

//World config options
#define CONFIG_WORLD_FPS 40 //Basically how fast we processin shit on the world's end
#define CONFIG_WORLD_ICON_SIZE 32 //Size of the default icon, effects a buncha shit idc to figure out
#define CONFIG_WORLD_VIEW 8 //Default viewport range, aka how many squares your player sees
#define CONFIG_WORLD_SLEEP_OFFLINE FALSE //If its set to true, the world just stops doing shit if nobody is on.

//Persistence Config options
#define CONFIG_PERSIST_BASEFOLDER "Persistence_Data/" //Basefolder for all persistence shit
#define CONFIG_PERSIST_ADMINROSTER_FOLDER "[CONFIG_PERSIST_BASEFOLDER]Admin_Data/" //Directory we targeting for files named after admin_ckeys
#define CONFIG_PERSIST_PLAYERDATA_FOLDER "[CONFIG_PERSIST_BASEFOLDER]Player_Data/" //Directory we are targeting for playerdata
#define CONFIG_PERSIST_ADMIN_DATUM_VERSION 0 //Version number saved into json for admin datums, DO NOT MOVE IT UP UNLESS YOU MAKE A BREAKING CHANGE TO PREV DATA AND NEED TO UPDATE IT
#define CONFIG_PERSIST_PLAYER_DATA_VERSION 0 //Version number saved into json for player data. DO NOT MOVE IT UP UNLESS YOU MAKE A BREAKING CHANGE TO PREV DATA AND NEED TO UPDATE IT

//Pref Config options
#define CONFIG_PREF_RECC_CLIENT_FPS 50 //If they set their fps to -1 you give them this value automatically

//Gameplay config options

//Debug options
#define CONFIG_DEBUG_BYPASS_INITIAL_JOIN_MENUS TRUE// Just automatically sticks you into a body and avoids any initial join menus

