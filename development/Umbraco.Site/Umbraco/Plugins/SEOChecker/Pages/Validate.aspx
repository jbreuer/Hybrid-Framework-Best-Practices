<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Validate.aspx.cs" Inherits="SEOChecker.Pages.Validate"     MasterPageFile="/umbraco/masterpages/umbracoPage.Master"%>
<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<%@ Register TagPrefix="SEOControls" TagName="ValidationPicker" Src="../Usercontrols/ValidationPicker.ascx" %>
<%@ Register TagPrefix="SEOChecker" Namespace="SEOChecker.Core.Controls" Assembly="SEOChecker.Core" %>
<%@ Import Namespace="SEOChecker.Resources" %>
<%@ Import Namespace="SEOChecker.Core.Repository.Queue" %>
<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../css/SEOChecker.css" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" runat="server">
        <SEOChecker:SEOCheckerPanel ID="SEOCheckerPanel" runat="server" />
        <SEOControls:ValidationPicker ID="ValidationPickerControl" runat="server"/>
        <umbraco:Pane ID="StartPane" runat="server">
            <umbraco:PropertyPanel ID="StartPanel" runat="server">
                <asp:button ID="StartButton" runat="server" OnClick="StartButton_Click" />
            </umbraco:PropertyPanel>
            </umbraco:Pane>
    </umbraco:UmbracoPanel>
</asp:Content>