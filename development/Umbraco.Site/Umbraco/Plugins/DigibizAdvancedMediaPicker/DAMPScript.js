//******************************* DigibizAdvancedMediaPicker.ascx *******************************


var iframe = UmbClientMgr.mainWindow().jQuery("#deepLinkScriptFrame");
if (iframe.length == 0) {
    var html = "<html><head><script type='text/javascript'>"
                + "this.window.top.delayedNavigate = function(url, app) { "
                + "  if (UmbClientMgr.historyManager().getCurrent() == app) {"
                + "    UmbClientMgr.contentFrame(url);"
                + "  }"
                + "  else {"
                + "    var origContentFrameFunc = UmbClientMgr.contentFrame;"
                + "    var newContentFrameFunc = function (location) {"
                + "       UmbClientMgr.contentFrame = origContentFrameFunc;"
                + "       origContentFrameFunc.call(this, url);"
                + "    };"
                + "    UmbClientMgr.contentFrame = newContentFrameFunc;"
                + "    UmbClientMgr.mainTree()._loadedApps['tree_' + app] = null;"
                + "    UmbClientMgr.mainTree().setActiveTreeType(app);"
                + "    UmbClientMgr.mainWindow().location.hash = '#' + app   ; "
                + "  }"
                + "};"
                + "</script></head><body></body></html>";
    iframe = UmbClientMgr.mainWindow().jQuery("<iframe id='deepLinkScriptFrame'>")
                .append(html)
                .hide()
                .css("width", "0px")
                .css("height", "0px");
    UmbClientMgr.mainWindow().jQuery("body").append(iframe);
}

function LoadDamp(clientId, hiddenFieldId, selectMulti) {

    //Store the current sort order in the hiddenfield value.
    StoreSortDamp(clientId, hiddenFieldId);

    //Delete the media item if the delete link is clicked.
    DeleteMediaClickDamp(clientId, hiddenFieldId);

    //Remove empty links.
    RemoveEmptyLinksDamp(clientId);

    //If multiple nodes are allowed enable sorting.
    if (selectMulti == "true") {

        //Register the table drag n drop via sortable
        $("#sortTable_" + clientId + " tbody").sortable({
            update: function (event, ui) {
                StoreSortDamp(clientId, hiddenFieldId);
            },
            cursor: 'move',
            placeholder: "drop-placeholder-row",
            disabled: $("#sortTable_" + clientId + " tr").length >= 2 ? false : true,
            sort: function (event, ui) {
                // This adds some empty content to the "placeholder" for dropping.  Needed to enforce background color (cant apply on empty TR).  Can get rid of this if we refactor to UL/LI's. Also enforces height to ThumbnailHeight prevalue.
                $('#sortTable_' + clientId + ' tr.drop-placeholder-row').html("<td class='firstCell' style='height:75px'>&nbsp;</td><td class='innerCell'>&nbsp;</td><td class='innerCell'>&nbsp;</td><td class='innerCell'>&nbsp;</td><td class='innerCell'>&nbsp;</td><td class='lastCell'>&nbsp;</td>");
            }
        });

        //Turns D&D off/on if < 2 items.  NOTE: Also handling above, but need to call it again to reset the CSS class on postback.  Needs to be above also otherwise "disabled" gets overridden on pageload.
        ToggleDragDropDamp(clientId);

    }
        
    //Hides the table's wrapper if no items selected for better appearance
    ToggleTableVisibilityDamp(clientId);
}

