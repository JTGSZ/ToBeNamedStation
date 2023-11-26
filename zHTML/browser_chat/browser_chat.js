function test_appends(received_message) {
	var testdiv = document.createElement('div') //We makes the divs
	testdiv.innerHTML = received_message //We sticks the shits into it

	var targetdiv = document.getElementById('text_output') //We gets the text output div
	targetdiv.appendChild(testdiv)
}