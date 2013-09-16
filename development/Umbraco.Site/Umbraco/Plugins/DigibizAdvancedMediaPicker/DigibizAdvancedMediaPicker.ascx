<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DigibizAdvancedMediaPicker.ascx.cs" Inherits="DigibizAdvancedMediaPicker.DigibizAdvancedMediaPicker" %>
<%@ Register TagPrefix="umb" Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" %>
<%@ Import Namespace="umbraco.IO" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="DigibizTree" %>

<umb:CssInclude ID="CssIncludeDamp" runat="server" FilePath="plugins/DigibizAdvancedMediaPicker/DampStyles.css" PathNameAlias="UmbracoRoot" />
<umb:JsInclude ID="JsIncludeDamp" runat="server" FilePath="plugins/DigibizAdvancedMediaPicker/DAMPScript.js" PathNameAlias="UmbracoRoot" />

<script type="text/javascript">

    $(document).ready(function() {
        LoadDamp('<%=this.ClientID%>', '<%=HiddenFieldIds.ClientID%>', '<%=SelectMultipleNodesValue.ToString().ToLower()%>');
    });

    function GetSelect_<%=this.ClientID%>(nodeIds) {
        if(nodeIds.outVal){
            GetSelectDamp('<%=this.ClientID%>', '<%=HiddenFieldIds.ClientID%>', '<%=SelectMultipleNodesValue.ToString().ToLower()%>', '<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>', nodeIds, '<%=PreviewHeight.ToString()%>', '<%=PreviewWidth.ToString()%>', '<%=CropPropertyAliasValue%>', '<%=CropNameValue%>', '<%=DigibizConstants.IMAGETYPES%>', '<%=HideEditValue.ToString().ToLower()%>', '<%=HideOpenValue.ToString().ToLower()%>', '<%=HidePixlrValue.ToString().ToLower()%>', '<%=UseCropUpValue.ToString().ToLower()%>', '<%=CropUpAliasValue.ToString()%>', 'UpdateSelect_<%=this.ClientID%>');
        }
    }

    function UpdateSelect_<%=this.ClientID%>(nodeId) {
        if(nodeId.outVal){
            UpdateSelectDamp('<%=this.ClientID%>', '<%=HiddenFieldIds.ClientID%>', '<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>', nodeId, '<%=PreviewHeight.ToString()%>', '<%=PreviewWidth.ToString()%>', '<%=CropPropertyAliasValue%>', '<%=CropNameValue%>', '<%=DigibizConstants.IMAGETYPES%>', '<%=HideEditValue.ToString().ToLower()%>', '<%=HideOpenValue.ToString().ToLower()%>', '<%=HidePixlrValue.ToString().ToLower()%>', '<%=UseCropUpValue.ToString().ToLower()%>', '<%=CropUpAliasValue.ToString()%>', 'UpdateSelect_<%=this.ClientID%>');
        }
    }
    
</script>

<%--Show mandatory and error messages in this literal.--%>
<asp:Literal ID="LitError" runat="server" Visible="false"></asp:Literal>

