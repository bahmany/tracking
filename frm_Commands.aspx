<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frm_Commands.aspx.cs" Inherits="frm_Commands" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/StyleSheet.css" rel="stylesheet" type="text/css" />

    <script src="Script.js" type="text/javascript"></script>
  <script type="text/javascript">

</script>


    <title>
    
    </title>
</head>
<body dir="rtl">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
    <div class="commandWindows" dir="rtl">
<div>
    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="javascript:changeVisible(false,'div_commandWindows');">بستن فرم</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <span id="UnitIDCommand"></span>
    <asp:Label ID="lbl_UnitID" runat="server"></asp:Label>
        </div>
    <div id="commandsDIV" style="display: inline-block">
    
     
        <asp:DataList ID="dl_commands_list" runat="server" DataKeyField="cmd_id" 
            DataSourceID="ods_CommandsList">
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("cmd_fa_name") %>' 
                    Font-Bold="True"></asp:Label> 
                &nbsp;
                <asp:HyperLink ID="HyperLink1" runat="server" 
                    NavigateUrl='<%# Eval("cmd_id","javascript:loadCommand({0})") %>' Text="..."></asp:HyperLink>
                &nbsp;<br />
                <asp:Label ID="Label2" runat="server" Text='<%# Eval("cmd_desc") %>'></asp:Label>
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList> 
        <asp:ObjectDataSource ID="ods_CommandsList" runat="server" 
            DeleteMethod="Delete" InsertMethod="Insert" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
            TypeName="MainDataModuleTableAdapters.tbl_CommandsTableAdapter" 
            UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_cmd_id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:QueryStringParameter Name="cmd_name" QueryStringField="sssssss" 
                    Type="String" />
                <asp:Parameter Name="cmd_fa_name" Type="String" />
                <asp:Parameter Name="cmd_desc" Type="String" />
                <asp:Parameter Name="Original_cmd_id" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="cmd_name" Type="String" />
                <asp:Parameter Name="cmd_fa_name" Type="String" />
                <asp:Parameter Name="cmd_desc" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>

    
        </div>
    <div id="FormDiv" style="display: inline-block"> 
        </div>
 
    </div>
      
    </form>
</body>
</html>
