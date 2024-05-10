#define TRIUMPH_CAT_ROUND_EFX "ROUND-EFX"
#define TRIUMPH_CAT_CHARACTER "CHARACTER"
#define TRIUMPH_CAT_MISC "MISC!"
#define TRIUMPH_CAT_ACTIVE_DATUMS "ACTIVE"

//testenv
/client
	var/triumph_amount = 10284

// Make sure to have a bool on whether they can be got pre-round or post-round instead of having a category for it.
/datum/triumph_buy
	var/desc = "ERROR  "
	var/triumph_cost = 107
	var/category = TRIUMPH_CAT_ACTIVE_DATUMS

/datum/triumph_buy/test
	desc = "ERROR "
	triumph_cost = 69

// Preload all the retarded shit we need for the menus
/datum/triumph_testing/proc/preload_assets()
	var/list/file_paths = list(
	'zAssets/try4.png',
	'zAssets/try4_border.png',
	'zAssets/slop_menustyle2.css',
	)

	for(var/asses in file_paths)
		linked_client << browse_rsc(asses)

var/datum/triumph_testing/proto_datum

/datum/triumph_testing

	/*
		===============START TRIUMPH SS SIDED VARS======================
	*/
	var/list/triumph_buy_datums = list() //this is basically the total list of triumph buy datums on init

	var/list/active_triumph_buy_queue = list() // This is a list of all active datums

	// This represents the triumph buy organization on the main SS for triumphs
	// Each key is a category name
	// And then the list will have a number in a string that leads to a list of datums
	var/list/central_state_data = list(
		TRIUMPH_CAT_ROUND_EFX = 0,
		TRIUMPH_CAT_CHARACTER = 0,
		TRIUMPH_CAT_MISC = 0,
		TRIUMPH_CAT_ACTIVE_DATUMS = 0
	)

	// display limit per page in a category on the user menu
	var/page_display_limit = 12
	/*
		==================END TRIUMPH SS SIDED VARS======================
	*/

	/*
		==========TRIUMPH_BUY CLIENT HELPER DATUM VARS==============
	*/

	//These are the menu datum vars
	var/client/linked_client
	var/triumph_quantity = 108 // The amount of triumphs we got

	var/current_page = "1" // Current page of triumphs we are viewing and yes its a number in a string
	var/current_category = TRIUMPH_CAT_ROUND_EFX //Current category we are viewing

	var/page_count = 0
	/*
		==========END TRIUMPH_BUY CLIENT HELPER DATUM VARS==============
	*/


/datum/triumph_testing/proc/slop_prep()
	preload_assets()
	world_msg("WE HIT")
	
//Triumph SS sided vars
	var/list/testenv_options = list(		
		TRIUMPH_CAT_ROUND_EFX = 0,
		TRIUMPH_CAT_CHARACTER = 0,
		TRIUMPH_CAT_MISC = 0,
		)

	//Fill with fodder on testenv == this represents making all the types into the total uncategorized list anyways
	for(var/i in 1 to 50)
		var/datum/triumph_buy/test_datum = new /datum/triumph_buy // We will do this
		var/picked_key = pick(testenv_options) // TESTENV SHIT
		test_datum.category = picked_key // TESTENV SHIT - more testenv shit this will be on the triumph buy definition
		test_datum.desc = "category: [test_datum.category], datum number: [i]" // TESTENV SHIT
		triumph_buy_datums += test_datum // TESTENV SHIT
		central_state_data[test_datum.category] += 1 // Tally up the totals here to save on a total of one loop

	// Make a local copy I guess?
	var/list/copy_list = triumph_buy_datums.Copy()

	//Figure out how many lists we are about to make to represent the pages
	for(var/catty_key in central_state_data)
		page_count = ceil(central_state_data[catty_key]/page_display_limit) // Get the page count total
		central_state_data[catty_key] = list() // Now we swap the numbers out for lists on each cat as it will contain lists representing one page

		// Now fill in the lists starting at index "1" 
		for(var/page_numba in 1 to page_count)
			central_state_data[catty_key]["[page_numba]"] = list()
			for(var/ii = copy_list.len, ii > 0, ii--)
				var/datum/triumph_buy/current_triumph_buy_datum = copy_list[ii]
				if(current_triumph_buy_datum.category == catty_key)
					central_state_data[catty_key]["[page_numba]"] += current_triumph_buy_datum
					copy_list -= current_triumph_buy_datum
				if(central_state_data[catty_key]["[page_numba]"].len == page_display_limit)
					break

	show_menu()

