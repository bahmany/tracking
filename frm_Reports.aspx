<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="frm_Reports.aspx.cs" Inherits="Reports" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
    </telerik:RadStyleSheetManager>
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <div dir="rtl" 
        
        style="padding: 6px; margin: auto; font-family: tahoma; font-size: 11px; background-color: #FFFFFF; bottom: 20px; position: fixed; top: 43px; right: 10px; left: 10px; display: block; overflow: scroll;">
    <div>
        <span>گزارشات</span>
        <br />
        <br />
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="ods_reportMenu">
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("mr_name") %>' NavigateUrl='<%# Eval("mr_link") %>'  ></asp:HyperLink>
         &nbsp; &nbsp;|
            </ItemTemplate>
        </asp:Repeater>
    &nbsp;<asp:ObjectDataSource ID="ods_reportMenu" runat="server" DeleteMethod="Delete" 
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetData" 
        TypeName="MainDataModuleTableAdapters.tbl_menu_reportsTableAdapter" 
        UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_mr_id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="mr_weight" Type="Int32" />
                <asp:Parameter Name="mr_name" Type="String" />
                <asp:Parameter Name="mr_link" Type="String" />
                <asp:Parameter Name="Original_mr_id" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="Weight" 
                SessionField="OwnerWeight" Type="Int32" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="mr_weight" Type="Int32" />
                <asp:Parameter Name="mr_name" Type="String" />
                <asp:Parameter Name="mr_link" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </div>
    <div>
        <br />
        <table style="width: 100%">
            <tr>
                <td style="width: 150px">
                
         
                
                    <telerik:RadTreeView ID="trv_units" Runat="server" CheckBoxes="True" 
                        Skin="Telerik" TriStateCheckBoxes="true" CheckChildNodes="true" 
                        MultipleSelect="True" onclientnodechecked="ClientNodeChecked" >
<CollapseAnimation Type="OutQuint" Duration="100" ></CollapseAnimation>

<ExpandAnimation Duration="100"></ExpandAnimation>
                    </telerik:RadTreeView>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
        <asp:PlaceHolder ID="ph" runat="server"></asp:PlaceHolder>
                            </td>
                            <td>
                    <div id="div_ReportRepresentor">
                    
                        </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
        <br />
    </div>
</div>   
    <script type="text/javascript" language="javascript">
var selectedCars = new Array();
function ClientNodeChecked(sender, eventArgs)
{
    var node = eventArgs.get_node();
    var chkState = node.get_checked();
    var chkText = node.get_text();
    if (chkState == true) {
        selectedCars.push(chkText);

    } else {
    for (var i = 0; i < selectedCars.length; i++) {
        if (selectedCars[i] == chkText) {
            selectedCars.splice(i, 1); 
        }
    }
    }
}

</script>
</asp:Content>

