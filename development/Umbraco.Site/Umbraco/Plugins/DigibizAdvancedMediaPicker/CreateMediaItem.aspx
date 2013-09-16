<%@ Page Language="c#" MasterPageFile="../../masterpages/umbracoDialog.Master" Title="Select media item" AutoEventWireup="true" CodeBehind="CreateMediaItem.aspx.cs" Inherits="DigibizAdvancedMediaPicker.CreateMediaItem" %>
<%@ Register TagPrefix="umb" Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.controls" Assembly="umbraco" %>
<%@ Import namespace="DigibizTree" %>
<%@ Import Namespace="umbraco.IO" %>

<asp:Content ID="ContentPage" ContentPlaceHolderID="body" runat="server">

    <umb:JsInclude ID="JsIncludeDamp" runat="server" FilePath="plugins/DigibizAdvancedMediaPicker/DAMPScript.js" PathNameAlias="UmbracoRoot" />
    
    <script type="text/javascript">
        function CheckFields() {
            return CheckFieldsDamp('<%=DdlMediaTypes.ClientID%>', '#<%=HiddenFieldHasUploadFile.ClientID%>', '#<%=TxtName.ClientID%>', '#<%=digibizPickerView.PickedValue.ClientID%>', '<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>', '<%=UploadFieldClientId%>', '<%=RenderAllowedExtensionCheck.ToString().ToLower()%>', '<%=GetAllowedExtensions()%>', '<%=ShowExtensions(Request.QueryString["allowedExtensions"])%>', '<%=BtnCreate.ClientID%>');
        }

        function SetFileName() {
            SetFileNameDamp('<%=UploadFieldClientId%>', '#<%=TxtName.ClientID%>');
        }

        function CheckMediaType(ddl) {
            CheckMediaTypeDamp(ddl, '#<%=HiddenFieldHasUploadFile.ClientID%>', '<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>');
        }

        $(document).ready(function () {
            var ddl = document.getElementById('<%=DdlMediaTypes.ClientID%>');
            CheckMediaType(ddl);
        });

    </script>

    <asp:MultiView ID="MultiViewPage" runat="server" ActiveViewIndex="0">

        <%--Create view.--%>
        <asp:View ID="ViewCreate" runat="server">

            <UmbracoControls:Pane ID="PaneCreate" runat="server">
                        
                <%--Media type dropdown.--%>
                <UmbracoControls:PropertyPanel ID="PropMediaType" runat="server" Text="Media Type:">
                    <asp:DropDownList ID="DdlMediaTypes" runat="server" Width="200px" onchange="javascript:CheckMediaType(this);"></asp:DropDownList>
                </UmbracoControls:PropertyPanel>
                        
                <%--Fileupload.--%>
                <div id="propFileUpload">
                    <UmbracoControls:PropertyPanel ID="PropFile" runat="server" Text="Choose file:">
                        <asp:PlaceHolder ID="PlaceHolderUpload" runat="server"></asp:PlaceHolder>
                    </UmbracoControls:PropertyPanel>
                </div>

                <%--Hidden value to dertermine if an upload field is found.--%>
                <asp:HiddenField ID="HiddenFieldHasUploadFile" runat="server" />

                <%--Name.--%>
                <UmbracoControls:PropertyPanel ID="PropName" runat="server" Text="Name:">
                    <asp:TextBox ID="TxtName" runat="server" Width="195px"></asp:TextBox>
                </UmbracoControls:PropertyPanel>
                        
                <%--Media tree.--%>
                <UmbracoControls:PropertyPanel ID="PropFolder" runat="server" Text="Parent:">
                    <asp:PlaceHolder ID="PlaceholderPicker" runat="server"></asp:PlaceHolder>
                </UmbracoControls:PropertyPanel>

            </UmbracoControls:Pane>

            <br />
            <p>
                <asp:Button ID="BtnCreate" runat="server" OnClick="BtnCreate_Click" Text="Create" OnClientClick="return CheckFields();"/>
                <em> or </em><a href="#" style="color: blue" onclick="UmbClientMgr.closeModalWindow()"><%=umbraco.ui.Text("general", "cancel", this.getUser())%></a>  
            </p>
        </asp:View>

        <%--Succesfully created view.--%>
        <asp:View ID="ViewSucces" runat="server">
            
            <UmbracoControls:Pane ID="PaneSucces" runat="server">

                The new media item is created succesfully.

                <br />
                <br />
                
                <%--Display the name and media icon/image.--%>
                <asp:Literal ID="LitName" runat="server"></asp:Literal><br /><br />
                <asp:HyperLink ID="HplNewMediaItem" runat="server" Target="_blank">
                    <asp:Literal ID="ltlNewMediaImage" runat="server" />
                </asp:HyperLink>

                <br />
                <br />

                <asp:Label ID="LblMessage" runat="server"></asp:Label>

            </UmbracoControls:Pane>
            
            <br />
            <p>
                <asp:PlaceHolder ID="PlaceHolderSelect" runat="server">
                    <input type="button" onclick="javascript:GetNodeId(); return false;" value="Select" />
                    &nbsp;-&nbsp
                </asp:PlaceHolder>
                <asp:Button ID="BtnCreateAgain" runat="server" OnClick="BtnCreateAgain_Click" Text="Create"/>
                <em> or </em><a href="#" style="color: blue" onclick="UmbClientMgr.closeModalWindow()"><%=umbraco.ui.Text("general", "cancel", this.getUser())%></a>  
            </p>
        </asp:View>
    </asp:MultiView>
</asp:Content>