//This method updates the table and adds the selected media item.
function GetSelectDamp(clientId, hiddenFieldId, selectMulti, umbPath, nodeIds, thumbHeight, thumbWidth, cropPropertyAliasValue, cropNameValue, imageTypes, hideEdit, hideOpen, hidePixlr, useCropUp, cropUpAlias, updateSelect) {

    var ids = nodeIds.outVal.split(',');

    for (id in ids) {

        if (isIntDamp(ids[id])) {

            //Get the id of the media item.
            var mediaId = parseInt(ids[id]);

            //Do a ajax call to get all the required media data.
            //Make sure async is false because all the media items need to be added before we call the other methods.
            $.ajax({
                type: "POST",
                async: false,
                url: umbPath + "/plugins/DigibizAdvancedMediaPicker/DigibizService.asmx/GetEditorData",
                data: '{ "nodeId": ' + mediaId + ', "cropPropertyAlias": "' + cropPropertyAliasValue + '", "cropName": "' + cropNameValue + '", "thumbWidth": ' + thumbWidth + ', "thumbHeight": ' + thumbHeight + ', "useCropUp": "' + useCropUp + '", "cropUpAlias": "' + cropUpAlias + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {

                    //Get all the values from the ajax call.
                    var mediaIcon = msg.d.mediaIcon;
                    var mediaLink = msg.d.mediaLink;
                    var mediaName = msg.d.mediaName;
                    var mediaCrop = msg.d.mediaCrop;
                    var mediaImageTag = msg.d.mediaImageTag;

                    var ext = mediaLink.substr(mediaLink.lastIndexOf(".") + 1).toLowerCase();

                    if (selectMulti == "false") {

                        //If it's not allowed to selecte multiple media items remove all currently selected media items.
                        $('#sortTable_' + clientId).find("tr").remove();

                    }

                    //Add the extra row to the table with all the required data.
                    $('#sortTable_' + clientId + ' > tbody:last').append('<tr sort="' + mediaId + '"></tr>');
                    $('#sortTable_' + clientId + ' tr:last').append('<td class="firstCell">' + mediaImageTag + '</td>');
                    $('#sortTable_' + clientId + ' tr:last').append('<td style="min-width: 150px;" class="innerCell"><a href="' + mediaLink + '" class="medialink_<%=this.ClientID%>" target="' + (mediaLink != '#' ? '_blank' : '_self') + '">' + mediaName + '</a></td>');

                    //Show the edit button if it's allowed.
                    if (hideEdit == "false") {
                        $('#sortTable_' + clientId + ' tr:last').append('<td style="min-width: 60px;" class="innerCell"><a href="#" onclick="javascript:mediaPopupDamp(\'' + umbPath + '\', \'' + mediaId + '\', \'' + updateSelect + '\');">Edit</a></td>')
                    }
                    else {
                        $('#sortTable_' + clientId + ' tr:last').append('<td style="min-width: 60px;" class="innerCell">&nbsp;</td>')
                    }

                    //Show the open button if it's allowed.
                    if (hideOpen == "false") {
                        $('#sortTable_' + clientId + ' tr:last').append('<td style="min-width: 60px;" class="innerCell"><a href="javascript:if(confirm(\'Are you sure you want to navigate away from this page?\\n\\nYou may have unsaved changes.\\n\\nPress OK to continue or Cancel to stay on the current page.\')){UmbClientMgr.mainWindow().delayedNavigate(\'' + umbPath + '\' + \'/editmedia.aspx?id=' + mediaId + '\', \'media\')};">Open</a></td>');
                    }
                    else {
                        $('#sortTable_' + clientId + ' tr:last').append('<td style="min-width: 60px;" class="innerCell">&nbsp;</td>');
                    }

                    //Show the pixlr button if it's allowed.
                    if (hidePixlr == "false" && !(imageTypes.indexOf("," + ext + ",") < 0)) {
                        $('#sortTable_' + clientId + ' tr:last').append('<td style="min-width: 60px;" class="innerCell"><a href="#" onclick="javascript:pixlrPopupDamp(\'' + umbPath + '\', \'' + mediaId + '\', \'' + updateSelect + '\');">Pixlr</a></td>')
                    }
                    else {
                        $('#sortTable_' + clientId + ' tr:last').append('<td style="min-width: 60px;" class="innerCell">&nbsp;</td>')
                    }

                    $('#sortTable_' + clientId + ' tr:last').append('<td style="min-width: 60px;" class="lastCell"><a href="#" class="delete_' + clientId + '" style="color:Red;">Remove</a></td>');
                }
            });
        }
    }

    //Store the current sort order again in the hiddenfield value because new media items have been added.
    StoreSortDamp(clientId, hiddenFieldId);

    //Delete the media item if the delete link is clicked. This needs to bind again after new media items have been added.
    DeleteMediaClickDamp(clientId, hiddenFieldId);

    //Remove all the empty links again after new media items have been added.
    RemoveEmptyLinksDamp(clientId);

    //Display the table wrapper if it's hidden.
    ToggleTableVisibilityDamp(clientId);

    //Toggle Drag & Drop Features if needed.
    ToggleDragDropDamp(clientId);
}

