<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_UnitsGroupManager.ascx.cs" Inherits="ascx_frm_UnitsGroupManager" %>
<div dir="rtl" 
    style="font-family: tahoma; background-color: #FFFFFF; font-size: 11px;">
در این قسمت مشخصات گروه های وسائط نقلیه قرار می گیرد<br />
&nbsp;<table>
        <tr>
            <td>
                نام گروه</td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">ثبت</asp:LinkButton>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>

    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" DataKeyNames="cg_id" 
        DataSourceID="ods_UnitsGroup" BackColor="White" BorderColor="#999999" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" 
        Height="158px">
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <Columns>
            <asp:BoundField DataField="cg_id" HeaderText="کد" InsertVisible="False" 
                ReadOnly="True" SortExpression="cg_id" />
            <asp:BoundField DataField="cg_name" HeaderText="نام گروه" 
                SortExpression="cg_name" />
            <asp:CommandField ShowEditButton="True" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="#DCDCDC" />
    </asp:GridView>
    <asp:ObjectDataSource ID="ods_UnitsGroup" runat="server" DeleteMethod="Delete" 
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetDataBy" 
        TypeName="MainDataModuleTableAdapters.tbl_units_groupsTableAdapter" 
        UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_cg_id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="cg_name" Type="String" />
            <asp:Parameter Name="cg_exp" Type="String" />
            <asp:Parameter Name="cg_ownerid" Type="Int32" />
            <asp:Parameter Name="Original_cg_id" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter Name="OwnerID" SessionField="OwnerID" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox1" Name="cg_name" PropertyName="Text" 
                Type="String" />
            <asp:Parameter DefaultValue="1" Name="cg_exp" Type="String" />
            <asp:SessionParameter DefaultValue="2" Name="cg_ownerid" SessionField="OwnerID" 
                Type="Int32" />
        </InsertParameters>
    </asp:ObjectDataSource>

</div>