// TRIUMPH BUY MENU SIDED PROC
/datum/triumph_testing/proc/show_menu(client/C)
	var/data = {"
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<html>
		<head>
			<style>
				@import url('https://fonts.googleapis.com/css2?family=VT323&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Jacquarda+Bastarda+9&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Silkscreen:wght@400;700&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Nosifer&display=swap');
			</style>
			<link rel='stylesheet' type='text/css' href='slop_menustyle2.css'>
		</head>
	"}

	data += {"
		<body>
			<div style='width:100%;'>
				<span id='triumph_quantity'> My triumphs: [linked_client.triumph_amount] Triumphs</span> 
				<a id='triumph_close_button' href='?src=\ref[src];close_menu=1'>CLOSE MENU</a>
			</div> 
			<div style='width:100%;float:left'>
				<span id='top_categories'>CATEGORIES:</span>
		"}

	for(var/cat_key in central_state_data)
		if(cat_key == current_category)
			data += "<a class='triumph_categories_selected' href='?src=\ref[src];select_a_category=[cat_key]'><span class='bigunder_back'><span class='bigunder'></span>[cat_key]</span></a>"
			continue
		data += "<a class='triumph_categories_normal' href='?src=\ref[src];select_a_category=[cat_key]'>[cat_key]</a>"

	data += {"
			</div>
			<table>
				<thead>
					<tr>
						<th class='triumph_text_head'>Description</th>
						<th class='triumph_text_head'>Triumph Cost</th>
						<th class='triumph_text_head'>Buy Button</th>
					</tr>
				</thead>
				<tbody>
	"}
	
	if(current_category == TRIUMPH_CAT_ACTIVE_DATUMS)
		if(active_triumph_buy_queue.len)
			for(var/datum/triumph_buy/auugh in active_triumph_buy_queue)
				data += {"
					<tr class='triumph_text_row'>
						<td class='triumph_text_desc'>[auugh.desc] | Bought by: [active_triumph_buy_queue[auugh]]</td>
						<td class='triumph_filler_cells'><span class='triumph_cost'>[auugh.triumph_cost]</span></td>
						<td class='triumph_filler_cells'><a class='triumph_text_buy' href='?src=\ref[src];handle_buy_button=\ref[auugh];'>UNBUY</a></td>
					</tr>
				"}
		else
			data += {"
				<tr class='triumph_text_row'>
					<td class='triumph_text_desc'>CURRENTLY NOTHING</td>
					<td class='triumph_filler_cells'><span class='triumph_cost'>ACTIVELY</span></td>
					<td class='triumph_filler_cells'><a class='triumph_text_buy' href='?src=\ref[src];'>HERE</a></td>
				</tr>
			"}

	else
		for(var/datum/triumph_buy/dd_titties in central_state_data[current_category]["[current_page]"])
			data += {"
				<tr class='triumph_text_row'>
					<td class='triumph_text_desc'>[dd_titties.desc]</td>
					<td class='triumph_filler_cells'><span class='triumph_cost'>[dd_titties.triumph_cost]</span></td>
				"}
			data += {"
					<td class='triumph_filler_cells'><a class='triumph_text_buy' href='?src=\ref[src];handle_buy_button=\ref[dd_titties];'><span class='strikethru_back'>CONFLICT</span></a></td>
				</tr>
			"}


	data += {"
				</tbody>
			</table>
			"}
	data += "<div class='triumph_footer'>"

	for(var/i in 1 to central_state_data[current_category].len)

		if("[i]" == current_page)
			data += "<a class='triumph_numbers_selected' href='?src=\ref[src];select_a_page=[i]'><span class='num_bigunder_back'><span class='num_bigunder'></span>[i]</span></a>"
		else
			data += "<a class='triumph_numbers_normal' href='?src=\ref[src];select_a_page=[i]'>[i]</a>"

	data += "</div>"
	data += {"
		</body>
	</html>
	"}

	linked_client << browse(data, "window=triomph_slect_f_tards;size=500x760;can_close=1;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1")

// TRIUMPH SS SIDED
/datum/triumph_testing/proc/attempt_to_buy_triumph_condition(datum/triumph_buy/stick_it_in)
	var/triumph_amount = check_triumph_amount(linked_client) - stick_it_in.triumph_cost
	if(triumph_amount >= 0)
		adjust_triumph_amount(linked_client, stick_it_in.triumph_cost*-1)
		active_triumph_buy_queue += stick_it_in

// TRIUMPH SS SIDED
/datum/triumph_testing/proc/attempt_to_unbuy_triumph_condition(datum/triumph_buy/pull_it_out)
	var/triumph_amount = check_triumph_amount(linked_client) - pull_it_out.triumph_cost
	if(triumph_amount >= 0)
		adjust_triumph_amount(linked_client, pull_it_out.triumph_cost*-1)
		active_triumph_buy_queue -= pull_it_out

// TRIUMPH SS SIDED
/datum/triumph_testing/proc/adjust_triumph_amount(client/C, amount)
	C.triumph_amount += amount

// TRIUMPH SS SIDED
/datum/triumph_testing/proc/check_triumph_amount(client/C)
	. = C.triumph_amount

// TRIUMPH BUY MENU SIDED PROC
/datum/triumph_testing/Topic(href, list/href_list)
	. = ..()

	if(href_list["select_a_category"])
		var/sent_category = href_list["select_a_category"]
		if(central_state_data[sent_category])
			if(sent_category != current_category)
				current_category = sent_category
				show_menu()

	if(href_list["select_a_page"])
		var/sent_page = href_list["select_a_page"]
		if(central_state_data[current_category]["[sent_page]"])
			if(sent_page != current_page)
				current_page = sent_page
				show_menu()

	if(href_list["close_menu"])
		linked_client << browse(null, "window=triomph_slect_f_tards")

	//This sends a reference to a datum, 
	if(href_list["handle_buy_button"])
		var/datum/triumph_buy/target_datum = locate(href_list["handle_buy_button"])
		if(target_datum)
			if(current_category == TRIUMPH_CAT_ACTIVE_DATUMS) // ACTIVE datums are ones already bought anyways
				attempt_to_unbuy_triumph_condition(target_datum) // By unbuy, i mean you unbuy someone elses buy
			else
				attempt_to_buy_triumph_condition(target_datum) // regular buy
			show_menu()

