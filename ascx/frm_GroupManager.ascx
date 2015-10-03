<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_GroupManager.ascx.cs" Inherits="ascx_frm_GroupManager" %>
<div style="padding: 7px; font-family: tahoma; font-size: 15px; font-weight: bold; background-color: #EBD7C2">
مدیریت گروه های کاربری
</div>

<div dir="rtl" style="font-family: tahoma; font-size: 11px">
در این قسمت می توانید گروه های کاربری مورد نظر را تعریف کنید<br />
&nbsp;<table>
        <tr>
            <td>
                نام گروه</td>
            <td>
                <asp:TextBox ID="txt_group_name" runat="server"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                نام صاحب</td>
            <td>
                <asp:DropDownList ID="drp_owner" runat="server" 
                    DataSourceID="ods_ownerList" DataTextField="o_name" DataValueField="o_id">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="ods_ownerList" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    TypeName="MainDataModuleTableAdapters.tbl_OwnerTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_o_id" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="o_name" Type="String" />
                        <asp:Parameter Name="o_datePost" Type="DateTime" />
                        <asp:Parameter Name="Original_o_id" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="o_name" Type="String" />
                        <asp:Parameter Name="o_datePost" Type="DateTime" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </td>
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
        </tr>
    </table>
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="کد" 
        DataSourceID="ods_groups" GridLines="Vertical">
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="کد" HeaderText="کد" InsertVisible="False" 
                ReadOnly="True" SortExpression="کد" />
            <asp:BoundField DataField="نام" HeaderText="نام" SortExpression="نام" />
            <asp:BoundField DataField="توضیحات" HeaderText="توضیحات" 
                SortExpression="توضیحات" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="#DCDCDC" />
    </asp:GridView>
    <asp:ObjectDataSource ID="ods_groups" runat="server" DeleteMethod="Delete" 
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetDataBy3" 
        TypeName="MainDataModuleTableAdapters.tbl_groupsTableAdapter" 
        UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_کد" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="نام" Type="String" />
            <asp:Parameter Name="توضیحات" Type="String" />
            <asp:Parameter Name="Original_کد" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="OwnerID" SessionField="OwnerID" 
                Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="g_name" Type="String" />
            <asp:Parameter Name="g_desc" Type="String" />
            <asp:Parameter Name="g_owner_id_link" Type="Int32" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <br />

</div>