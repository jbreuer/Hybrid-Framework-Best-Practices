<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Config.aspx.cs" MasterPageFile="/umbraco/masterpages/umbracoPage.Master" Inherits="SEOChecker.Pages.Settings.Config" %>

<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<%@ Register TagPrefix="SEOChecker" Namespace="SEOChecker.Core.Controls" Assembly="SEOChecker.Core" %>
<%@ Import Namespace="SEOChecker.Resources" %>
<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../../css/SEOChecker.css" />
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" runat="server">
        <SEOChecker:SEOCheckerPanel ID="SEOCheckerPanel" runat="server" />
        <h2>
            <SEOChecker:ResourceTextControl ID="TriggerResource" ResourceKey="SEOCheckerConfiguration_Triggers" runat="server" /></h2>
        <umbraco:Pane ID="TriggerPane" runat="server">
            <umbraco:PropertyPanel ID="TriggerPanel" runat="server">
                <asp:CheckBox ID="publishTriggerCheckbox" runat="server" /></umbraco:PropertyPanel>
        </umbraco:Pane>
        <h2>
            <SEOChecker:ResourceTextControl ID="XmlSitemapResourceTextControl" ResourceKey="SEOCheckerConfiguration_XmlSitemap" runat="server" /></h2>
        <umbraco:Pane ID="SitemapPane" runat="server">
            <umbraco:PropertyPanel ID="EnableXmlSitemapPanel" runat="server">
                <asp:CheckBox ID="EnableXmlSitemapCheckbox" runat="server"  AutoPostBack="true"/></umbraco:PropertyPanel>
            <umbraco:PropertyPanel ID="ExcludeNavihide" runat="server" Text="">
                <asp:CheckBox ID="ExcludeXmlSitemapUmbracoNavihide" runat="server" /></umbraco:PropertyPanel>
            <umbraco:PropertyPanel ID="PreviewSiteMapXmlPanel" runat="server"><a href="/sitemap.xml" target="_blank">Preview sitemap.xml file</a></umbraco:PropertyPanel>
        </umbraco:Pane>
        <h2>
            <SEOChecker:ResourceTextControl ID="RobotsResourceTextControl" ResourceKey="SEOCheckerConfiguration_Robots" runat="server" /></h2>
        <umbraco:Pane ID="RobotstxtPane" runat="server">
            <umbraco:PropertyPanel ID="RobotsTxtPanel" runat="server">
                <asp:CheckBox ID="EnableRobotsTxtCheckbox" runat="server" /></umbraco:PropertyPanel>
            <umbraco:PropertyPanel ID="PreviewRobotsTxtPanel" runat="server"><a href="/robots.txt" target="_blank">Preview robots.txt file</a></umbraco:PropertyPanel>
        </umbraco:Pane>
        <h2>
            <SEOChecker:ResourceTextControl ID="RewriteConfigTextControl" ResourceKey="SEOCheckerConfiguration_RewriteConfig" runat="server" /></h2>
        <umbraco:Pane ID="EnableRewritingPane" runat="server">
            <umbraco:PropertyPanel ID="EnableRewritingPanel" runat="server">
                <asp:CheckBox ID="EnableRewritingCheckbox" runat="server" /></umbraco:PropertyPanel>
        </umbraco:Pane>
        <asp:PlaceHolder ID="RewriteOptionsVisible" runat="server">
            <umbraco:Pane ID="WWWPane" runat="server">
                <umbraco:PropertyPanel ID="WWWPanel" runat="server">
                    <asp:RadioButtonList ID="ForceWWWRadioList" RepeatDirection="Vertical" runat="server" /></umbraco:PropertyPanel>
            </umbraco:Pane>
            <umbraco:Pane ID="TrailingslashPane" runat="server">
                <umbraco:PropertyPanel ID="TrailingslashPanel" runat="server">
                    <asp:RadioButtonList ID="ForceTrailingslashRadioList" RepeatDirection="Vertical" runat="server" /></umbraco:PropertyPanel>
            </umbraco:Pane>
        </asp:PlaceHolder>
        <h2>
            <SEOChecker:ResourceTextControl ID="ToolsResourceTextControl" ResourceKey="SEOCheckerConfiguration_General" runat="server" /></h2>
        <umbraco:Pane ID="ToolPane" runat="server">
            <umbraco:PropertyPanel ID="KeywordSelectionToolPanel" runat="server">
                <asp:TextBox ID="KeywordSelectionToolTextBox" CssClass="umbEditorTextField" runat="server" /></umbraco:PropertyPanel>
        </umbraco:Pane>
        <umbraco:Pane ID="TemplateErrorsForNonAdminsPane" runat="server">
            <umbraco:PropertyPanel ID="TemplateErrorsForNonAdminsPanel" runat="server">
                <asp:CheckBox ID="TemplateErrorsForNonAdminsCheckBox" runat="server" /></umbraco:PropertyPanel>
        </umbraco:Pane>

    </umbraco:UmbracoPanel>


</asp:Content>