<%--Choose and create buttons.--%>
<div style="margin-bottom: 20px;">
    <div style="display:inline;">
        <a href="javascript:UmbClientMgr.openModalWindow('<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>/plugins/DigibizAdvancedMediaPicker/SelectMediaItem.aspx?startNodeId=<%=StartNodeIdValue%>&allowedExtensions=<%=AllowedExtensionsValue%>&allowedMediaTypes=<%=AllowedSelectableMediaTypesValue%>&selectMultipleNodes=<%=SelectMultipleNodesValue.ToString()%>&cropPropertyAlias=<%=CropPropertyAliasValue %>&cropName=<%=CropNameValue %>&width=<%=SelectWidth%>&height=<%=SelectHeight%>&useCropUp=<%=UseCropUpValue%>&cropUpAlias=<%=CropUpAliasValue%>&searchEnabled=<%=EnableSearch %>&autoSuggestEnabled=<%=EnableSearchAutoSuggest %>&searchMethod=<%=SearchMethod %>', 'Select media item', true, 785, 620,0,0,'', GetSelect_<%=this.ClientID%>);">Choose...</a>
    </div>
    <asp:Panel ID="pnlCreateButton" runat="server" style="display:inline;margin-left:10px;">
        <a href="javascript:UmbClientMgr.openModalWindow('<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>/plugins/DigibizAdvancedMediaPicker/CreateMediaItem.aspx?startNodeId=<%=StartNodeIdValue%>&allowedExtensions=<%=AllowedExtensionsValue%>&allowedMediaTypes=<%=AllowedCreateableMediaTypesValue %>&allowedSelectableMediaTypes=<%=AllowedSelectableMediaTypesValue%>&defaultMediaType=<%=DefaultMediaTypeValue%>&cropPropertyAlias=<%=CropPropertyAliasValue %>&cropName=<%=CropNameValue%>&width=<%=SelectWidth%>&height=<%=SelectHeight%>&useCropUp=<%=UseCropUpValue%>&cropUpAlias=<%=CropUpAliasValue%>', 'Create media item', true, 330, 600,0,0,'', GetSelect_<%=this.ClientID%>);">Create...</a>
    </asp:Panel>
</div>

<%--Table with selected media items.--%>
<asp:Panel runat="server" ID="pnlDampMediaItems">
<div class="propertypane" id="wrapper_<%=this.ClientID %>">
<table id="sortTable_<%=this.ClientID%>" cellspacing="0" cellpadding="2" class="damp-table">
    <tbody>
        <asp:ListView ID="ListViewMediaItem" runat="server" OnItemDataBound="ListViewMediaItem_ItemDataBound">
            <LayoutTemplate>
                <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
            </LayoutTemplate>
            <ItemTemplate>
                <tr sort="<%# Eval("MediaId")%>">
                    <td class="firstCell">
                        <asp:Literal ID="ltlImagePreview" runat="server"></asp:Literal>
                    </td>
                    <td style="min-width: 150px;" class="innerCell"><a href="<%# Eval("MediaLink")%>" class="medialink_<%=this.ClientID%>" target="<%# Eval("MediaLink").ToString() != "#" ? "_blank" : "_self" %>"><%# Eval("MediaName")%></a></td>
                    <td style="min-width: 60px;" class="innerCell"><a href="#" onclick="javascript:mediaPopupDamp('<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>', '<%# Eval("MediaId") %>', 'UpdateSelect_<%=this.ClientID%>');" style='display: <%# (!HideEditValue ? "block" : "none") %>;'>Edit</a></td>
                    <td style="min-width: 60px;" class="innerCell"><a href="<%# string.Concat("javascript:if(confirm('Are you sure you want to navigate away from this page?\\n\\nYou may have unsaved changes.\\n\\nPress OK to continue or Cancel to stay on the current page.')){UmbClientMgr.mainWindow().delayedNavigate('", IOHelper.ResolveUrl(SystemDirectories.Umbraco), "/editmedia.aspx?id=", Eval("MediaId"), "', 'media')}") %>" style='display: <%# (!HideOpenValue ? "block" : "none") %>;'>Open</a></td>
                    <td style="min-width: 60px;" class="innerCell"><a href="#" style='display: <%# (!HidePixlrValue && !string.IsNullOrEmpty(Eval("MediaLink").ToString()) && Eval("MediaLink").ToString() != "#" && DigibizConstants.IMAGETYPES.Contains(Path.GetExtension(Eval("MediaLink").ToString().ToLower()).Substring(1))) ? "block" : "none" %>;' onclick="javascript:pixlrPopupDamp('<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>', '<%# Eval("MediaId") %>', 'UpdateSelect_<%=this.ClientID%>');">Pixlr</a></td>
                    <td style="min-width: 60px;" class="lastCell"><a href="#" class="delete_<%=this.ClientID%>" style="color:Red;">Remove</a></td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </tbody>
</table>
</div>
</asp:Panel>

<%--Store the id's of the selected media items in the correct order.--%>
<asp:HiddenField ID="HiddenFieldIds" runat="server" />
