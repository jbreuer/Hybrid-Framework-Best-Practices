<%@ Page Language="c#" MasterPageFile="../../masterpages/umbracoDialog.Master" Title="Select media item" CodeBehind="SelectMediaItem.aspx.cs" Inherits="DigibizAdvancedMediaPicker.SelectMediaItem" AutoEventWireup="True"%>
<%@ Register TagPrefix="umb" Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.controls" Assembly="umbraco" %>
<%@ Import Namespace="umbraco.IO" %>

<asp:Content ID="ContentPage" ContentPlaceHolderID="body" runat="server">

    <umb:JsInclude ID="JsIncludeDamp" runat="server" FilePath="plugins/DigibizAdvancedMediaPicker/DAMPScript.js" PathNameAlias="UmbracoRoot" />

    <script type="text/javascript">
        function GetNodeIds() {
            GetNodeIdsDamp('<%=digibizPickerView.PickedValue.ClientID%>');
        }

        function AddToSelected(a, link, selectMultipleNodes) {
            AddToSelectedDamp(a, link, selectMultipleNodes, '<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>', '<%=digibizPickerView.PickedValue.ClientID%>');
        }

        $(document).ready(function () {
            //IE fix to allow entering search details
            $("input[type='text']").focus();
            $("input[type='text']").blur();
        });
    </script>

    <%--Media tree.--%>
    <UmbracoControls:Pane ID="PaneName" runat="server">
        <asp:PlaceHolder ID="PlaceholderPicker" runat="server"></asp:PlaceHolder>
    </UmbracoControls:Pane>

    <!--<br />-->
    <p>
        <input type="button" onclick="javascript:GetNodeIds(); return false;" value="Select" />
        <em> or </em><a href="#" style="color: blue" onclick="UmbClientMgr.closeModalWindow()"><%=umbraco.ui.Text("general", "cancel", this.getUser())%></a>  
    </p>
</asp:Content>