function UpdateSelectDamp(clientId, hiddenFieldId, umbPath, nodeId, thumbHeight, thumbWidth, cropPropertyAliasValue, cropNameValue, imageTypes, hideEdit, hideOpen, hidePixlr, useCropUp, cropUpAlias, updateSelect) {
    
    if (isIntDamp(nodeId.outVal)) {

        //Get the id of the media item.
        var mediaId = parseInt(nodeId.outVal);

        //Do a ajax call to get all the required media data.
        $.ajax({
            type: "POST",
            url: umbPath + "/plugins/DigibizAdvancedMediaPicker/DigibizService.asmx/GetEditorData",
            data: '{ "nodeId": ' + mediaId + ', "cropPropertyAlias": "' + cropPropertyAliasValue + '", "cropName": "' + cropNameValue + '", "thumbWidth": ' + thumbWidth + ', "thumbHeight": ' + thumbHeight + ', "useCropUp": "' + useCropUp + '", "cropUpAlias": "' + cropUpAlias + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {

                //Get all the values from the ajax call.
                var mediaIcon = msg.d.mediaIcon;
                var mediaLink = msg.d.mediaLink;
                var mediaName = msg.d.mediaName;
                var mediaCrop = msg.d.mediaCrop;
                var mediaImageTag = msg.d.mediaImageTag;

                var ext = mediaLink.substr(mediaLink.lastIndexOf(".") + 1).toLowerCase();

                $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").html('');

                //Update the row with the new data.
                $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").append('<td class="firstCell">' + mediaImageTag + '</td>');
                $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").append('<td style="min-width: 150px;" class="innerCell"><a href="' + mediaLink + '" class="medialink_<%=this.ClientID%>" target="' + (mediaLink != '#' ? '_blank' : '_self') + '">' + mediaName + '</a></td>');

                //Show the edit button if it's allowed.
                if (hideEdit == "false") {
                    $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").append('<td style="min-width: 60px;" class="innerCell"><a href="#" onclick="javascript:mediaPopupDamp(\'' + umbPath + '\', \'' + mediaId + '\', \'' + updateSelect + '\');">Edit</a></td>');
                }
                else {
                    $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").append('<td style="min-width: 60px;" class="innerCell">&nbsp;</td>');
                }

                //Show the open button if it's allowed.
                if (hideOpen == "false") {
                    $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").append('<td style="min-width: 60px;" class="innerCell"><a href="javascript:if(confirm(\'Are you sure you want to navigate away from this page?\\n\\nYou may have unsaved changes.\\n\\nPress OK to continue or Cancel to stay on the current page.\')){UmbClientMgr.mainWindow().delayedNavigate(\'' + umbPath + '\' + \'/editmedia.aspx?id=' + mediaId + '\', \'media\')};">Open</a></td>');
                }
                else {
                    $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").append('<td style="min-width: 60px;" class="innerCell">&nbsp;</td>');
                }

                //Show the Pixlr button if it's allowed.
                if (hidePixlr == "false" && !(imageTypes.indexOf("," + ext + ",") < 0)) {
                    $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").append('<td style="min-width: 60px;" class="innerCell"><a href="#" onclick="javascript:pixlrPopupDamp(\'' + umbPath + '\', \'' + mediaId + '\', \'' + updateSelect + '\');">Pixlr</a></td>')
                }
                else {
                    $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").append('<td style="min-width: 60px;" class="innerCell">&nbsp;</td>')
                }

                $('#sortTable_' + clientId).find("tr[sort=" + mediaId + "]").append('<td style="min-width: 60px;" class="lastCell"><a href="#" class="delete_' + clientId + '" style="color:Red;">Remove</a></td>');

                //Store the current sort order again in the hiddenfield value because a new media item has been added.
                StoreSortDamp(clientId, hiddenFieldId);

                //Delete the media item if the delete link is clicked. This needs to bind again after a media item has been added.
                DeleteMediaClickDamp(clientId, hiddenFieldId);

                //Remove all the empty links again after a new media item has been added.
                RemoveEmptyLinksDamp(clientId);
            }
        });
    }
}

//Open a popup in which the media can be edited.
function mediaPopupDamp(umbPath, id, updateSelect) {
    UmbClientMgr.openModalWindow(umbPath + '/plugins/DigibizAdvancedMediaPicker/EditDamp.aspx?id=' + id, 'Edit media item', true, $(parent.window).width() - 140, $(parent.window).height() - 100, 0, 0, '', window[updateSelect]);
    return false;
}

//Open a popup in which the media can be edited with Pixlr.
function pixlrPopupDamp(umbPath, id, updateSelect) {
    UmbClientMgr.openModalWindow(umbPath + '/plugins/DigibizAdvancedMediaPicker/Pixlr.aspx?id=' + id, 'Pixlr', true, $(parent.window).width() - 140, $(parent.window).height() - 100, 0, 0, '', window[updateSelect]);
    return false;
}

//This methoth updates the sort order in the hiddenfield.
function StoreSortDamp(clientId, hiddenFieldId) {
    var rows = jQuery('#sortTable_' + clientId + ' tbody tr');
    var newOrder = "";
    jQuery.each(rows, function () {
        newOrder += jQuery(this).attr("sort") + ",";
    });
    var hiddenField = document.getElementById(hiddenFieldId);
    hiddenField.value = newOrder;
}

//Delete the media item if the delete link is clicked.
function DeleteMediaClickDamp(clientId, hiddenFieldId) {

    //Remove the old click event.
    $("#sortTable_"+clientId+" td a.delete_"+clientId+"").unbind('click');

    //Add the new click event.
    $("#sortTable_"+clientId+" td a.delete_"+clientId+"").click(function(){
        if(confirm("Are you sure you want to remove this media item?")){

            //Remove the tr element with the selected media item in it.
            $(this).parent().parent().remove();

            //Since a media item has been removed update the list of selected media items in the hidden value.
            StoreSortDamp(clientId, hiddenFieldId);

            // Check to see if no items left
            ToggleTableVisibilityDamp(clientId);

            //Toggle Drag & Drop Features if needed
            ToggleDragDropDamp(clientId);
        }
    });   
}
    
//Remove empty links. For example a folder has no link.
function RemoveEmptyLinksDamp(clientId){
    var links = $("#sortTable_"+clientId+" td a.medialink_"+clientId)

    jQuery.each(links, function () {
        var href = $(this).attr("href");
        if(href == '' || href == "#"){
            $(this).removeAttr("href");
        }
    });
}

//If no items selected, hides the table's propertypane wrapper for better appearance.  Shows again if items exist.
function ToggleTableVisibilityDamp(clientId) {
    var numRows = $("#sortTable_"+clientId+" tr").length;
    if (numRows == 0) 
    {
        $("#wrapper_"+clientId).css("display","none");
    }
    else {
        $("#wrapper_"+clientId).css("display","block");
    }
}

//Disables Drag & Drop features if 1 or less items selected.  Enables it if 2 or more items are selected.
function ToggleDragDropDamp(clientId) {
    var numRows = $("#sortTable_" + clientId + " tr").length;
    if (numRows >= 2) {
        $("#sortTable_" + clientId + " tbody").sortable("option", "disabled", false);
        $("#sortTable_" + clientId).addClass("sortable"); // Used for the cursor:move CSS style
    }
    else {
        $("#sortTable_" + clientId + " tbody").sortable("option", "disabled", true);
        $("#sortTable_" + clientId).removeClass("sortable"); // Used for the cursor:move CSS style
    }
}

//This method check if a value is an int.
function isIntDamp(x) {
    var y = parseInt(x);
    if (isNaN(y)) return false;
    return x == y && x.toString() == y.toString();
}


//******************************* SelectMediaItem.aspx *******************************


function GetNodeIdsDamp(hiddenId) {
    var hidden = document.getElementById(hiddenId);
    
    if (hidden.value == "") {
        alert("There are no media items selected.");
    }
    else {
        UmbClientMgr.closeModalWindow(hidden.value);
    }
}

function AddToSelectedDamp(a, link, selectMultipleNodes, umbPath, hiddenId) {
    var domA = $(a);
    var nodeid = domA.find('img').attr("nodeId");
    var right = $(".right");

    //Only add the item if it's not added yet.
    if (right.find('img.mediaItem[nodeId="' + nodeid + '"]').length == 0) {
        var html = '<div class="selected"><div class="picker" onclick="javascript:OpenLinkDamp(\'' + link + '\');">' + domA.html() + '</div>';
        html = html + '<div class="delete"><img src="' + umbPath + '/plugins/DigibizAdvancedMediaPicker/Delete.gif" onclick="javascript:RemoveSelectedDamp(this, \'' + hiddenId + '\');"></div></div>';

        if (selectMultipleNodes == 'false') {
            right.html("");
        }

        right.prepend(html);

        StoreIds(hiddenId);
    }
}

function RemoveSelectedDamp(img, hiddenId) {
    var domImg = $(img);

    //Remove the div which contains the media item.
    domImg.parent().parent().remove();

    //After an item is removed the id's need to be stored again.
    StoreIds(hiddenId);
}

//Open the link if it's not empty.
function OpenLinkDamp(link) {
    if (link != '' && link != '#') {
        window.open(link);
    }
}

//This method updates the ids order in the hiddenfield.
function StoreIds(hiddenId) {
    var rows = $('.right div img.mediaItem');
    var ids = "";
    jQuery.each(rows, function () {
        ids += jQuery(this).attr("nodeId") + ",";
    });
    var hidden = document.getElementById(hiddenId);
    hidden.value = ids;
}


//******************************* CreateMediaItem.aspx *******************************


function CheckFieldsDamp(ddlMediaTypesId, hiddenFieldHasUploadFileId, txtNameId, pickedValueId, umbPath, uploadFieldId, checkAllowedExtensions, allowedExtensions, allowedExtensionsFormatted, btnCreateId) {

    //Get all the values we need for checks.
    var errorMessage = '';
    var ddlMediaType = document.getElementById(ddlMediaTypesId);
    var selectedMediaTypeId = ddlMediaType.value;
    var selectedMediaTypeText = ddlMediaType.options[ddlMediaType.selectedIndex].text.toLowerCase();
    var hasUploadField = $(hiddenFieldHasUploadFileId).val();
    var txtName = $(txtNameId).val();
    var pickerValue = $(pickedValueId).val();

    //Check if a Media Type has been selected.
    if (selectedMediaTypeId == '-1') {
        errorMessage = "- You need to select a Media Type.\n";
    }

    //Check if a valid file has been selected if the upload field is displayed.
    if (hasUploadField == 'true') {
        var fileName = document.getElementById(uploadFieldId).value;
        var extension = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length).toLowerCase();

        //Check if a file has been selected.
        if (fileName.length == 0) {
            errorMessage = errorMessage + '- You need to select a file.\n';
        }
        //Check if the selected file has the allowed extension.
        else if (checkAllowedExtensions == 'true' && (allowedExtensions).indexOf(',' + extension + ',') < 0) {
            errorMessage = errorMessage + '- No valid file is selected. Only the following extensions are allowed: ' + allowedExtensionsFormatted + '.\n';
        }
    }

    //Check if a name has been entered.
    if (txtName.length == 0) {
        errorMessage = errorMessage + '- You need to enter a name.\n';
    }

    //Check if a folder has been selected.
    if (pickerValue.length == 0) {
        errorMessage = errorMessage + "- You need to select a parent.\n";
    }

    //If a media type and file are selected do an ajax call.
    if (selectedMediaTypeId != '-1' && pickerValue.length != 0) {

        //AJAX call to check if the Media Type the user wants to create is allowed under the selected parent media item.
        $.ajax({
            type: "POST",
            async: false,
            url: umbPath + "/plugins/DigibizAdvancedMediaPicker/DigibizService.asmx/CheckCreateData",
            data: '{ "nodeId": ' + parseInt(pickerValue) + ', "mediaTypeId": ' + parseInt(selectedMediaTypeId) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                errorMessage = errorMessage + msg.d.message;
            }
        });

    }

    //Display an error message if not all fields are valid.
    if (errorMessage != '') {
        alert(errorMessage);
        return false;
    }

    //Find the button and disable it so the user can't press the button again. 
    //After this do the postback manually because the button won't do it after it's disabled.
    var button = document.getElementById(btnCreateId);
    button.value = "Creating...";
    button.disabled = true;
    __doPostBack(button.name, '');

    return true;
}

