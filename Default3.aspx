<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
    </telerik:RadStyleSheetManager>
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <div>
    
        <telerik:RadTreeView ID="RadTreeView1" Runat="server" CheckBoxes="True" 
            TriStateCheckBoxes="True" CheckChildNodes="True" DataFieldID="wms_id" 
            DataFieldParentID="wms_parentTreeID" DataNavigateUrlField="wms_userLevel" 
            DataTextField="wms_name" DataValueField="wms_id" >
            <Nodes>
                <telerik:RadTreeNode runat="server" Text="Root RadTreeNode1">
                    <Nodes>
                        <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 1">
                        </telerik:RadTreeNode>
                        <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 2">
                        </telerik:RadTreeNode>
                        <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 3">
                        </telerik:RadTreeNode>
                        <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 4">
                        </telerik:RadTreeNode>
                    </Nodes>
                </telerik:RadTreeNode>
                <telerik:RadTreeNode runat="server" Text="Root RadTreeNode2">
                    <Nodes>
                        <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 1">
                        </telerik:RadTreeNode>
                        <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 2">
                        </telerik:RadTreeNode>
                        <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 3">
                        </telerik:RadTreeNode>
                        <telerik:RadTreeNode runat="server" Text="Child RadTreeNode 4">
                        </telerik:RadTreeNode>
                    </Nodes>
                </telerik:RadTreeNode>
                <telerik:RadTreeNode runat="server" Text="Root RadTreeNode3">
                </telerik:RadTreeNode>
                <telerik:RadTreeNode runat="server" Text="Root RadTreeNode4">
                </telerik:RadTreeNode>
                <telerik:RadTreeNode runat="server" Text="Root RadTreeNode5">
                </telerik:RadTreeNode>
            </Nodes>
<CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>

<ExpandAnimation Duration="100"></ExpandAnimation>
        </telerik:RadTreeView>
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AriaAGConnectionString %>" 
            SelectCommand="SELECT * FROM [tbl_menu_settings]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
