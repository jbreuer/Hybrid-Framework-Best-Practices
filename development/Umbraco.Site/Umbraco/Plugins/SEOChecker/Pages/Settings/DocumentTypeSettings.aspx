<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DocumentTypeSettings.aspx.cs"
    MasterPageFile="/umbraco/masterpages/umbracoPage.Master" Inherits="SEOChecker.Pages.Settings.DocumentTypeSettings" %>

<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<%@ Register TagPrefix="SEOChecker" Namespace="SEOChecker.Core.Controls" Assembly="SEOChecker.Core" %>
<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../../css/SEOChecker.css" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" runat="server">
        <SEOChecker:SEOCheckerPanel ID="SEOCheckerPanel" runat="server" />
        <umbraco:Feedback ID="SEOCheckerDatatypeFeedback" runat="server" type="notice" />
        <h2><asp:literal ID="TemplatePaneLiteral" runat="server" /></h2>
        <umbraco:Pane ID="TemplatePane" runat="server">
            <umbraco:PropertyPanel ID="TitlePanel" runat="server">
                <asp:DropDownList ID="TitlePropertyDropdownlist" runat="server" CssClass="SEOCheckerDropdown">
                </asp:DropDownList>
            </umbraco:PropertyPanel>
            <umbraco:PropertyPanel ID="DescriptionPanel" runat="server">
                <asp:DropDownList ID="DescriptionPropertyDropdownlist" runat="server" CssClass="SEOCheckerDropdown">
                </asp:DropDownList>
            </umbraco:PropertyPanel>
            <umbraco:PropertyPanel ID="TitleTemplatePanel" runat="server">
                <asp:TextBox ID="TitleTemplateTextBox" CssClass="umbEditorTextField" runat="server"> </asp:TextBox>
            </umbraco:PropertyPanel>
        </umbraco:Pane>
        <h2>Robot settings</h2>
        <umbraco:Pane ID="RobotSettingsPane" runat="server">
            <umbraco:PropertyPanel ID="RobotIndexProperty" runat="server">
                <asp:DropDownList ID="RobotIndexDropdown" runat="server" CssClass="SEOCheckerDropdown">
                </asp:DropDownList>
            </umbraco:PropertyPanel>
            <umbraco:PropertyPanel ID="RobotFollowProperty" runat="server">
                <asp:DropDownList ID="RobotFollowDropdown" CssClass="SEOCheckerDropdown" runat="server">
                </asp:DropDownList>
            </umbraco:PropertyPanel>
        </umbraco:Pane>
        <asp:PlaceHolder runat="server" ID="XmlSiteMapPlaceholder">
        <h2>Xml Sitemap settings</h2>
        <umbraco:Pane ID="ExcludeXmlSitemapPane" runat="server">
            <umbraco:PropertyPanel ID="ExcludeXmlSitemapProperty" runat="server">
                <asp:CheckBox ID="ExcludeXmlSitemapCheckBox" runat="server" />
            </umbraco:PropertyPanel>
            <umbraco:PropertyPanel ID="SitemapPrioProperty" runat="server">
                <asp:DropDownList ID="SitemapPrioDropdown" CssClass="SEOCheckerDropdown" runat="server" />
            </umbraco:PropertyPanel>
             <umbraco:PropertyPanel ID="ChangeFreqPanel" runat="server">
                <asp:DropDownList ID="ChangeFreqDropdownlist" CssClass="SEOCheckerDropdown" runat="server" />
            </umbraco:PropertyPanel>
        </umbraco:Pane>
            </asp:PlaceHolder> 
    </umbraco:UmbracoPanel>
</asp:Content>
