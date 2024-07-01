
//document.body.addEventListener("mouseup", refocus_on_map_pane_map);

// Yeah Im having issues here cause it'll just refocus instead of click a href if its in the chat
document.addEventListener("keydown", refocus_on_map_pane_map);

//This is so you don't somehow find your input keys being eaten after clicking on this dumb shit
//(They aren't, you are just sending them to browserchat which is a webpage that doesn't care about them right now)
function refocus_on_map_pane_map(){
	window.location = 'byond://winset?map_pane.map_pane_map.focus=true'
}

function test_appends(received_message) {
	var msg_log = document.getElementById('text_output'); //We gets the text output div
	var html_element = document.documentElement; //Basically we get the <html> tag shit
	var distance_from_bottom = 2; //How far we can be from bottom before it autosnaps

    // allow 1px inaccuracy by adding 1
   	var currently_scrolled_to_bottom = html_element.scrollHeight - html_element.clientHeight <= html_element.scrollTop + distance_from_bottom;
	

	var new_msg = document.createElement('div'); //We makes the divs
	new_msg.innerHTML = received_message; //We sticks the shits into it
	msg_log.appendChild(new_msg);

    // If we are currently scrolled to the bottom (and within range after the distance check) then we keep scrolled to the bottom as new things arrive.
    if(currently_scrolled_to_bottom){
		html_element.scrollTop = html_element.scrollHeight - html_element.clientHeight;
	}
}

