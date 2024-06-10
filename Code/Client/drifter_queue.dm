var/datum/drifter_queue/proto_datum2

/datum/drifter_queue
	var/client/linked_client
	// Display vars
	
	var/list/queued_things = list("Drifters", "Bandits", "Crusaders")
	var/list/queued_things_tooltips = list("Standard assortment of drifters<br> looking for work", "A marauding group of bandits arrives", "Another group of the 451st crusade<br> makes it way to the land")
	var/list/max_in_wave = list(12, 24, 69)
	// Personal vars
	var/queue_joined = FALSE

	var/current_players_in_wave = 0
	var/current_wave_number = 1

	var/list/current_queued_players = list(
		"Louise Vincent",
		"Aarav Townsend",
		"Azalea Good",
		"Davian Fry",
		"Clarissa Quinn",
		"Rhys Dodson",
		"Etta Case",
		"Bentlee Bryan",
		"Meredith Nguyen",
		"Gabriel Singleton",
		"Malaysia Lyons",
		"Cyrus Hodge",
		"Coraline Delarosa",
		"Osiris Graham",
		"Alaia Bradshaw",
		"Emory Salas",
		"Amber Owens",
		"Adriel Moon",
		"Naya Warner",
		"Jaxton Hale",
		"Brinley Compton",
		"Abner Brandt",
		"Loretta Davila",
		"Grey Beltran"
	)

/datum/drifter_queue/proc/menu_chain()
	// Preload all the retarded shit we need for the menus
	var/list/file_paths = list(
	'zAssets/slop_menustyle4.css',
	)

	for(var/asses in file_paths)
		linked_client << browse_rsc(asses)

	show_menu()

/datum/drifter_queue/proc/show_menu()
	//Opening tags and empty head
	var/data = {"
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<html>
		<head>
			<style>
			</style>
			<link rel='stylesheet' type='text/css' href='slop_menustyle4.css'>
		</head>
	"}

	//Body tag start
	data += "<body>"
	data += "<table class='timer_table'><tr><td class='timer_fluff'>Time to next incursion:</td><td class='timer_time' id='queue_timer'>69:99</td></tr></table>"
	data += "<div class='queue_buttan'>"
	if(queue_joined)
		data += "<a class='leave_drifter_queue'href='?src=\ref[src];join_queue=1'>LEAVE DRIFTER QUEUE</a>"
	else
		data += "<a class='join_drifter_queue'href='?src=\ref[src];join_queue=1'>ENTER DRIFTER QUEUE</a>"
	data += "</div>"
	data += "<br>"
	data += "<div class='table_fluff_container'><span class='table_fluff_text'>Forecast:</span><span class='table_fluff_fadeout_line'></span></div><br>"
	/*
		I have decided to just display the current and the next wave
		Three would mean people would get too much heads up information and be more likely to afk than normal
	*/

	data += "<table class='wave_container'>"

	data += "<tr class='wave_row'>"
	//data += "<td class='wave_entry_href'>"

	//data += "</td>"
	data += "<td class='wave_number'>NOW: </td>"
	data += "<td class='wave_type'><a class='wave_type_hlink' href='?src=\ref[src];'>[queued_things[current_wave_number]]<span class='wave_type_hlink_tooltext'>[queued_things_tooltips[current_wave_number]]</span></a></td>"
	data += "<td>0/[max_in_wave[current_wave_number]]</td>"
	data += "</tr>"
		//<td class='wave_entry_href'></td>
	data += {"
	<tr class='wave_row'>

		<td class='wave_number'>NEXT: </td>
		<td class='wave_type'>
			<a class='wave_type_hlink' href='?src=\ref[src];'>[queued_things[current_wave_number+1]]<span class='wave_type_hlink_tooltext'>[queued_things_tooltips[current_wave_number+1]]</span></a>
		</td>
		<td>0/[max_in_wave[current_wave_number+1]]</td>
	</tr>
	"}
	data += "</table>"
	data += "<hr class='fadeout_line'>"

	// Wave entrants
	data += "<table class='player_table'>"
	var/on_playa_num = 1
	var/total_rows = ceil(current_queued_players.len/2)
	for(var/i in 1 to total_rows)
		data += "<tr>"

		for(var/ii in 1 to 2)
			data += "<td>[current_queued_players[on_playa_num]]</td>"
			on_playa_num++

		data += "</tr>"
	data += "</table>"
	//Closing Tags
	data += {"
		</body>
	</html>
	"}

	linked_client << browse(data, "window=drifter_queue;size=400x430;can_close=1;can_minimize=0;can_maximize=0;can_resize=1;titlebar=1")
	winset(linked_client, "drifter_queue", "on-close=\".browser_window_close \ref[src]\"")

/datum/drifter_queue/Topic(href, href_list)
	. = ..()
	if(href_list["join_queue"])
		queue_joined = !queue_joined

	if(href_list["window_closed"])
		world_msg("window_closed")

	show_menu()