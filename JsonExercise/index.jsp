<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="styles/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="knockout-2.0.0.js"></script>
    <script type="text/javascript" src="jqx-all.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var theme = '';
            
            // var DataGrid = jQuery('#theGrid');
            
            //sets the grid size initially
            //DataGrid.jqGrid('setGridWidth', parseInt($(window).width()) - 20);

            // get data.
            var url = "activitydata.txt";

            var dataSource =
            {
                datatype: "json",
                datafields: [
					{ name: 'ID' },
                    { name: 'Name' },
                    { name: 'Start_Date' },
                    { name: 'Finish_Date' },
                    { name: 'Duration' },
                    { name: 'Status' },
                    { name: 'Predecessors' },
                    { name: 'Successors' },
                ],
                id: 'ID',
                url: url
            };

            var dataAdapter = new $.jqx.dataAdapter(dataSource, { autoBind: true, async: false });
            
            var getLocalization = function () {
                var localizationobj = {};
                localizationobj.pagergotopagestring = "Gehe zu:";
                localizationobj.pagershowrowsstring = "Zeige Zeile:";
                localizationobj.pagerrangestring = " von ";
                localizationobj.pagernextbuttonstring = "voriger";
                localizationobj.pagerpreviousbuttonstring = "nächster";
                localizationobj.sortascendingstring = "Sortiere aufsteigend";
                localizationobj.sortdescendingstring = "Sortiere absteigend";
                localizationobj.sortremovestring = "Entferne Sortierung";
                localizationobj.firstDay = 1;
                localizationobj.percentsymbol = "%";
                localizationobj.decimalseparator = ".";
                localizationobj.thousandsseparator = ",";
                localizationobj.emptydatastring = "keine Daten angezeigt";
                return localizationobj;
            }

            // create model.
            var GridModel = function (items) {
                this.items = ko.observableArray(items);

                this.addItem = function () {
                    // add a new item.
                    this.items.push({ 
                    	ID: 100,
                    	Name: "Test activity name", 
                    	Start_Date: "Sun 01/06/08",
                    	Finish_Date: "Sun 01/06/08",
                    	Duration: "0 days", 
                    	Status: "Late", 
                    	Predecessors: "20",
                    	Successors: "33,34,35"
                    	});
                };

                this.removeItem = function () {
                    // remove the last item.
                    this.items.pop();
                };
            };

            // activate knockout.
            var model = new GridModel(dataAdapter.records);
            ko.applyBindings(model);

            // bind grid to the knockout's observable array.
            var source = {
                localdata: model.items,
                datatype: 'local'
            }

            //handles the grid resize on window resize
            //$(window).resize(function () { DataGrid.jqGrid('setGridWidth', parseInt($(window).width()) - 20); });
            
            $('#addButton').jqxButton({ theme: theme });
            $('#removeButton').jqxButton({ theme: theme });
            $("#Cancel").jqxButton({ theme: theme });
            $("#Save").jqxButton({ theme: theme });

            // create or initialize jqxGrid.
            $("#jqxgrid").jqxGrid(
            {
                source: source,
                autoheight: true,
                width: 800,
                selectionmode: 'singlerow',
                altrows: true,
                theme: theme,
                pageable: true,
                localization: getLocalization(),
                columns: [
				  { text: 'ID', datafield: 'ID', width: 30 },
                  { text: 'Name', datafield: 'Name', width: 250 },
                  { text: 'Start_Date', datafield: 'Start_Date', width: 110, 
                	  validation: function (cell, value) {
                          var year = value.getFullYear();
                          if (year >= 2013) {
                              return { result: false, message: "Start Date should be before 1/1/2014" };
                          }
                          return true;
                      }
                  },
                  { text: 'Finish_Date', datafield: 'Finish_Date', width: 110 },
                  { text: 'Duration', datafield: 'Duration', width: 60 },
                  { text: 'Status', datafield: 'Status', width: 50 },
                  { text: 'Predecessors', datafield: 'Predecessors', width: 100 },
                  { text: 'Successors', datafield: 'Successors', minwidth: 80 }
               ]/*,
               onSelectRow: function(id){
            	   alert('Inside onSelectRow' + id);
                   //var rowData = jQuery(this).getRowData(id); 
                   //var temp= rowData['Name'];//replace name with you column
 					//alert(temp);
                   }*/
            });
            
            /*$("#jqxgrid").jqxGrid('setGridParam', 
            		{ondblClickRow: function(rowid,iRow,iCol,e){
            			alert('double clicked');}});*/
            			
            var editrow = -1;            			
            $('#jqxgrid').bind('rowselect', function(event)  {
            	
            	  var current_index = event.args.rowindex;
            	  editrow = current_index;
            	  var datarow = $('#jqxgrid').jqxGrid('getrowdata', current_index);

            	  // Use datarow for display of data in div outside of grid
            	  //alert('Row selected: ' + datarow['ID']);
            	  
            	  $("#ID").val(datarow['ID']);
                  $("#Name").val(datarow.Name);
                  $("#Start_Date").val(datarow.Start_Date);
                  $("#Finish_Date").val(datarow.Finish_Date);
                  $("#Duration").val(datarow.Duration);
                  $("#Status").val(datarow.Status);
                  $("#Predecessors").val(datarow.Predecessors);
                  $("#Successors").val(datarow.Successors);
            	});
            			
          /*  $("#ID").keyup(function() {
                alert('Text1 changed!');
            });
            
            $("#Name").keyup(function() {
                alert('Text2 changed!');
            });*/
            
            //$('#Save').prop('disabled',true);
            document.getElementById('Save').disabled=true;
            $('#Cancel').attr('disabled', 'disabled');
            
         	// update the edited row when the user clicks the 'Save' button.
            $("#Save").click(function () {
                if (editrow >= 0) {
                    var row = { ID: $("#ID").val(), Name: $("#Name").val(), Start_Date: $("#Start_Date").val(),
                    	Finish_Date: $("#Finish_Date").val(), Duration: $("#Duration").val(),
                    	Status: $("#Status").val(), Predecessors: $("#Predecessors").val(),
                    	Successors: $("#Successors").val()
                    };
                    var rowID = $('#jqxgrid').jqxGrid('getrowid', editrow);
                    var datarow = $('#jqxgrid').jqxGrid('getrowdata', editrow);
                    $.get('ActionServlet',{
                    	actid:$("#ID").val(), 
                    	actname:$("#Name").val(),
                    	actstartdate:$("#Start_Date").val(),
                    	actfinishdate:$("#Finish_Date").val(),
                    	actduration:$("#Duration").val(),
                    	actstatus:$("#Status").val(),
                    	actpredecessors:$("#Predecessors").val(),
                    	actsuccessors:$("#Successors").val()
                    	},function(responseText) { 
                        alert(responseText);         
                    });
                    $('#jqxgrid').jqxGrid('updaterow', rowID, row);
                    document.getElementById('Save').disabled=true;
                    document.getElementById('Cancel').disabled=true;
                }
            });
         	
            $("#Cancel").click(function () {
                if (editrow >= 0) {
                	var datarow = $('#jqxgrid').jqxGrid('getrowdata', editrow);

              	  	// Use datarow for display of data in div outside of grid              	  
              	  	$("#ID").val(datarow['ID']);
                    $("#Name").val(datarow.Name);
                    $("#Start_Date").val(datarow.Start_Date);
                    $("#Finish_Date").val(datarow.Finish_Date);
                    $("#Duration").val(datarow.Duration);
                    $("#Status").val(datarow.Status);
                    $("#Predecessors").val(datarow.Predecessors);
                    $("#Successors").val(datarow.Successors);
                    document.getElementById('Save').disabled=true;
                    document.getElementById('Cancel').disabled=true;
                }
            });
            
            $('#activityForm').jqxValidator({
                rules: [
                       { input: '#Name', message: 'Activity name must be present!', action: 'keyup', rule: 'length=1,100' },
                       { input: '#Predecessors', message: 'Predecessors must be an integer and greater than zero!', action: 'keyup, focus', rule: function (input) {
                           if (input.val() == "" || input.val() > 0) {
                               return true;
                           }
                           return false;
                       }
                       }], theme: 'classic'
               });
        });
    </script>
