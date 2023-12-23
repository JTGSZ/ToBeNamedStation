/*
	All the input/moveloop stuff will be rewritten if its shown to have horrible performance really.
	I do not know the best approach for this while including rebinding.
	To note we need most crispiness over-all in the game for input polling and movement otherwise it will feel like shit for the user.
*/

//Sends 1 to the same command
/client/verb/key_pressed(key as text)
	set hidden = 1
	set name = ".key-pressed"
	set instant = 1

	key = uppertext(key) //Fun fact byond will give you "Shift" lol

	//If they hit a movement key, just handle it here, and don't put it into the held keymap.

	if(movement_keymap[key])
		bindcomm_data_cache[movement_keymap[key]].on_press(src)
		return

	held_keymap += key //We add the key to the held list, and naturally it keeps order
	
	key = jointext(held_keymap, " ")
	if(input_keymap[key]) // See if we have ran into anything.
		bindcomm_data_cache[input_keymap[key]].on_press(src)

//Sends 0 to the same command
/client/verb/key_released(key as text)
	set hidden = 1
	set name = ".key-released"
	set instant = 1

	key = uppertext(key)

	if(movement_keymap[key])
		bindcomm_data_cache[movement_keymap[key]].on_release(src)
		return

	key = jointext(held_keymap, " ")
	if(input_keymap[key]) // See if we have ran into anything.
		bindcomm_data_cache[input_keymap[key]].on_release(src)

	held_keymap -= key //And we can remove it just like this also maintaining the order of shit pressed