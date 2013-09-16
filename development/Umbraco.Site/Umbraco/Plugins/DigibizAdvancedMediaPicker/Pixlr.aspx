<%@ Page Language="c#" MasterPageFile="../../masterpages/umbracoDialog.Master" Title="Select media item" CodeBehind="Pixlr.aspx.cs" Inherits="DigibizAdvancedMediaPicker.Pixlr" AutoEventWireup="True"%>

<asp:Content ID="ContentPage" ContentPlaceHolderID="body" runat="server">
<iframe src="<%= IframeUrl %>" style="width: 100%; height: 97%; min-height: 768px;" frameborder="0"></iframe>
</asp:Content>