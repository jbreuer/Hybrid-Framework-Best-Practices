<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailSettings.aspx.cs"  MasterPageFile="/umbraco/masterpages/umbracoPage.Master" Inherits="SEOChecker.Pages.Settings.EmailSettings" %>
<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<%@ Register TagPrefix="SEOChecker" Namespace="SEOChecker.Core.Controls" Assembly="SEOChecker.Core" %>
<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../../css/SEOChecker.css" />
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" runat="server">
        <SEOChecker:SEOCheckerPanel ID="SEOCheckerPanel" runat="server" />
        <asp:ValidationSummary runat="server" ID="valsum" CssClass="error"/>
        <umbraco:Pane runat="server" ID="FromNamePane">
            <umbraco:PropertyPanel runat="server" ID="FromNamePanel">
                <asp:TextBox runat="server" ID="FromNameTextBox" CssClass="umbEditorTextField"></asp:TextBox><asp:RequiredFieldValidator runat="server" ID="FormNameTextBoxValidator" Text="*" CssClass="fieldError" ControlToValidate="FromNameTextBox"/>
            </umbraco:PropertyPanel>
        </umbraco:Pane>
        <umbraco:Pane runat="server" ID="FromAddressPane">
            <umbraco:PropertyPanel runat="server" ID="FromAddressPanel">
                <asp:TextBox runat="server" ID="FromAddressTextBox" CssClass="umbEditorTextField"></asp:TextBox><asp:RequiredFieldValidator runat="server" ID="FromAddressTextBoxValidator" Text="*" CssClass="fieldError" ControlToValidate="FromAddressTextBox"/><asp:RegularExpressionValidator runat="server" ID="FromAddressTextBoxRegexpValidator" Text="*" CssClass="fieldError" ControlToValidate="FromAddressTextBox"/>
            </umbraco:PropertyPanel>
        </umbraco:Pane>
        <umbraco:Pane runat="server" ID="SubjectPane">
            <umbraco:PropertyPanel runat="server" ID="SubjectPanel">
                <asp:TextBox runat="server" ID="SubjectTextBox" CssClass="umbEditorTextField"></asp:TextBox><asp:RequiredFieldValidator runat="server" ID="SubjectTextBoxValidator" Text="*" CssClass="fieldError" ControlToValidate="SubjectTextBox"/>
            </umbraco:PropertyPanel>
        </umbraco:Pane>
         <umbraco:Pane runat="server" ID="XsltPane">
            <umbraco:PropertyPanel runat="server" ID="XsltPanel">
                <asp:DropDownList runat="server" ID="XsltDropdownList"/>
            </umbraco:PropertyPanel>
        </umbraco:Pane>
        </umbraco:UmbracoPanel>
    </asp:Content>