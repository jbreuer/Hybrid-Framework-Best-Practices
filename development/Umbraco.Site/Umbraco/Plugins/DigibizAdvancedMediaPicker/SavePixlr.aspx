<%@ Page Language="c#" MasterPageFile="../../masterpages/umbracoDialog.Master" Title="Select media item" CodeBehind="SavePixlr.aspx.cs" Inherits="DigibizAdvancedMediaPicker.SavePixlr" AutoEventWireup="True"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

  <script type="text/javascript">
      
      function SetNodeId(id) {
          UmbClientMgr.closeModalWindow(id);
      }

      function Close() {
          UmbClientMgr.closeModalWindow();
      }

  </script>

</asp:Content>