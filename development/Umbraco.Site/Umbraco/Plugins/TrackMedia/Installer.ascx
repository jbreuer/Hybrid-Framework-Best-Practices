<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Installer.ascx.cs" Inherits="TrackMedia.Installer" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.uicontrols" Assembly="controls" %>
<%@ Register TagPrefix="UmbracoControls" Namespace="umbraco.controls" Assembly="umbraco" %>

<link rel="stylesheet" type="text/css" href="/umbraco_client/propertypane/style.css" />

<style type="text/css">
    #trackMedia div.codepress { !important; height: 40px; width: 720px; }
</style>

<script type="text/javascript">
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginReq);
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endReq);
    function beginReq(sender, args) {
        document.getElementById('<%=BtnSaveMediaTypes.ClientID%>').style.display = 'none';
        document.getElementById('<%=LblUpdated.ClientID%>').style.display = 'none';
        document.getElementById('updating').style.display = 'inline';
    }
    function endReq(sender, args) {
        document.getElementById('<%=BtnSaveMediaTypes.ClientID%>').style.display = 'inline';
        document.getElementById('<%=LblUpdated.ClientID%>').style.display = 'inline';
        document.getElementById('updating').style.display = 'none';
    }       
              
</script>

<div id="trackMedia" style="padding: 10px 10px 0;">

	<UmbracoControls:Feedback runat="server" ID="Success" type="success" Text="Track Media successfully installed!" />

    <p>
        Now that <strong>Track Media</strong> has been installed, you can choose what media types you want to update.<br />
        If you're using base media types only check the base media type and not the media types which inherit from that.<br />
        Check the media types below that you want to give a extra textfield property. This field can be used to pass extra information when you track media.<br />
        For example if you store "Manual" in this property it will be used like this: _gaq.push(['_trackEvent', 'Download', 'Manual', '/media/2167/manual.pdf']);
    </p>

    <h2>Media types</h2>

    <div class="propertypane">
        <asp:CheckBoxList ID="CheckBoxListMediaTypes" runat="server" Width="500px"></asp:CheckBoxList>
    </div>

    <asp:UpdatePanel ID="UpdatePanelLoading" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <p>

                <asp:button id="BtnSaveMediaTypes" runat="server" Text="Update media types" onclick="BtnSaveMediaTypes_Click"/>
                <span id="updating" style="display: none;">
                    Updating media types...<br />
                    This may take a while depending on the amount of media items...<br />
                    <img src="/umbraco_client/images/progressBar.gif" alt="Loading..." />
                </span>
                <asp:Label ID="LblUpdated" runat="server" style="display:none;">All the media types are updated succesfully.</asp:Label>
            </p>
        </ContentTemplate>
    </asp:UpdatePanel>

    <UmbracoControls:Feedback runat="server" ID="Feedback1" type="notice" Text="If you want to use this package you need to have the Google Analytics and jQuery code somewhere in your template and you also need to add the following code:" />

    <div class="propertypane">
        <strong>&lt;script src=&quot;/umbraco/plugins/TrackMedia/Tracking.js&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;</strong>
    </div>

</div>