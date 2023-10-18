/client/proc/add_admin_verbs()
    if(holder)
        if(holder.rights & R_ADMIN)
            verbs += admin_verbs_admin
        if(holder.rights & R_DEBUG)
            verbs += admin_verbs_debug
        if(holder.rights & R_PERMISSIONS)
            verbs += superadmin_verbs

/client/proc/remove_admin_verbs()
    verbs.Remove(
    admin_verbs_admin,
    admin_verbs_debug,
    superadmin_verbs
    )


// lol
var/list/admin_verbs_admin = list(
)

var/list/superadmin_verbs = list(
    /client/proc/permissions_panel,
    /client/proc/admin_add
)

var/list/admin_verbs_debug = list(
    /client/proc/view_runtimes,
)