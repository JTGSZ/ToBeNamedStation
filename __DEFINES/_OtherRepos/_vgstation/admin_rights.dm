/*
	admin rights
*/
//Bitflag increments incase you desire more rights and need a reference
//1 2 4 8 16 32 64 128 256 512 1024
//2048 4096 8192 16384 32768 65535
//131072 262144 524288 1048576 2097152 4194304 8388608

#define R_ADMIN 1
#define R_DEBUG 2
#define R_PERMISSIONS 4

// For iteration purposes, always keep this at the last bitflag outside of host perms
#define R_MAX_PERMISSIONS 4
#define R_HOST 65535