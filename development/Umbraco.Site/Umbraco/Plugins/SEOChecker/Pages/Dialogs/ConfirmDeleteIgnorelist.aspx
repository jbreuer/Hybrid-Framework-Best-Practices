<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfirmDeleteIgnorelist.aspx.cs"  MasterPageFile="/umbraco/masterpages/umbracoDialog.Master" Inherits="SEOChecker.Pages.Dialogs.ConfirmDeleteIgnorelist" %>
<%@ Import Namespace="SEOChecker.Resources" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    $(document).ready(function ($) {
        var processedField = '#<%=ProcessedIndicator.ClientID %>';
        var id = '<%=Id %>';
        var speechBubbleTitle = '<%=ResourceHelper.Instance.GetStringResource("SEOCheckerInboundLinkDeleteSpeechBubbleHeader") %>';
        var speechBubbleBody = '<%=ResourceHelper.Instance.GetStringResource("SEOCheckerInboundLinkDeleteSpeechBubbleBody") %>';
        if ($(processedField).val() == '1') {
            UmbClientMgr.contentFrame().focus();
            UmbClientMgr.closeModalWindow();
            UmbClientMgr.contentFrame().DeleteItem(id);
            UmbClientMgr.mainWindow().UmbSpeechBubble.ShowMessage('info', speechBubbleTitle, speechBubbleBody);
        }
    });
</script>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
<asp:HiddenField ID="ProcessedIndicator" runat="server" Value="false" />
<div id="formDiv" style="visibility: visible;">
        <div class="propertyDiv">
        <p>
            <%:ResourceHelper.Instance.GetStringResource("Dialogs_ConfirmDeleteIgnoreListDialogConfirmation")%>
        </p>
        </div>
               
        <asp:Button ID="DeleteButton" runat="server" CssClass="guiInputButton" OnClick="DeleteButton_Click" ></asp:Button> <em><%= umbraco.ui.Text("general","or") %></em> <a href="#" style="color: blue" onclick="UmbClientMgr.closeModalWindow()"><%=umbraco.ui.Text("general", "cancel", this.getUser())%></a>
      </div>
</asp:Content>