//Basic usage for default paging and single search box, with optional postbuild steps
//Overridable if used on the more-local page itself (repeat further down)
function SetAndPushGrid(itemType) {
	//var flds = $("input:text").serialize(); //Specialized; need to include select, etc.
	var flds = $("fieldset.filter input,select,hidden").serialize(); //Requires name attribute!
	var params = "{inputParams: '" + flds + "'}";  // {inputParams: 'search=&pageSize=100&pageNumber=0'}	
	//alert(params);
	pushGrid(params, itemType + 'List', true, function () { PostTableBuild() });
}

//Override where needed - do not delete!
function PostTableBuild() { }

function ConfigureGridTriggers(itemType) {
	var checkboxes = $('fieldset.filter input[type=checkbox]');
	var textboxes = $('fieldset.filter input[type=text]');
	var dropdowns = $('fieldset.filter select');

	checkboxes.change(function () { SetAndPushGrid(itemType); });
	textboxes.change(function () { SetAndPushGrid(itemType); });
	dropdowns.change(function () { SetAndPushGrid(itemType); });

	$('.pagingButton').click(function() {
		//This function is unique to each page and needs to be configured independently
		SetAndPushGrid(itemType);
	});

	//Configure 'clear button' that will wipe all filter fields/selectors
	$('.clearFilterButton').addClass('hand').attr('title', 'Clear Filter').click(function () {
		$.each(checkboxes, function () { SetDefaultValue($(this)); });
        $.each(textboxes, function () { SetDefaultValue($(this)); });
        $.each(dropdowns, function () { SetDefaultValue($(this)); });

        SetAndPushGrid(itemType);
	});
}

function SetDefaultValue(ele) {
    var d = ele.attr('valueDefault'); //alert(d);
	if (d == undefined)
		ele.val('');
	else
		ele.val(d);
}

function pushGrid(params, page, hasSearch, callback, showTrackingFields) {
	ClearOutput();

	$.ajax({
		type: "POST",
		url: page + ".aspx/GetData",
		data: params,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (msg) {
			if (msg != null) {
				ParseOutput(msg.d, params, showTrackingFields);

				if (hasSearch != undefined && hasSearch == true)
					WrapSearchResults();
			}
		},
		complete: function () {
			//Use for post-generation html tweaks, mainly - since the new options won't "exist" until now in the DOM.
			if (callback != undefined)
				callback();
		},
		error: function (request, status, error) {
			alert(request.responseText);
			//$('#Output').html('<p class="errorTable">Error retrieving records.</p>');
			//window.location = "../../Public/Error.html";
		}
	});
}

//Replace div container's content with the ajax method's return set, as parsed into an html table.
function ParseOutput(jsonString, params, showTrackingFields) {
	var obj = $.parseJSON(jsonString);
	var items = obj.Items; //alert(items.length);
    if (items.length > 0) {
		//The to_table() function can be overridden by including a custom version on the page.
    	$('#Output').html(to_table(items, obj.ItemType, showTrackingFields));

		//If an "itemCount" element is found, populate it with the count of displayed items, up to the max paging size
		var itemCount = $(".itemCount");
		if (itemCount) {
			var paramsObj = eval('(' + params + ')');
			itemCount.text(' (showing ' + obj.Start  + ' - ' + obj.End + ' of ' + obj.Total + ')');
//			if (obj.length >= paramsObj.pageSize)
//				itemCount.html("(" + obj.length + " MAX) * <i>Large result set, may not show all items. Please add a search filter.</i>");
//			else
//				itemCount.text("(" + obj.length + ")");
		}
	}
	else
		$('#Output').html('<p class="emptyTable">No records found.</p>');
}