function CheckMediaTypeDamp(ddl, hiddenFieldHasUploadFileId, umbPath) {

    //AJAX call to check if the selected Media Type has an upload field.
    $.ajax({
        type: "POST",
        async: false,
        url: umbPath + "/plugins/DigibizAdvancedMediaPicker/DigibizService.asmx/CheckCreateMediaType",
        data: '{ "selectedMediaTypeId": ' + parseInt(ddl.value) + ' }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            var hasUploadFile = msg.d.hasUploadFile;
            var propFileUpload = $('#propFileUpload');

            //If the Media Type has an upload field show it.
            if (hasUploadFile == 'true') {
                propFileUpload.show();
            }
            else {
                propFileUpload.hide();
            }

            //Store the value in a Hidden field which will be used in the CheckFields method and create postback.
            var hiddenFieldHasUploadFile = $(hiddenFieldHasUploadFileId);
            hiddenFieldHasUploadFile.val(hasUploadFile);
        }
    });
}

function SetFileNameDamp(uploadFieldId, txtNameId) {

    //Get the filename from the selected file and display it in the textbox.
    var path = document.getElementById(uploadFieldId).value;
    var fileName = path.substring(path.lastIndexOf("\\") + 1, path.length);
    var fileNameNoExtension = fileName.substring(0, fileName.lastIndexOf("."));
    $(txtNameId).val(fileNameNoExtension);
}