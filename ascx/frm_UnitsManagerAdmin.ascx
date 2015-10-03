<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_UnitsManagerAdmin.ascx.cs" Inherits="ascx_frm_UnitsManagerAdmin" %>

<div style="padding: 7px; font-family: tahoma; font-size: 15px; font-weight: bold; background-color: #EBD7C2">
مدیریت کلی دستگاهها
</div>

<div dir="rtl" style="font-family: tahoma; font-size: 11px">

    <table>
        <tr>
            <td>
                انتخاب صاحب</td>
            <td>
                <asp:DropDownList ID="drp_ownerID" runat="server" AutoPostBack="True" 
                    DataSourceID="ods_OwnerList" DataTextField="o_name" DataValueField="o_id" 
                    onselectedindexchanged="drp_ownerID_SelectedIndexChanged" Width="327px">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="ods_OwnerList" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetDataOrderByOwnerName" 
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
                گروه</td>
            <td>
                <asp:DropDownList ID="drp_unitsGroupList" runat="server" 
                    DataSourceID="ObjectDataSource1" DataTextField="cg_name" DataValueField="cg_id" 
                    Width="327px">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                    DeleteMethod="Delete" InsertMethod="Insert" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBy" 
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
                        <asp:ControlParameter ControlID="drp_ownerID" Name="OwnerID" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="cg_name" Type="String" />
                        <asp:Parameter Name="cg_exp" Type="String" />
                        <asp:Parameter Name="cg_ownerid" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                کد سخت افزار</td>
            <td>
                <asp:TextBox ID="SelectedValue" runat="server" Width="263px"></asp:TextBox>
            </td>
            <td>
                X1 series : 1xxxxxxxxx<br />
                A1 series : 2xxxxxxxxx<br />
                P1 series : 3xxxxxxxxx</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:LinkButton ID="lnk_post" runat="server" onclick="lnk_post_Click">ثبت</asp:LinkButton>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="lnk_delete" runat="server" onclick="lnk_delete_Click">حذف</asp:LinkButton>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="c_id" 
        DataSourceID="ods_UnitsList" GridLines="Vertical">
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <Columns>
            <asp:BoundField DataField="c_id" HeaderText="کد" InsertVisible="False" 
                ReadOnly="True" SortExpression="c_id" />
            <asp:BoundField DataField="c_unit_id" HeaderText="کد دستگاه" 
                SortExpression="c_unit_id" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click" 
                        ToolTip='<%# Eval("c_id") %>'>ویرایش</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="#DCDCDC" />
    </asp:GridView>
    <asp:ObjectDataSource ID="ods_UnitsList" runat="server" 
        DeleteMethod="DeleteQuery" InsertMethod="InsertQuery" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="MainDataModuleTableAdapters.tbl_unitsTableAdapter" 
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="UnitROWID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="c_group_link" Type="Int32" />
            <asp:Parameter Name="c_name" Type="String" />
            <asp:Parameter Name="c_family" Type="String" />
            <asp:Parameter Name="c_sex" Type="Int32" />
            <asp:Parameter Name="c_birth_date" Type="String" />
            <asp:Parameter Name="c_postal_code" Type="String" />
            <asp:Parameter Name="c_melli_code" Type="String" />
            <asp:Parameter Name="c_shsh" Type="String" />
            <asp:Parameter Name="c_phonelineno" Type="String" />
            <asp:Parameter Name="c_address" Type="String" />
            <asp:Parameter Name="c_phoneline_necessary" Type="String" />
            <asp:Parameter Name="c_address_necessary" Type="String" />
            <asp:Parameter Name="c_handcode" Type="String" />
            <asp:Parameter Name="c_owner_link" Type="Int32" />
            <asp:Parameter Name="c_unit_id" Type="Int32" />
            <asp:Parameter Name="c_car_no" Type="String" />
            <asp:Parameter Name="c_car_bimeh" Type="String" />
            <asp:Parameter Name="c_car_badaneh" Type="String" />
            <asp:Parameter Name="c_car_cellno" Type="String" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="drp_ownerID" Name="c_owner_link" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="c_owner_link" Type="Int32" />
            <asp:Parameter Name="c_group_link" Type="Int32" />
            <asp:Parameter Name="c_name" Type="String" />
            <asp:Parameter Name="c_family" Type="String" />
            <asp:Parameter Name="c_sex" Type="Int32" />
            <asp:Parameter Name="c_birth_date" Type="String" />
            <asp:Parameter Name="c_postal_code" Type="String" />
            <asp:Parameter Name="c_melli_code" Type="String" />
            <asp:Parameter Name="c_shsh" Type="String" />
            <asp:Parameter Name="c_phonelineno" Type="String" />
            <asp:Parameter Name="c_address" Type="String" />
            <asp:Parameter Name="c_phoneline_necessary" Type="String" />
            <asp:Parameter Name="c_address_necessary" Type="String" />
            <asp:Parameter Name="c_handcode" Type="String" />
            <asp:Parameter Name="c_unit_id" Type="Int32" />
            <asp:Parameter Name="c_car_no" Type="String" />
            <asp:Parameter Name="c_car_bimeh" Type="String" />
            <asp:Parameter Name="c_car_badaneh" Type="String" />
            <asp:Parameter Name="c_car_cellno" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>

</div>