//This will output an HTML table that matches the JSON collection.
//To override with a custom table, insert a more-local function of the same name on the desired page.
function to_table(objArray, itemType, showTrackingFields) {
	cachedJSON = objArray;

	var array = typeof objArray != 'object' ? $.parseJSON(objArray) : objArray;

	var table = $('<table class="listview"></table>');
	var thead = $('<thead></thead>');
	var tr;

	//Add header row from field names
	for (var key in array[0]) {
		//alert('name=' + key + ' value=' + array[0][key]);

		//Skip tracking fields by default
		if (key == "Id" || ((showTrackingFields == undefined || !showTrackingFields) && key in { ModifiedDate: 1, ModifiedBy: 1, CreatedDate: 1, CreatedBy: 1 }))
			continue;

		//Split camel-casing into separate words
		key = key.replace(/((?![A-Z])[A-Z]|[A-Z](?![A-Z]))/g, ' $1');
		//key = key.replace(/([a-z])([A-Z])/g, '$1 $2'); //doesn't work with all-cap words

		thead.append($('<th>' + key + '</th>'));
	}

	//Add action column
	if (itemType != undefined)
		thead.append($('<th>Actions</th>'));

	table.append(thead);

	var rowId = -1;
	var row;

	//Add one row per JSON record
	for (var i = 0; i < array.length && array[i] != undefined; i++) {
		row = array[i];
		rowId = row.Id; //alert(item.Id);
		
		tr = $('<tr rowId="' + rowId + '"></tr>');

		for (var col in row) {
			//Skip tracking fields by default
			if (col == "Id" || ((showTrackingFields == undefined || !showTrackingFields) && col in { ModifiedDate: 1, ModifiedBy: 1, CreatedDate: 1, CreatedBy: 1 }))
				continue;

			var value = row[col];

			//JSON string date hack
			if (typeof value == "string" && value.substr(0, 5) == "/Date") {
				var parseDate = new Date(parseInt(value.substr(6)));
				try {
					value = parseDate.format("mm/dd/yy hh:MM TT"); //alert(value);
				}
				catch (err) { value = parseDate.toString(); } //handled errors gracefully in case date.Format library not installed
			}

			if (value === "null" || value === null || value.length == 0)
				value = "&nbsp;";

			tr.append($('<td>' + value + '</td>'));
		}

		//Add action column
		if (itemType != undefined)
			tr.append($('<td nowrap><a href="' + itemType + 'Edit.aspx?Id=' + rowId + '">Edit</a></td>'));

		table.append(tr);
	}

	return table;
}

//Adds highlighting to each string that contains a match for the search filter
function WrapSearchResults() {
	var searchArray = $('#tbSearchFilter').val().split(' ');
	$.each(searchArray, function() {
		var text = jQuery.trim(this);
		if (text.length > 0) {
			var regEx = new RegExp('\(' + text + '\)', 'gi');
			$('#Output td').not('.action').not('.unSearchable').each(function() {
				$(this).html($(this).html().replace(regEx, '<span class="highlight">$1</span>'));
			});
		}
	});
}

function pushSelector(entity, params, page, selected, callback) {
	ClearOutput();
	//alert("selected " + selected);
	$.ajax({
		type: "POST",
		url: page + ".aspx/Get" + entity + "Data",
		data: params,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (msg) {
			if (msg != null)
				ParseSelectorOutput(msg.d, entity, selected);
		},
		complete: function () {
			//Use for post-generation html tweaks, mainly - since the new options won't "exist" until now in the DOM.
			if (callback != undefined)
				callback();
		},
		error: function (request, status, error) {
			//alert(request.responseText);
			//$('#Output').html('<p class="errorTable">Error retrieving records.</p>');
			window.location = "../../Public/Error.html";
		}
	});
}

//Update select control's options content with the ajax method's return set.
function ParseSelectorOutput(jsonString, entity, selected) {
	var obj = $.parseJSON(jsonString);
	//alert(obj.length);
	if (obj.length > 0) {
		//Append name/value pair list to the select control's options collection
		$.each(obj, function (key, value) {
			//alert(value);
			//alert("key: " + key);
			var ddl = $('#ddl' + entity);
			ddl.append($("<option></option>").attr("value", value.Id).text(value.Name));
			//Select the desired option item
			ddl.val(selected);
		});
	}
}

//Shows loading animation (use for ajax calls)
function ClearOutput() {
    $('#Output').html('<img src="../../Content/Images/Common/loading_small.gif" />');
	$(".itemCount").text("");
}

//var value = $.urlParam('key');
$.urlParam = function (name) {
	var results = new RegExp('[\\?&]' + name.toLowerCase() + '=([^&#]*)').exec(window.location.href.toLowerCase());
	if (!results) { return 0; }
	return results[1] || 0;
}