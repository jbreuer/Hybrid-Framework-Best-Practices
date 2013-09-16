<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DigibizEmailForm.ascx.cs" Inherits="DigibizEmailForm.DigibizEmailForm" %>
<%@ Import Namespace="umbraco.IO" %>

<style type="text/css">
    .txtStyle
    {
        width: 290px;
    }
    .tdStyle
    {
    	width: 150px;
    	vertical-align: top;
    }
    .imgAlign
    {
    	float: right;
    }
</style>

<table>
    <tr id="TrSendEmail" runat="server">
        <td class="tdStyle">Send</td>
        <td><asp:CheckBox ID="CheckEmail" runat="server"/></td>
    </tr>
    <tr>
        <td class="tdStyle">Sender name</td>
        <td>
            <asp:TextBox ID="TxtSenderName" runat="server" CssClass="txtStyle"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidatorSenderName" runat="server" ControlToValidate="TxtSenderName" Text="Sender name"  OnServerValidate="ValidateWebControl" ValidateEmptyText="true" Display="Dynamic"></asp:CustomValidator>
        </td>
    </tr>
    <tr>
        <td class="tdStyle">Sender e-mail</td>
        <td>
            <asp:TextBox ID="TxtSenderEmail" runat="server" CssClass="txtStyle"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidatorSenderEmail" runat="server" ControlToValidate="TxtSenderEmail" Text="Sender e-mail" OnServerValidate="ValidateWebControl" ValidateEmptyText="true" Display="Dynamic"></asp:CustomValidator>
            <asp:CustomValidator ID="CustomValidatorSenderEmailRegex" runat="server" ControlToValidate="TxtSenderEmail" Text="Sender e-mail" OnServerValidate="ValidateEmail" Display="Dynamic"></asp:CustomValidator>
        </td>
    </tr>
    <tr>
        <td class="tdStyle">Subject</td>
        <td>
            <asp:TextBox ID="TxtSubject" runat="server" CssClass="txtStyle"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidatorSubject" runat="server" ControlToValidate="TxtSubject" Text="Subject" OnServerValidate="ValidateWebControl" ValidateEmptyText="true" Display="Dynamic"></asp:CustomValidator>
        </td>
    </tr>
    <tr>
        <td class="tdStyle">
            Receiver e-mail
            <asp:Image ID="ImgReceiver" runat="server" ToolTip="You can split multiple e-mail addresses on ; or ," CssClass="imgAlign"/>
        </td>
        <td>
            <asp:TextBox ID="TxtReceiverEmail" runat="server" CssClass="txtStyle"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidatorReceiverEmail" runat="server" ControlToValidate="TxtReceiverEmail" Text="Receiver e-mail" OnServerValidate="ValidateWebControl" ValidateEmptyText="true" Display="Dynamic"></asp:CustomValidator>
            <asp:CustomValidator ID="CustomValidatorReceiverEmailRegex" runat="server" ControlToValidate="TxtReceiverEmail" Text="Receiver e-mail" OnServerValidate="ValidateEmail" Display="Dynamic"></asp:CustomValidator>
        </td>
    </tr>
    <tr>
        <td class="tdStyle">
            CC e-mail
            <asp:Image ID="ImgCC" runat="server" ToolTip="You can split multiple e-mail addresses on ; or ," CssClass="imgAlign"/>
        </td>
        <td>
            <asp:TextBox ID="TxtCCEmail" runat="server" CssClass="txtStyle"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidatorCCEmailRegex" runat="server" ControlToValidate="TxtCCEmail" Text="CC e-mail" OnServerValidate="ValidateEmail" Display="Dynamic"></asp:CustomValidator>
        </td>
    </tr>
    <tr>
        <td class="tdStyle">
            BCC e-mail
            <asp:Image ID="ImgBCC" runat="server" ToolTip="You can split multiple e-mail addresses on ; or ," CssClass="imgAlign"/>
        </td>
        <td>
            <asp:TextBox ID="TxtBCCEmail" runat="server" CssClass="txtStyle"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidatorBCCEmailRegex" runat="server" ControlToValidate="TxtBCCEmail" Text="BCC e-mail" OnServerValidate="ValidateEmail" Display="Dynamic"></asp:CustomValidator>
        </td>
    </tr>
    <tr>
        <td class="tdStyle">Body</td>
        <td>
<%--Don't close the table because this happens in the code.--%>