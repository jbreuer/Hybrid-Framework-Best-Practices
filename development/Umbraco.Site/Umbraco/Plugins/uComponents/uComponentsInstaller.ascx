<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="uComponentsInstaller.ascx.cs" Inherits="uComponents.Installer.uComponentsInstaller" EnableViewState="false" %>
<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umb" %>

<umb:PropertyPanel runat="server">
	<div class="uComponents">
		<div class="dashboardWrapper">
			<h2>uComponents</h2>
			<img src="<%= Logo %>" alt="uComponents" class="dashboardIcon" />

			<umb:Feedback runat="server" ID="Success" type="success" Text="uComponents successfully installed!" />
			<umb:Feedback runat="server" ID="Failure" type="error" Visible="false" />
				
			<p>Now that <strong>uComponents</strong> has been installed, you can activate any of the following components.</p>
			<p>To activate these components, simply mark the ones you would like to activate, and click the "Activate Selected Components" button.</p>
			<p>If you do no wish to activate a component now, then you can always do so later on. <a href="http://ucomponents.codeplex.com/documentation" target="_blank">Please refer to the documentation.</a></p>

			<h3>Data Types</h3>
			<div class="dashboardColWrapper">
				<div class="dashboardCols">
					<div class="dashboardCol">
						<p>The data types are installed by default. To enable them, please create a new data type in the developer section.</p>
					</div>
				</div>
			</div>

			<h3>Razor Model Binding</h3>
			<div class="dashboardColWrapper">
				<div class="dashboardCols">
					<div class="dashboardCol">
						<p>When using Razor macro templates, the values from the data-types are automatically bound to a model. <strong>This option is enabled by default.</strong> To use the raw data/value, you can disable this feature.</p>
						<asp:CheckBox runat="server" ID="cbDisableRazorModelBinding" Text="Disable Razor model binding" Checked="false" />
					</div>
				</div>
			</div>

			<h3>UI Modules</h3>
			<div class="dashboardColWrapper">
				<div class="dashboardCols">
					<div class="dashboardCol">
						<asp:CheckBox runat="server" ID="cbUiModules" Text="Enable UI Modules" Checked="true" /> <em>(Keyboard shortcuts  are enabled by default)</em>
						<div style="margin-left:15px;">
							<asp:CheckBoxList runat="server" ID="cblUiModules"></asp:CheckBoxList>
						</div>
					</div>
				</div>
			</div>

			<h3>Not Found Handlers</h3>
			<div class="dashboardColWrapper">
				<div class="dashboardCols">
					<div class="dashboardCol">
						<asp:CheckBoxList runat="server" ID="cblNotFoundHandlers"></asp:CheckBoxList>
					</div>
				</div>
			</div>

			<h3>XSLT Extensions</h3>
			<div class="dashboardColWrapper">
				<div class="dashboardCols">
					<div class="dashboardCol">
						<asp:CheckBoxList runat="server" ID="cblXsltExtensions"></asp:CheckBoxList>
					</div>
				</div>
			</div>

			<asp:PlaceHolder runat="server" ID="phDashboardControl">
				<h3>Dashboard control</h3>
				<div class="dashboardColWrapper">
					<div class="dashboardCols">
						<div class="dashboardCol">
							<p>If you would like to revisit this screen in future, you can add it as a dashboard control to the Developer section.</p>
							<asp:CheckBox runat="server" ID="cbDashboardControl" Text="Add as dashboard control?" />
						</div>
					</div>
				</div>
			</asp:PlaceHolder>

			<p>
				<asp:Button runat="server" ID="btnInstall" Text="Activate Selected Components" OnClick="btnActivate_Click" OnClientClick="jQuery(this).hide(); jQuery('#installingMessage').show(); return true;" />
				<div style="display: none;" id="installingMessage">
					<umb:ProgressBar runat="server" />
					<br />
					<em>&nbsp; &nbsp;Installing component(s), please wait...</em><br />
				</div>
			</p>

		</div>
	</div>
</umb:PropertyPanel>