</head>
<body class='default'>
	<fmt:setLocale value="en_US"/>
	
	<fmt:bundle basename="global">

    <div style="margin-bottom: 10px;">
        <input id="addButton" type="button" data-bind="click: addItem" value="Add Item"/>
        <input id="removeButton" type="button" data-bind="click: removeItem" value="Remove Item"/>
    </div>
    <div id="jqxgrid">
    </div>
    
    <div style="margin-top: 10px;" id="bottomdiv">
    	<form id="activityForm" action="./">
    	<table>
            <tr>
                <td align="right"><fmt:message key="ID"/>:</td>
                <td align="left"><input id="ID" readonly="readonly" /></td>
            </tr>
            <tr>
                <td align="right"><fmt:message key="Name"/>:</td>
                <td align="left"><input id="Name" style="width:250px" /></td>
            </tr>
            <tr>
                <td align="right">Start_Date:</td>
                <td align="left"><input id="Start_Date" /></td>
            </tr>
            <tr>
                <td align="right">Finish_Date:</td>
                <td align="left"><input id="Finish_Date" /></td>
            </tr>
            <tr>
                <td align="right">Duration:</td>
                <td align="left"><input id="Duration" /></td>
            </tr>
            <tr>
                <td align="right">Status:</td>
                <td align="left"><input id="Status" /></td>
            </tr>
            <tr>
                <td align="right">Predecessors:</td>
                <td align="left"><input id="Predecessors" /></td>
            </tr>
            <tr>
                <td align="right">Successors:</td>
                <td align="left"><input id="Successors" /></td>
            </tr>
            <tr>
                <td align="right"></td>
                <td style="padding-top: 10px;" align="right"><input style="margin-right: 5px;" type="button" id="Save" value="Save" /><input id="Cancel" type="button" value="Cancel"/></td>
            </tr>
        </table>
        </form>
    </div>
    </fmt:bundle>
</body>
</html>