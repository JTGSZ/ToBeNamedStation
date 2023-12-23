

function post_text_to_output(){

	let textarea_text = document.getElementById('rp_post_box').value;

	// come on bro...
	if(textarea_text == "Type your roleplay text here...") {
		return
	}

	let sent_payload = 'byond://?src=' + target_ref + ';rp_post=1' + ';rp_post_text=' + textarea_text;
	window.location = sent_payload;
}