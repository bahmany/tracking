<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_CommandsManager.ascx.cs" Inherits="ascx_frm_CommandsManager" %>

<script type="text/javascript">
        var newwindow;
        function poptop(url) {
            var w = 370;
            var h = 405;
            var left = (screen.width / 2) - (w / 2);
            var top = (screen.height / 2) - (h / 2);
            newwindow = window.open(url, 'name', 'height=' + h + ',width=' + w + ', top=' + top + ', left=' + left);
            if (window.focus) {
                newwindow.focus()
            }
        }

        function poptop22(num) {

            poptop('ascx/frm_CommandsManagerParameters.aspx?commandid=' + num);
        }</script>
        
<div dir="rtl" style="font-family: tahoma; font-size: 11px; background-color: #FFFFFF">

    <br />
    <table>
        <tr>
            <td>
                ایجاد دستور جدید :
            </td>
            <td>
                نام دستور:&nbsp;&nbsp;
            </td>
            <td>
                <asp:TextBox ID="txt_commandname" runat="server"></asp:TextBox>
            </td>
            <td>
                &nbsp;&nbsp;&nbsp; نام فارسی دستور: &nbsp;</td>
            <td style="margin-right: 40px">
                <asp:TextBox ID="txt_commandFaName" runat="server"></asp:TextBox>
            </td>
            <td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; توضیحات&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td>
                <asp:TextBox ID="txt_commandFaExp" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تائید</asp:LinkButton>
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
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
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
        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="cmd_id" 
        DataSourceID="ods_commands" GridLines="Vertical" Width="100%">
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <Columns>
            <asp:BoundField DataField="cmd_id" HeaderText="cmd_id" InsertVisible="False" 
                ReadOnly="True" SortExpression="cmd_id" />
            <asp:BoundField DataField="cmd_name" HeaderText="cmd_name" 
                SortExpression="cmd_name" />
            <asp:BoundField DataField="cmd_fa_name" HeaderText="cmd_fa_name" 
                SortExpression="cmd_fa_name" />
            <asp:BoundField DataField="cmd_desc" HeaderText="cmd_desc" 
                SortExpression="cmd_desc" />
            <asp:CommandField DeleteText="حذف دستور" EditText="ویرایش دستور" 
                ShowDeleteButton="True" ShowEditButton="True" />
            <asp:TemplateField HeaderText="پارامترها">
                <ItemTemplate>
                    &nbsp;
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# Eval("cmd_id", "javascript:poptop22({0})") %>' 
                        ondatabinding="HyperLink1_DataBinding" ToolTip='<%# Eval("cmd_id") %>' 
                        Text='<%# Eval("cmd_id") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="#DCDCDC" />
    </asp:GridView>
        <asp:ObjectDataSource ID="ods_commands" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    TypeName="MainDataModuleTableAdapters.tbl_CommandsTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_cmd_id" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="cmd_name" Type="String" />
                        <asp:Parameter Name="cmd_fa_name" Type="String" />
                        <asp:Parameter Name="cmd_desc" Type="String" />
                        <asp:Parameter Name="Original_cmd_id" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="txt_commandname" Name="cmd_name" 
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="txt_commandFaName" Name="cmd_fa_name" 
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="txt_commandFaExp" Name="cmd_desc" 
                            PropertyName="Text" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
   
</div>