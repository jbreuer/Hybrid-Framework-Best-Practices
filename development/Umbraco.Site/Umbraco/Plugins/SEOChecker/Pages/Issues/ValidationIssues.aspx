<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ValidationIssues.aspx.cs" MasterPageFile="/umbraco/masterpages/umbracoPage.Master" Inherits="SEOChecker.Pages.Issues.ValidationIssues" %>
<%@ Import Namespace="SEOChecker.Resources" %>
<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<%@ Register TagPrefix="SEOChecker" Namespace="SEOChecker.Core.Controls" Assembly="SEOChecker.Core" %>
<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../../css/SEOChecker.css" />
    <script type="text/javascript" src="../../scripts/seochecker.js"></script>
    <script type="text/javascript">

        function DeleteItem(id) {
            $('.ActionPanel' + id).fadeOut(250);
        }

        function OpenDeleteDialog(id) {
            UmbClientMgr.openModalWindow('plugins/SEOChecker/pages/dialogs/confirmdelete.aspx?type=validationerror&id=' + id, 'Delete', true, 400, 300);
        }

        function OpenDocumentDialog(id) {
            UmbClientMgr.openModalWindow('/umbraco/editContent.aspx?id=' + id, 'Edit document', true, 900, 800);
        }
        function OpenTemplateDialog(id) {
            UmbClientMgr.openModalWindow('/umbraco/settings/editTemplate.aspx?templateID=' + id, 'Edit template', true, 900, 800);
        }

    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" runat="server">
        <SEOChecker:SEOCheckerPanel ID="SEOCheckerPanel" runat="server" />
        <umbraco:Feedback ID="SEOCheckerQueueFeedback" runat="server" type="notice" />
        <umbraco:Feedback ID="SEOCheckerQueueNonAdminFeedback" runat="server" type="notice" />
        <asp:PlaceHolder ID="NoIssuesPlaceHolder" runat="server">
            <h2>
                <%= ResourceHelper.Instance.GetStringResource("SEOCheckerValidationIssues_NoResult")%></h2>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="OverviewPlaceHolder" runat="server">
                <asp:Repeater ID="OverviewRepeater" runat="server">
                    <ItemTemplate>
                        <%# RenderCategory(Eval("Category").ToString())%>
                        <asp:Panel ID="NotFoundPanel" runat="server" CssClass='<%#string.Format("ActionPanel{0}",Eval("IssueId")) %>'>
                            <umbraco:Pane ID="NotFoundPane" runat="server">
                                <div class="propertyItem">
                                    <div class="propertyItemheader">
                                        <div class="bulkItemSelectChecboxContainer"><input type="checkbox" value='<%#Eval("IssueId") %>' class="bulkItemSelectCheckbox"/></div>
                                        <span class='<%#RenderCssClass((SEOChecker.Core.Repository.ValidationIssues.ValidationErrorView)Container.DataItem)%>'>
                                            <%#RenderTitle((SEOChecker.Core.Repository.ValidationIssues.ValidationErrorView)Container.DataItem)%>
                                        </span>
                                    </div>
                                    <div class="propertyItemContent">
                                        <span class='<%#RenderCssClass((SEOChecker.Core.Repository.ValidationIssues.ValidationErrorView)Container.DataItem)%>'>
                                            <%#Eval("ErrorDescription") %>
                                        </span>
                                    </div>
                                    <div Class="SEOCheckerOverviewButtons">
                                        <SEOChecker:DocumentButton ID="DocumentButton" runat="server" DocumentID='<%#Eval("DocumentID") %>' />
                                        <SEOChecker:TemplateButton ID="TemplateButton" runat="server" TemplateID='<%#Eval("TemplateID") %>' />
                                        <SEOChecker:DeleteButton ID="DeleteButton" runat="server" IssueId='<%#Eval("IssueId") %>' />
                                    </div>
                                </div>
                            </umbraco:Pane>
                        </asp:Panel>
                    </ItemTemplate>
                </asp:Repeater>
            <asp:PlaceHolder runat="server" id="PagingPlaceHolder"/>
        </asp:PlaceHolder>
    </umbraco:UmbracoPanel>
</asp:Content>


