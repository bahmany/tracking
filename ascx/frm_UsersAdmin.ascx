<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_UsersAdmin.ascx.cs" Inherits="ascx_frm_UsersAdmin" %>
<div style="padding: 7px; font-family: tahoma; font-size: 15px; font-weight: bold; background-color: #EBD7C2">
مدیریت کاربرها
</div>

<%@ Register src="frm_RegistrationForm.ascx" tagname="frm_RegistrationForm" tagprefix="uc1" %>
&nbsp;<asp:LinkButton ID="LinkButton4" runat="server" onclick="LinkButton4_Click1">ایجاد کاربر جدید</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:LinkButton ID="LinkButton5" runat="server" onclick="LinkButton5_Click" >Refresh</asp:LinkButton>


<div style="font-family: tahoma; font-size: 11px" dir="rtl">
    <asp:Panel ID="pnl_add_new_cleint" runat="server" Visible="False">
    <asp:Button ID="Button1" runat="server" Text="Cancel" 
    onclick="Button1_Click" /><br />
<uc1:frm_RegistrationForm ID="frm_RegistrationForm1" runat="server" />


</asp:Panel>

<asp:Panel runat="server" ID="pnl_change_password" Visible="false">
<table>
    <tr>
        <td>
            رمز عبور جدید را وارد نمایید</td>
        <td>
            <asp:TextBox ID="txt_newpass" runat="server"></asp:TextBox></td>
        <td>
            <asp:Button ID="Button2" runat="server" Text="تایید" Width="96px" 
                onclick="Button2_Click" /></td>
    </tr>
</table>
</asp:Panel>

<asp:Panel ID="pnl_change_group" runat="server" Visible="False">
<table>
    <tr>
        <td>
            گروه جدید را انتخاب کنید</td>
        <td>
    
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sds_group" 
                DataTextField="g_name" DataValueField="g_id">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sds_group" runat="server" 
                ConnectionString="<%$ ConnectionStrings:atiehfouladConnectionString %>" 
                SelectCommand="SELECT [g_id], [g_name] FROM [tbl_groups]">
            </asp:SqlDataSource>
    
        <td>
            <asp:Button ID="Button3" runat="server" Text="تایید" Width="96px" onclick="Button3_Click" 
                 /></td>
    </tr>
</table>
</asp:Panel>

<asp:ObjectDataSource ID="ods_users_list" runat="server" 
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
    TypeName="MainDataModuleTableAdapters.tbl_usersListTableAdapter">
</asp:ObjectDataSource>

<asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
    AllowSorting="True" AutoGenerateColumns="False" BackColor="White" 
    BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
    DataKeyNames="کد" DataSourceID="ods_users_list" PageSize="30">
    <RowStyle BackColor="White" ForeColor="#330099" />
    <Columns>
        <asp:BoundField DataField="نام کاربری" HeaderText="نام کاربری" 
            SortExpression="نام کاربری" />
        <asp:BoundField DataField="ایمیل" HeaderText="ایمیل" SortExpression="ایمیل" />
        <asp:BoundField DataField="کد" HeaderText="کد" InsertVisible="False" 
            ReadOnly="True" SortExpression="کد" />
        <asp:BoundField DataField="نام" HeaderText="نام" SortExpression="نام" />
        <asp:BoundField DataField="نام خانوادگی" HeaderText="نام خانوادگی" 
            SortExpression="نام خانوادگی" />
        <asp:BoundField DataField="شرکت" HeaderText="شرکت" SortExpression="شرکت" />
        <asp:BoundField DataField="تماس" HeaderText="تماس" SortExpression="تماس" />
        <asp:BoundField DataField="ضمینه" HeaderText="ضمینه" SortExpression="ضمینه" />
        <asp:BoundField DataField="آشنایی" HeaderText="آشنایی" 
            SortExpression="آشنایی" />
        <asp:BoundField DataField="سایر توضیحات" HeaderText="سایر توضیحات" 
            SortExpression="سایر توضیحات" />
        <asp:TemplateField HeaderText="تغییرات">
            <ItemTemplate>
                <table style="width: 307px; font-size: 11px;">
                    <tr>
                        <td>
                            <asp:LinkButton ID="LinkButton1" OnClick="LinkButtonChangePass_Click" runat="server" ToolTip='<%# Eval("کد") %>'>تغییر رمز عبور</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="LinkButton2" runat="server" ToolTip='<%# Eval("کد") %>' 
                                onclick="LinkButton2_Click">مسدود کردن کاربر</asp:LinkButton>
                        </td>
                        <td class="style1">
                            <asp:LinkButton ID="LinkButton4" runat="server" onclick="LinkButton4_Click2" 
                                ToolTip='<%# Eval("کد") %>'>فعال شدن کاربر</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                OnClick="LinkButtonDELETE_Click" ToolTip='<%# Eval("کد") %>'>حذف کاربر</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="LinkButton5fff" runat="server" 
                                OnClick="LinkButton5fff_Click" ToolTip='<%# Eval("کد") %>'>تغییر گروه</asp:LinkButton>
                        </td>
                        <td>
                            <asp:DropDownList ID="drp_selectOwner" runat="server" AutoPostBack="True" 
                                DataSourceID="ods_owner" DataTextField="o_name" DataValueField="o_id" 
                                onselectedindexchanged="drp_selectOwner_SelectedIndexChanged" 
                                SelectedValue='<%# Bind("[کد مرکز]") %>' ToolTip='<%# Eval("کد") %>'>
                            </asp:DropDownList>
                            <asp:ObjectDataSource ID="ods_owner" runat="server" 
                                OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                                TypeName="MainDataModuleTableAdapters.tbl_ownerTableAdapter">
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="وضعیت" HeaderText="وضعیت" SortExpression="وضعیت" />
    </Columns>
    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
</asp:GridView>



</div>






