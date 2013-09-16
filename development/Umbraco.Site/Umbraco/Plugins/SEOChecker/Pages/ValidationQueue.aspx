<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ValidationQueue.aspx.cs"
    MasterPageFile="/umbraco/masterpages/umbracoPage.Master" Inherits="SEOChecker.Pages.ValidationQueue" %>
<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<%@ Register TagPrefix="SEOChecker" Namespace="SEOChecker.Core.Controls" Assembly="SEOChecker.Core" %>
<%@ Import Namespace="SEOChecker.Resources" %>
<%@ Import Namespace="SEOChecker.Core.Repository.Queue" %>
<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../css/SEOChecker.css" />
    <meta http-equiv="refresh" content="5">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" runat="server">
        <SEOChecker:SEOCheckerPanel ID="SEOCheckerPanel" runat="server" />
        <umbraco:Feedback ID="SEOCheckerQueueError" runat="server" type="error"  Visible="false"/>
        <asp:PlaceHolder ID="OverviewPlaceHolder" runat="server">
            <asp:Repeater ID="OverviewRepeater" runat="server">
                <ItemTemplate>
                    <umbraco:Pane ID="NotFoundPane" runat="server">
                        <div class="propertyItem">
                            <div class="propertyItemheader">
                                <%#Eval("DocumentName") %><br />
                                <small>Preview: 
                                    <asp:HyperLink ID="PreviewButton" ToolTip=' <%# ResourceHelper.Instance.GetStringResource("Overview_PreviewDocument") %>'
                                        runat="server" Target="_blank" NavigateUrl='<%#umbraco.library.NiceUrl(((AnalyserQueuedItem)Container.DataItem).DocumentId)%>'
                                        Text='<%#Eval("DocumentName") %>' /></small></div>
                            <div class="propertyItemContent">
                            </div>
                        </div>
                    </umbraco:Pane>
                </ItemTemplate>
            </asp:Repeater>
        </asp:PlaceHolder>
    </umbraco:UmbracoPanel>
</asp:Content>
