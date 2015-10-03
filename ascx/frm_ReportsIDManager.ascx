<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_ReportsIDManager.ascx.cs" Inherits="ascx_frm_ReportsIDManager" %>
<div dir="rtl" style="font-family: tahoma; font-size: 11px">

    <table>
        <tr>
            <td>
                مدل یونیت</td>
            <td>
                <asp:DropDownList ID="drp_UnitModel" runat="server">
                    <asp:ListItem Selected="True">A1</asp:ListItem>
                    <asp:ListItem>P1</asp:ListItem>
                    <asp:ListItem>X1</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                کد گزارش</td>
            <td>
                <asp:TextBox ID="txt_ReportCode" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                معادل فارسی</td>
            <td>
                <asp:TextBox ID="txt_FarsiExp" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                سطح اخطار</td>
            <td>
                <asp:DropDownList ID="drp_Agency" runat="server">
                    <asp:ListItem>1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem>4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:LinkButton ID="lnk_post" runat="server" onclick="lnk_post_Click">ثبت</asp:LinkButton>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="id" 
        DataSourceID="ods_repDef" GridLines="Vertical">
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <Columns>
            <asp:BoundField DataField="RepDifID" HeaderText="کد گزارش" 
                SortExpression="RepDifID" />
            <asp:BoundField DataField="RepDifValue" HeaderText="معادل فارسی" 
                SortExpression="RepDifValue" />
            <asp:BoundField DataField="RepDifAgent" HeaderText="سطح اخطار" 
                SortExpression="RepDifAgent" />
            <asp:BoundField DataField="RepUnitModel" HeaderText="مدل یونیت" 
                SortExpression="RepUnitModel" />
            <asp:CommandField DeleteText="حذف" EditText="ویرایش" ShowDeleteButton="True" 
                ShowEditButton="True" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="#DCDCDC" />
    </asp:GridView>
    <asp:ObjectDataSource ID="ods_repDef" runat="server" DeleteMethod="Delete" 
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetData" 
        TypeName="MainDataModuleTableAdapters.tbl_report_defineTableAdapter" 
        UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="RepDifID" Type="Int32" />
            <asp:Parameter Name="RepDifValue" Type="String" />
            <asp:Parameter Name="RepDifAgent" Type="Int32" />
            <asp:Parameter Name="RepUnitModel" Type="String" />
            <asp:Parameter Name="Original_id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txt_ReportCode" Name="RepDifID" 
                PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txt_FarsiExp" Name="RepDifValue" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="drp_Agency" Name="RepDifAgent" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="drp_UnitModel" Name="RepUnitModel" 
                PropertyName="SelectedValue" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>

</div>