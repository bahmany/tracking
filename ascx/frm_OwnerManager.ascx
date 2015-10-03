<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_OwnerManager.ascx.cs" Inherits="ascx_frm_OwnerAdd" %>
<div dir="rtl" style="font-family: tahoma; font-size: 11px">
<div style="padding: 7px; font-family: tahoma; font-size: 15px; font-weight: bold; background-color: #EBD7C2">
ورود اطلاعات صاحبان سیستم
</div>
    <br />
در این قسمت می توانید نام صاحب اصلی خریدار سیستم را وارد نمایید<br />
    توجه داشته باشید کاربرانی که از نرم افزار استفاده می کنند تحت صاحبان خود&nbsp; 
    از سیستم استفاده می کنند<br />
&nbsp;<table>
        <tr>
            <td colspan="2">
                لطفا نام صاحب دستگاهها را وارد کنید</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                نام شرکت / صاحب</td>
            <td>
                <asp:TextBox ID="txt_ownerName" runat="server"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تائید</asp:LinkButton>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
<div>

    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="o_id" 
        DataSourceID="ods_OwnerList" GridLines="Vertical">
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <Columns>
            <asp:BoundField DataField="o_id" HeaderText="کد" ReadOnly="True" 
                SortExpression="o_id" />
            <asp:BoundField DataField="o_name" HeaderText="نام" SortExpression="o_name" />
            <asp:BoundField DataField="o_shdatePost" HeaderText="تاریخ ثبت" ReadOnly="True" 
                SortExpression="o_shdatePost" />
            <asp:BoundField DataField="o_datePost" HeaderText="تاریخ ثبت" 
                SortExpression="o_datePost" />
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="Gainsboro" />
    </asp:GridView>
    <asp:ObjectDataSource ID="ods_OwnerList" runat="server" DeleteMethod="Delete" 
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

    <br />

</div>
</div>
