/*
	This still has a lot to do, gotta make tools on viewvariable_tools to handle stuff with various types in the future.
	Also for future reference. You can hit ctrl + n to get the link and just literally copy it into any browser
*/

//The options select menu needs redone
/client/proc/View_Variable(datum/D in world)
	set name = "View Variables"
	set desc = "View the variables"
	set category = "Debug"

	var/datum/view_variable/ass = new()
	ass.requestor = src
	ass.display_vv_menu(D)

//IS THIS SHIT BEING GARBAGE COLLECTED BECAUSE I HAVE MADE ZERO REFS AND \REF DOESN'T COUNT? the answer is yes it is. So we have to stash a ref somewhere and clean it.
//heres where vars would go aka a definition
/datum/view_variable
	var/datum/browser/our_window //Well we need to hold a ref to the browser window due to this setup.
	var/client/requestor //We also need the person requesting shit held somewhere.




//the menu
/datum/view_variable/proc/display_vv_menu(datum/D)
	if(!D) // If theres nothing just stop here
		return

	//Our title will change depending on whats going on anyways.
	var/title = ""

	//If we are a atom or above we come with a name variable, and can have an icon. Else we are a datum and do not have many things by default
	//Also since we are on 515 we can use the ref as a image src, along with that we only have icons possible on things atom and above.
	if(isatom(D))
		var/atom/A = D
		title = "<img src='\ref[D]'> <br> [A.name] (\ref[A]) = [A.type]"
	else 
		title = "*NO ICON* <br> (\ref[D]) = [D.type]"

	//These are just hrefs in a dropdown, you click one and it location.href = it. See: https://developer.mozilla.org/en-US/docs/Web/API/Location
	//I could do something fancy to process all of these, but for clarities sake just copy and paste more shit in.
	var/list/dropdown_options = list(
		"<option value=''>-Select Option-</Option>",
		"<option value='?src=\ref[src];TODO=\ref[D]'>TEST</option>"
	)
	//Join this cunt together here, as we don't really need to mess with it elsewhere right now.
	dropdown_options = jointext(dropdown_options, "") 

	//We just start slamming shit in, its colossal.
	//One thing of note is its actually less efficient
	var/html = ""

	//The title, <hr> is basically a old style line divider
	html += {"
		<div class=varname>
			[title]
		</div>
		<hr>
	"}

	//Upper menus, basically we have the button options.
	//The option select, the directional rotate thing
	html += {"
		<div>
			<table>
				<tbody>
				<tr>
					<td>
						<a href='byond://?src=\ref[src];CallProc=\ref[D]'>Call Proc</a>
						&middot;
						<a href='byond://?src=\ref[src];ListProcs=\ref[D]'>List Procs</a>
						&middot;
						<a href='byond://?src=\ref[src];CallProcALL=\ref[D]'>Call Proc ALL</a>
					</td>
					<td>
						<a href=?src=\ref[src];TODO=\ref[D]>Refresh</a>
					</td>
				</tr>
				<tr>
					<td>
					<a href=?src=\ref[src];TODO=1>Delete</a> 
					&middot; 
					<a href='byond://?src=\ref[src];TODO=\ref[D]'>Hard Delete</a>
					&middot; 
					<a href='byond://?src=\ref[src];TODO=\ref[D]'>Delete ALL</a>
					</td>
					<td>
						<select id="option-select" size="1"
							onchange="handle_dropdown(this)">
							[dropdown_options]
						</select>
					</td>
				</tr>
				<tr>
					<td>
					<b>Direction:</b> <a href='byond://?src=\ref[src];SetDirection=\ref[D];DirectionToSet=Left90'>&lt; 90&deg;</a> &middot;
					<a href='byond://?src=\ref[src];SetDirection=\ref[D];DirectionToSet=Left45'>&lt; 45&deg;</a> &middot;
					<a href='byond://?src=\ref[src];SetDirection=\ref[D]'>Set</a> &middot;
					<a href='byond://?src=\ref[src];SetDirection=\ref[D];DirectionToSet=Right45'>45&deg; &gt;</a> &middot;
					<a href='byond://?src=\ref[src];SetDirection=\ref[D];DirectionToSet=Right90'>90&deg; &gt;</a>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<hr>
	"}

	//We got the help segment here, along with the searchbar for the var table
	html += {"
		<div class=varoptionhelp>
			<font size='2'><b>E</b> - Edit, tries to determine the variable type by itself.<br>
			<b>C</b> - Change, asks you for the var type first.<br>
			<b>M</b> - Mass modify: changes this variable for ALL objects of this type.</font><br>
		</div>
		<hr>
		<div style="clear:both ">
			<b>Search:</b> <input id="search_box" style="width: 80%;" onkeyup='searchTable()' type="text" placeholder="Search for a variable or value here">
			<hr>
		</div>
	"}

	//The first tag of the var/value table, comes with its own class and id for the search function
	html += {"
		<table class="vartable" id="table_o_shit">
		"}

	//The head of the table aka the top labels, we also got a id tag so it doesn't get removed in the search(You also technically don't need a head)
	html += {"
			<thead>
				<tr id="dont_leave_me">
					<th class=varhead></th>
					<th class=varhead>Var</th>
					<th class=varhead>Value</th>
				</tr>
			</thead>
			<tbody id="dumbshit">
		"}

	//Here comes the for loop to place all the shit into the table.
	//As you can see we got <tr> - Table row with the class varrow
	//And we got <td> - table data cell - with the clases varname, varvalue, and varoptions depending on what they are in each row.

	var/useless_list_checks = 0	//This is just a counter, we tick up everytime we find something we need to skip
	var/useless_list_check_max = 1 //This is the current max, when we hit equality we no longer bother doing the string checks
	for(var/cur_var in D.vars)
		html += {"
			<tr class=varrow>
				<td class=varoptions>
					(<a href='byond://?src=\ref[src];TODO=\ref[D]'>E</a>)
					(<a href='byond://?src=\ref[src];TODO=\ref[D]'>C</a>)
					(<a href='byond://?src=\ref[src];TODO=\ref[D]'>M</a>)
				</td>
				<td class=varname>\[[cur_var]\]</td>
		"}
		var/var_value = D.vars[cur_var]

		//To note, all this does is break the list values per line right now..
		if(islist(var_value))
			if(useless_list_check_max >= useless_list_checks) //We just add anything we want to skip here thats a list, which will probably just be vars really.
				if(cur_var == "vars")
					useless_list_checks++
					html += "<td class=varvalue>Ur already looking at the vars</td>" //If we don't add a data segment we get some dumb looking formatting
					continue


			var/list/list_sex = list()
			for(var/cur_list_value in var_value)
				list_sex += "[cur_list_value]<br>"

			list_sex = jointext(list_sex, "")
			html += "<td class=varvalue>[list_sex]</td>"
		else
			html += "<td class=varvalue>[D.vars[cur_var]]</td>"

		//The closing tag for the row, we are still in the loop fyi
		html += "</tr>"

	// And heres the closing tags for the table and body.
	//After-all we do have a loop above us for all the cells so these guys gotta be on their own.
	html += {"
			</tbody>
		</table>
	"}

	//the script for the searchbar's search
	//Basically we can't use straight up [i] in the strings or byond will try to replace them.
	//So we put /[i] in instead to make it not fuck with our shit.
	html += {"
		<script>
			function searchTable() {
				var input, filter, found, table, tr, td, i, j;
				input = document.getElementById("search_box");
				filter = input.value.toUpperCase();
				table = document.getElementById("table_o_shit");
				tr = table.getElementsByTagName("tr");
				for (i = 0; i < tr.length; i++) {
					td = tr\[i].getElementsByTagName("td");
					for (j = 0; j < td.length; j++) {
						if (td\[j].innerHTML.toUpperCase().indexOf(filter) > -1) {
							found = true;
						}
					}
					if (found) {
						tr\[i].style.display = "";
						found = false;
					} else {
						if (tr\[i].id != 'dont_leave_me'){tr\[i].style.display = "none";}
						//tr\[i].style.display = "none";
					}
				}
			}

			function handle_dropdown(list) {
				var value = list.options\[list.selectedIndex].value;
				if (value !== "") {
					location.href = value;
				} 
				list.selectedIndex = 0;
				list.blur();
			}
		</script>
	"}
	//		else {
	//				list.options\[0].selected = false
	//			}
	//			list.blur();		
	//And here it is, our browser window, we are sending ourselves to have a onclose topic call on close too.
	our_window = new(requestor, "variables", null, 600, 450, src)
	our_window.html_content = html
	our_window.quickset_stylesheet(STYLESHEET_VIEW_VARIABLES)
	our_window.fire()
