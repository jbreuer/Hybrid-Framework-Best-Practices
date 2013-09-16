<%@ Page Language="C#" MasterPageFile="../../masterpages/umbracoPage.Master" AutoEventWireup="true" Codebehind="editConfigFile.aspx.cs" Inherits="Our.Umbraco.Tree.Config.EditConfigFile" ValidateRequest="False" %>
<%@ Register TagPrefix="umb" Namespace="umbraco.uicontrols" Assembly="controls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

	<umb:UmbracoPanel runat="server" ID="UmbracoPanel1" Text="Config Editor" hasMenu="true">
		
		<umb:Pane runat="server" ID="Pane1" Text="Edit Config File">
			
			<umb:Feedback runat="server" ID="Feedback1" Visible="false" />

			<umb:PropertyPanel runat="server" ID="PropertyPanel1" Text="Name">
				<asp:TextBox ID="txtName" Width="350px" runat="server"></asp:TextBox>
			</umb:PropertyPanel>
			
			<umb:PropertyPanel runat="server" id="PropertyPanel2" Text="Path">
				<asp:Literal ID="ltrlPath" runat="server" />
			</umb:PropertyPanel>

			<umb:PropertyPanel runat="server" ID="PropertyPanel3">
				<umb:CodeArea runat="server" ID="editorSource" CodeBase="XML" AutoResize="true" OffSetX="47" OffSetY="47"  />
			</umb:PropertyPanel>

		</umb:Pane>

	</umb:UmbracoPanel>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>