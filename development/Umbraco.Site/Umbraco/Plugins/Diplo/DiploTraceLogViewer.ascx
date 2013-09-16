<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DiploTraceLogViewer.ascx.cs" Inherits="Diplo.TraceLogViewer.DiploTraceLogViewer" %>

<script src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>

<link type="text/css" rel="stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />

<style type="text/css">
    #dataTable tr.error
    {
        color: #990000;
    }

    #dataTable tr.info
    {
        color: #333;
    }

    #dataTable tr.warn
    {
        color: #AA6600;
    }

    #dataTable td.logMessage
    {
        white-space: pre-wrap;
    }

    #dataTable
    {
        padding-bottom: 1px;
        border-bottom: 1px solid #ddd;
        margin-bottom: 10px;
    }
</style>

<asp:MultiView ID="MvLogViewer" runat="server" ActiveViewIndex="0">

    <asp:View ID="ViewLog" runat="server">

        <script type="text/javascript">

            $(document).ready(function () {
                $('#dataTable').dataTable({
                    "iDisplayLength": 100,
                    "bRetrieve": true,
                    "bDestroy": true,
                    "bStateSave": true,
                });
            })

        </script>

        <div id="diploTraceLogViewer">
            <div class="propertypane">
                <div class="propertyItem">

                    <asp:Label ID="LblLogFile" runat="server" Text="Select Trace Log :" AssociatedControlID="DdlFileList" />

                    <asp:DropDownList ID="DdlFileList" runat="server" AppendDataBoundItems="true" AutoPostBack="true">
                        <asp:ListItem Value="" Text="-- Select a Log --"></asp:ListItem>
                    </asp:DropDownList>

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <asp:PlaceHolder ID="PhLevelList" runat="server" Visible="false">

                    <asp:Label ID="LblLevelList" runat="server" Text="Select Level Type :" AssociatedControlID="CbLevelList" />

                    <asp:CheckBoxList ID="CbLevelList" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" AutoPostBack="true">
                        <asp:ListItem Selected="True">INFO</asp:ListItem>
                        <asp:ListItem Selected="True">WARN</asp:ListItem>
                        <asp:ListItem Selected="True">ERROR</asp:ListItem>
                    </asp:CheckBoxList>

                    <div style="float:right">
                        <asp:CheckBox ID="CbPersist" runat="server" Text="Remember settings" ToolTip="Tick to remember these settings" 
                            AutoPostBack="true"  OnCheckedChanged="CbPersist_CheckedChanged"/>
                    </div>

                </asp:PlaceHolder>

                    <table id="dataTable">

                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Level</th>
                                <th>Logger</th>
                                <th>Message</th>
                            </tr>
                        </thead>

                        <asp:Repeater ID="LogDataTable" runat="server" EnableViewState="false">
                            <ItemTemplate>
                                <tr class="<%# Eval("LevelCssClass") %>">
                                    <td><%# Eval("Date") %></td>
                                    <td><%# Eval("Level") %></td>
                                    <td title="<%# Eval("Logger") %>"><%# Eval("LoggerTruncated") %></td>
                                    <td class="logMessage"><%# Eval("Message") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>

                    </table>

                    <br style="clear: both" />

                </div>
            </div>
        </div>

    </asp:View>

    <asp:View ID="ViewError" runat="server">

        <h2 style="color:red">Ooops!</h2>

        <asp:Label ID="LblErrorMessage" runat="server" EnableViewState="false" />

    </asp:View>

</asp:MultiView>


