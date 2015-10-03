<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_PermissionManager.ascx.cs" Inherits="ascx_frm_PermissionManager" %>

<div style="padding: 7px; font-family: tahoma; font-size: 15px; font-weight: bold; background-color: #EBD7C2">
مدیریت دسترسی ها
</div>


<div dir="rtl">
    <table>
        <tr>
            <td>
                نوع کاربری</td>
            <td class="style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:RadioButton ID="RadioButton1" runat="server" Text="گروه" 
                    AutoPostBack="True" Checked="True" GroupName="sasas" 
                    oncheckedchanged="RadioButton1_CheckedChanged" />
&nbsp;( اعمال محدودیت برای یک گروه خاص )<br />
                <asp:RadioButton ID="RadioButton2" runat="server" Text="کاربر" 
                    AutoPostBack="True" GroupName="sasas" 
                    oncheckedchanged="RadioButton2_CheckedChanged" />
&nbsp;( اعمال محدودیت برای یک کاربر خاص )</td>
            <td class="style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr style="height: 250px; width: 100%; overflow: scroll;">
            <td>
                انتخاب نام کاربر یا گروه کاربری

                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="کد" DataSourceID="ods_userlist" 
                    onselectedindexchanged="GridView1_SelectedIndexChanged" 
                    AllowSorting="True" BackColor="White" BorderColor="#CC9966" BorderStyle="None" 
                    BorderWidth="1px" CellPadding="4" Caption="جدول کاربرها" Visible="False">
                    <RowStyle BackColor="White" ForeColor="#330099" />
                    <Columns>
                        <asp:TemplateField HeaderText="انتخاب">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" ToolTip='<%# Eval("کد") %>' 
                                    onclick="LinkButton1_Click">انتخاب</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="نام کاربری" HeaderText="نام کاربری" 
                            SortExpression="نام کاربری" />
                        <asp:BoundField DataField="ایمیل" HeaderText="ایمیل" SortExpression="ایمیل" />
                        <asp:BoundField DataField="کد" HeaderText="کد" InsertVisible="False" 
                            ReadOnly="True" SortExpression="کد" />
                        <asp:BoundField DataField="نام" HeaderText="نام" SortExpression="نام" />
                        <asp:BoundField DataField="نام خانوادگی" HeaderText="نام خانوادگی" 
                            SortExpression="نام خانوادگی" />
                        <asp:TemplateField HeaderText="انتخاب ها">
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_select" runat="server" Text="انتخاب" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                </asp:GridView>
                <asp:ObjectDataSource ID="ods_userlist" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="MainDataModuleTableAdapters.tbl_usersListTableAdapter">
                </asp:ObjectDataSource>
                <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="کد" 
                    DataSourceID="sqld_group" Caption="جدول گروه ها" RowHeaderColumn="کد" 
                    ShowFooter="True" Visible="False">
                    <RowStyle BackColor="White" ForeColor="#330099" />
                    <Columns>
                        <asp:TemplateField HeaderText="انتخاب">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" ToolTip='<%# Eval("کد") %>' 
                                    onclick="LinkButton2_Click">انتخاب</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="کد" HeaderText="کد" InsertVisible="False" 
                            ReadOnly="True" SortExpression="کد" />
                        <asp:BoundField DataField="نام" HeaderText="نام" SortExpression="نام" />
                        <asp:TemplateField HeaderText="انتخاب">
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_select" runat="server" Text="انتخاب" 
                                    ToolTip='<%# Eval("کد") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                </asp:GridView>
                <asp:ObjectDataSource ID="sqld_group" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
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
                    <InsertParameters>
                        <asp:Parameter Name="نام" Type="String" />
                        <asp:Parameter Name="توضیحات" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </td>
            <td class="style1" 
                style="border-left-style: solid; border-left-width: thin; border-left-color: #333333">
            
                &nbsp;&nbsp;&nbsp; &nbsp;</td>
            <td>
            </td>
            <td><asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="Reset" 
                    Width="88px" />
              انتخاب ماژول<asp:GridView ID="GridView3" runat="server" 
                    AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="کد" 
                    DataSourceID="odc_modules" AllowSorting="True">
                    <RowStyle BackColor="White" ForeColor="#330099" />
                    <Columns>
                        <asp:TemplateField HeaderText="انتخاب">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton3" runat="server">انتخاب</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="نام" HeaderText="نام" SortExpression="نام" />
                        <asp:TemplateField HeaderText="انتخاب">
                            <ItemTemplate>
                                <asp:ListBox ID="ListBox1" runat="server" Font-Names="Tahoma" Font-Size="11px" 
                                    Height="33px" Width="79px">
                                    <asp:ListItem Value="0">مجاز</asp:ListItem>
                                    <asp:ListItem Value="1">غیر مجاز</asp:ListItem>
                                </asp:ListBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="کد" ReadOnly="True" SortExpression="کد" />
                    </Columns>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                </asp:GridView>
                <asp:ObjectDataSource ID="odc_modules" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="MainDataModuleTableAdapters.tbl_modulesTableAdapter">
                </asp:ObjectDataSource>
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="تائید" 
                    Width="82px" />
            </td>
        </tr>
        <tr style="height: 250px; overflow: scroll">
        <td>
                   <asp:GridView ID="GridView4" runat="server" BackColor="White" 
                       BorderColor="#999999" BorderStyle="None" BorderWidth="1px" 
                       Caption="ماژول های دارای دسترسی" CellPadding="3" GridLines="Vertical">
                       <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                       <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                       <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                       <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                       <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                       <AlternatingRowStyle BackColor="#DCDCDC" />
                   </asp:GridView>
                   <br />
                <br />
                   <br />
            <br /></td>
        </tr> 
        
            
               
    </table>
</div>