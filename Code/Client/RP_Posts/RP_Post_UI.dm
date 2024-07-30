/*
	The resizing on this is currently really really really bad
	See: textbox_rows
*/

/client/verb/display_rp_post_ui()
	set name = ".display_rp_post_ui"
	set hidden = 1

	var/datum/ui/roleplay_post_ui/ass = new()
	ass.requestor = src
	ass.display_rp_post_ui_menu()

/datum/ui/roleplay_post_ui


/datum/ui/roleplay_post_ui/proc/display_rp_post_ui_menu()
	var/textbox_rows = 41
	var/html = {"

			<textarea id='rp_post_box' rows='[textbox_rows]'>Type your roleplay text here...</textarea><hr>
			<button type='button' onclick='post_text_to_output()'>POST TO OUTPUT</button>
	"}

	//This pattern has occurred twice now, if theres too many of these perhaps the browser datum could just auto make the var itself.
	html += "<script> var target_ref = \"\ref[src]\";</script>" 
		
	our_window = new(requestor, "rp_post", "Roleplay Post", 620, 690, src)
	our_window.attach_file('zHTML/rp_post_ui.js', LOAD_AFTER_HTML_CONTENT)
	our_window.html_content = html
	our_window.quickset_stylesheet(STYLESHEET_SS13_COMMON)

	//The CSS styling for the textarea, not worth a entire stylesheet yet or a change to a regular one.
	// # is the selector for a ID
	// . is the selector for a Class
	// Nothing means we modify the element
	our_window.html_head_content += {"
	<style>
	#rp_post_box {
		width:98%;
		font-size: 82%;
		overflow-x: hidden
		overflow-wrap: break-word;
		word-wrap: break-word;
		word-break: break-all;
		border:1px solid #999999;
		margin:5px 0;
		padding:3px;
	}
	</style>
	"}

	our_window.fire_browser()

/datum/ui/roleplay_post_ui/Topic(href, href_list)
	. = ..()
	//let sent_payload = 'byond://?src=' + target_ref + ';rp_post=1' + 'rp_post_text=' + textarea_text;
	if(href_list["rp_post"])
		if(href_list["rp_post_text"])
			var/mob/sender = requestor.mob
			var/rp_post = href_list["rp_post_text"]
			if(sender)
				var/datum/player_persistence_data/persist_data = player_persistence_data_cache["[requestor.ckey]"]
				//The naming part will prob need rewritten
				rp_post = "<span style=\"color:[persist_data.EMOTE_text_color]\">[requestor.mob.name] : [rp_post]</span>"
				var/datum/message_data/msg_data = new(src, rp_post, world.view)
				route_message_hearers(msg_data)

