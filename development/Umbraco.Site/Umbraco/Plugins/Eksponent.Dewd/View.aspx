<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="../../masterpages/umbracoPage.Master" ValidateRequest="false" CodeBehind="View.aspx.cs" Inherits="Eksponent.Dewd.Pages.View" %>
<%@ Register TagPrefix="cc1" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="dewd" Namespace="Eksponent.Dewd.Controls.View" Assembly="Eksponent.Dewd"  %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <asp:PlaceHolder runat="server" ID="Umbraco40Header">
        <script type="text/javascript" src="/umbraco_client/modal/modal.js"></script>
        <link rel="Stylesheet" type="text/css" href="/umbraco_client/modal/style.css" /> 
    </asp:PlaceHolder>
    <asp:PlaceHolder runat="server" ID="Head" />
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="body" runat="server">
    <asp:PlaceHolder runat="server" ID="Body" />
    <script type="text/javascript">
        jQuery(function () {
            var $j = jQuery;

            // attach various ui events
            $j(".pager-box").focus(function () { this.select(); });

            $j("body").keyup(function (e) {
                if ($j(".pager a").length != 0) {
                    if (e.keyCode == 37) location.href = $j(".pager a:eq(0)").attr("href");
                    if (e.keyCode == 39) location.href = $j(".pager a:eq(1)").attr("href");
                }
            });

            $j("select.viewSelector").change(function () {
                location.href = this.value;
            });
        });
    </script>

    <cc1:UmbracoPanel id="OuterPanel" runat="server" Height="224px" Width="412px">

		<div style="padding: 17px 15px 0px 15px" id="inner">
            <div style="height:35px;position:relative;">
                <div style="position:absolute;right:0px;" runat="server" id="TopRightPanel" />
                <asp:PlaceHolder runat="server" ID="TopLeftPanel">
                    <asp:PlaceHolder runat="server" ID="SelectorHolder">
                        Select view: <select runat="server" id="ViewList" class="viewSelector" />
                    </asp:PlaceHolder>
                </asp:PlaceHolder>
            </div>

            <asp:PlaceHolder runat="server" ID="MainPanel">
                <asp:PlaceHolder runat="server" ID="ViewControlHolder" />
            </asp:PlaceHolder>

            <div style="position:relative;height:30px">
                <div style="position:absolute" runat="server" ID="BottomLeftPanel">
                    <a runat="server" id="CreateLink" visible="false" style="line-height:30px">Create new...</a>
                </div> 
                <div style="position:absolute;right:0px" runat="server" ID="BottomRightPanel">
                </div>
                <asp:PlaceHolder runat="server" ID="BottomCenterPanel">
                    <div runat="server" ID="Pager" visible="false" class="pager">
                        <asp:LinkButton runat="server" ID="PagePrevious" OnClick="Page_Navigate"  Text="&lt;" />
                        Page <asp:TextBox runat="server" ID="PageCurrent" Style="width:30px" class="pager-box" AutoPostBack="true" /> / 
                        <asp:Literal runat="server" ID="PageTotal" />
                        <asp:LinkButton runat="server" ID="PageNext" OnClick="Page_Navigate" Text="&gt;" />
                    </div>
                </asp:PlaceHolder>
            </div>
		</div>
	</cc1:UmbracoPanel>

    <style type="text/css">                
        .pager { text-align:center; margin-top:5px;height:30px;}
        .pager a { text-decoration: none; }
        .gridModal { display: none; position: fixed; top: 17%; left: 50%; margin-left: -300px; width: 600px; height:400px; overflow:auto; background-color: #ffffff; color: #333; border: 1px solid #CAC9C9; padding: 12px; }
    </style>

</asp:Content>
