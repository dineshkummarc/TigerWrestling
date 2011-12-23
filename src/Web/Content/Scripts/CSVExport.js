/*
Usage: (typically added inside to_table() method)

function to_table(obj) {
	cachedJSON = obj; //caches json collection on page load
	...
}

//Click event to call function that exports the existing table records only.
$(".exportViewButton").click(function () {
	JSON2CSV(cachedJSON);
});

//Click event to call function that exports all possible records from db.
$(".exportAllButton").click(function () {
	//modify params sent via PushGrid(), call ajax, slap json into cache again and then call 
	JSON2CSV(cachedJSON);
});
*/

var cachedJSON = '{ }';

//Neat, but gives me no headers/field names, no customization of fields (no date conversion), and is rather awkward. Heavily tweaked!
//http: //stackoverflow.com/questions/921037/jquery-table-to-csv-export
function JSON2CSV(objArray, showTrackingFields) {
	//var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
	var array = typeof objArray != 'object' ? $.parseJSON(objArray) : objArray;

	var str = '';
	var line = '';

	//Add header row from field names
	for (var key in array[0]) {
		//alert('name=' + key + ' value=' + array[0][key]);

		if (showTrackingFields == undefined || !showTrackingFields) {
			//if (key == "ModifiedDate"
			if (key in { ModifiedDate:1, ModifiedBy:1, CreatedDate:1, CreatedBy:1 })
				continue;
		}

		//Split camel-casing into separate words
		key = key.replace(/((?![A-Z])[A-Z]|[A-Z](?![A-Z]))/g, ' $1');
		//key = key.replace(/([a-z])([A-Z])/g, '$1 $2'); //doesn't work with all-cap words

		line += key + ',';
	}

	//Remove trailing comma and add linefeed
	line.slice(0, line.Length - 1);
	str += line + '\r\n';

	for (var i = 0; i < array.length; i++) {
		line = '';

		//Add one row per JSON record
		for (var key in array[i]) {
			//alert('name=' + key + ' value=' + array[0][key]);
			if (showTrackingFields == undefined || !showTrackingFields) {
				if (key in { ModifiedDate: 1, ModifiedBy: 1, CreatedDate: 1, CreatedBy: 1 })
					continue;
			}

			var value = array[i][key];

			//JSON string date hack
			if (typeof value == "string" && value.substr(0, 5) == "/Date") {
				var parseDate = new Date(parseInt(value.substr(6)));
				try {
					value = parseDate.format("mm/dd/yy hh:MM TT"); //alert(value);
				}
				catch (err) { value = parseDate.toString(); } //handled errors gracefully in case date.Format library not installed
			}

			line += value + ',';
		}

		//Remove trailing comma and add linefeed
		line.slice(0, line.Length - 1);
		str += line + '\r\n';
	} //alert(str);

	//See better solution below, using ashx handler
	//window.open("data:text/csv;charset=utf-8," + escape(str), "excelWindow");
	//window.location = 'data:text/csv;charset=utf8,' + encodeURIComponent(str);
	//chrome: data:text/csv;base64,charset=utf-8

	//Requires simple CsvExport.ashx file.
	//$("body").append('<form id="exportform" action="../../Public/CsvExport.ashx" method="post" target="_blank"><input type="hidden" id="exportdata" name="exportdata" /></form>');
	$("body").append('<form id="exportform" action="../CsvExport.ashx" method="post" target="_blank"><input type="hidden" id="exportdata" name="exportdata" /></form>');
	$("#exportdata").val(str);
	$("#exportform").submit().remove();

	return true;
}