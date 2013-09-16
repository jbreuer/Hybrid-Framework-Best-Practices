<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Installer.ascx.cs" Inherits="DigibizAdvancedMediaPicker.Installer" %>
<%@ Import Namespace="umbraco.IO" %>
<%@ Register TagPrefix="umb" Namespace="ClientDependency.Core.Controls" Assembly="ClientDependency.Core" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.controls" Assembly="umbraco" %>

<umb:CssInclude ID="CssPropertypane" runat="server" FilePath="propertypane/style.css" PathNameAlias="UmbracoClient" />

<div style="padding: 10px 10px 0;">

	<p><img src="<%=IOHelper.ResolveUrl(SystemDirectories.Umbraco)%>/plugins/DigibizAdvancedMediaPicker/Logo.png" /></p>

    <UmbracoControls:Feedback runat="server" ID="Success" type="success" Text="Digibiz Advanced Media Picker 2.5 successfully installed!" />

    <p>Now that the <strong>Digibiz Advanced Media Picker 2.5</strong> has been installed, you can add the following options. These options have already been saved, so you only need to press the save button if you want to change them.</p>

    <h2>Image Cropper</h2>

    <div class="propertypane">        <table>            <tr>                <th style="width: 130px;">Call Image Cropper automatically:</th>                <td style="padding-bottom: 20px;"><div><asp:CheckBox ID="CheckBoxCallCropper" runat="server" Text="Yes" Checked="true"/></div><div style="color: #666; font-style: italic; margin-top: 5px;">If you create a media item which uses the Image Cropper the crops aren't created automatically. You first need to press the save button on the media item before the crops are created. Check this checkbox and it will create the crops automatically without that you need to press the save button.</div></td>            </tr>            <tr>                <th style="width: 130px;">Only if empty:</th>                <td style="padding-bottom: 20px;"><div><asp:CheckBox ID="CheckBoxIfEmpty" runat="server" Text="Yes" Checked="true"/></div><div style="color: #666; font-style: italic; margin-top: 5px;">If the Image Cropper will be called automatically you can choose to only call the cropper if no crops are available (right after creating a media item) or to always recreate the crops.</div></td>            </tr>        </table>    </div>

    <p>
        <asp:button id="BtnSaveSettings" runat="server" Text="Save settings" onclick="BtnSaveSettings_Click"/>
    </p>

</div>
