#define isimage(A) (istype(A, /image))

#define isdatum(A) (istype(A, /datum))

#define isclient(A) (istype(A, /client))

#define isatom(A) isloc(A)

#define ismatrix(A) (istype(A, /matrix))

//You know how you have to do typesof minus itself so you don't get it in the dumb list heres a macro
#define child_typesof(target_type) (typesof(target_type) - target_type)