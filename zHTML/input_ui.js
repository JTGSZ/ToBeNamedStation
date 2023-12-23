
var target_command = false; // The command we are currently rebinding

//Modifiers - we got no way to check left and right in byond afaik so you will only get one of each
// Its an array, why not a object? cause we can have numbers and we can't use those as a key straight up without it moving to the front.
var keyholder = [];

var splitter_symbol = " "; //The symbol we are splitting each thing by in the total string.
var keyload = ""; // all the keys stuck together, and ya u can combo keys with keys just fine etc

var unbinding = 0; // 0 for false, 1 for true

function start_up_rebinding(given_command){
	if(!target_command){
		target_command = given_command;
		toggle_key_listening();
	}
}
function toggle_key_listening(){
	document.addEventListener("keyup", key_catch_release);
	document.addEventListener("keydown", key_catch_press);
}
function untoggle_key_listening(){
	document.removeEventListener("keyup", key_catch_release);
	document.removeEventListener("keydown", key_catch_press);
}
function key_catch_press(event) {
	//This is important but the ie version we got is old as shit right now
	// If we ever get webview2 this needs to be updated to work with like event.code.
	//So for now every single thing that can be changed on shift needs checked, which is why this looks retarded, gargantuan and nasty

	//Also theres no fucking way in hell I am reconverting this dumb shit on the dm side as I'd have to catch all of these dumbass keys again via parsing there.

	let eventkey_str = event.key;
	switch(event.which){ //Also to note, we need the eventkey_str to match what byond uses for the keys
		case 192: //topkey `
			eventkey_str = "`";
			break;
		case 49: //topkey 1 
			eventkey_str = "1";
			break;
		case 50: //topkey 2
			eventkey_str = "2";
			break;
		case 51: //topkey 3
			eventkey_str = "3";
			break;
		case 52: //topkey 4
			eventkey_str = "4";
			break;
		case 53: //topkey 5
			eventkey_str = "5";
			break;
		case 54: //topkey 6
			eventkey_str = "6";
			break;
		case 55: //topkey 7
			eventkey_str = "7";
			break;
		case 56: //topkey 8
			eventkey_str = "8";
			break;
		case 57: //topkey 9
			eventkey_str = "9";
			break;
		case 48: //topkey 0
			eventkey_str = "0";
			break;
		case 189: //topkey -
			eventkey_str = "-";
			break;
		case 187: //topkey =
			eventkey_str = "=";
			break;
		case 219: //topkey [
			eventkey_str = "[";
			break;
		case 221: //key ]
			eventkey_str = "]";
			break;
		case 220: //key \
			eventkey_str = "\\";  //damn....
			break;
		case 186: //key ;
			eventkey_str = ";";
			break;
		case 222: //key '
			eventkey_str = "'";
			break;
		case 188: // key ,
			eventkey_str = ",";
			break;
		case 190: // key .
			eventkey_str = ".";
			break;
		case 191: // key /
			eventkey_str = "/";
			break;
		case 17: // key - CTRL. Byond reads it as ctrl and the browser reads it as Control
			eventkey_str = "ctrl";
			break;
		case 13: // key - Enter and Numpad Enter, byond reads it as return
			eventkey_str = "return";
			break;
		case 35: // key - end and numpad toggled
			eventkey_str = "southwest";
			break;
		case 34: // key - pagedown pgdown and numpad toggled
			eventkey_str = "southeast";
			break;
		case 36: // key - home home and numpad toggled
			eventkey_str = "home";
			break;
		case 33: // key - pageup pageup and numpad toggled
			eventkey_str = "northeast";
			break;
		case 96: // key - numpad 0
			eventkey_str = "numpad0";
			break;
		case 97: // key - numpad 1
			eventkey_str = "numpad1";
			break;
		case 98: // key - numpad 2
			eventkey_str = "numpad2";
			break;
		case 99: // key - numpad 3
			eventkey_str = "numpad3";
			break;
		case 100: // key - numpad 4
			eventkey_str = "numpad4";
			break;
		case 101: // key - numpad 5
			eventkey_str = "numpad5";
			break;
		case 102: // key - numpad 6
			eventkey_str = "numpad6";
			break;
		case 103: // key - numpad 7
			eventkey_str = "numpad7";
			break;
		case 104: // key - numpad 8
			eventkey_str = "numpad8";
			break;
		case 105: // key - numpad 9
			eventkey_str = "numpad9";
			break;
		case 145: // key - scrolllock
			eventkey_str = "scroll";
			break;
		case 111: //numpad /
			eventkey_str = "divide";
			break;
		case 106: //numpad *
			eventkey_str = "multiply";
			break;
		case 109: //numpad -
			eventkey_str = "subtract";
			break;
		case 107: //numpad +
			eventkey_str = "add";
			break;
		case 110: //numpad . numpad toggled off
			eventkey_str = "decimal";
			break;
		case 27: // ESC KEY
			eventkey_str = "UNBOUND"
			unbinding = 1;
	}

	//a smidge faster than indexof mostly because while that is ez it contains some shit for sanity, and perhaps we might want to add more logic into this later.
  	for (let i=0; i < keyholder.length; i++) {
    	if(keyholder[i] ===  eventkey_str) { //We found a duplicate
      		return; //return the damn function
    	}
  	}

	keyholder.push(eventkey_str);

}
function key_catch_release(event) {
	//join was added in 2015, so we should have it on the array object.
	keyload = keyholder.join(splitter_symbol)

	let test = document.getElementById('cocks'); //We gets the text output div
	test.innerHTML = keyload + " " + "Command:" + target_command

	//test.innerHTML = test.innerHTML + target_ref
	//var test_log_msg = document.createElement('div'); //We makes the divs
	//test_log_msg.innerHTML = keyload;
	//test.appendChild(test_log_msg);
	

	let sent_payload = 'byond://?src=' + target_ref + ';Rebind_Input=1' + ';Given_Command=' + target_command + ';Given_Input=' + keyload + ';Unbinding=' + unbinding;
	//let sent_payload = 'byond://?src=' + target_ref + ';Rebind_Input=1'
	window.location = sent_payload;

	target_command = false;
	keyholder = [];
	keyload = "";
	unbinding = 0;

	untoggle_key_listening();
}
