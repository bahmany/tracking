<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frm_CommandsManagerParameters.aspx.cs" Inherits="ascx_frm_CommandsManagerParameters" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <form id="form1" runat="server">
    <div dir="rtl" style="font-family: tahoma; font-size: 12px; background-color: #FFFFFF">
    
        <table>
            <tr>
                <td>
                    نام پارامتر:
                </td>
                <td style="margin-right: 40px">
                    <asp:TextBox ID="txt_paramName" runat="server" Width="82px"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    نام فارسی
                </td>
                <td>
                    <asp:TextBox ID="txt_ParamFaName" runat="server" Width="106px"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    توضیحات</td>
                <td>
                    <asp:TextBox ID="txt_exp" runat="server" Width="80px"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    مقدار پیش فرض</td>
                <td>
                    <asp:TextBox ID="txt_def" runat="server" Width="104px"></asp:TextBox>
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
                    <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تائید</asp:LinkButton>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" 
            CellPadding="3" DataKeyNames="cmdp_id" DataSourceID="ObjectDataSource1" 
            GridLines="Vertical">
            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
            <Columns>
                <asp:BoundField DataField="cmdp_name" HeaderText="نام پارامتر" 
                    SortExpression="cmdp_name" />
                <asp:BoundField DataField="cmdp_faname" HeaderText="نام فارسی" 
                    SortExpression="cmdp_faname" />
                <asp:BoundField DataField="cmdp_desc" HeaderText="توضیحات" 
                    SortExpression="cmdp_desc" />
                <asp:BoundField DataField="cmdp_defaultParam" HeaderText="مقدار پیش فرض" 
                    SortExpression="cmdp_defaultParam" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="#DCDCDC" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
            DeleteMethod="Delete" InsertMethod="Insert" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCommandID" 
            TypeName="MainDataModuleTableAdapters.tbl_CommandsParamTableAdapter" 
            UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_cmdp_id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="cmdp_desc" Type="String" />
                <asp:Parameter Name="cmdp_defaultParam" Type="String" />
                <asp:Parameter Name="cmdp_name" Type="String" />
                <asp:Parameter Name="cmdp_faname" Type="String" />
                <asp:Parameter Name="Original_cmdp_id" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="CommandID" QueryStringField="commandID" 
                    Type="Int32" />
            </SelectParameters>
            <InsertParameters>
                <asp:QueryStringParameter Name="cmdp_link_to_tblCommands" 
                    QueryStringField="commandID" Type="Int32" />
                <asp:ControlParameter ControlID="txt_exp" Name="cmdp_desc" PropertyName="Text" 
                    Type="String" />
                <asp:Parameter DefaultValue="1" Name="cmdp_type" Type="Int32" />
                <asp:ControlParameter ControlID="txt_def" DefaultValue="" 
                    Name="cmdp_defaultParam" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txt_paramName" Name="cmdp_name" 
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txt_ParamFaName" Name="cmdp_faname" 
                    PropertyName="Text" Type="String" />
                <asp:Parameter DefaultValue="1" Name="cmdp_check_from" Type="Int32" />
                <asp:Parameter DefaultValue="999999999" Name="cmdp_check_to" Type="Int32" />
            </InsertParameters>
        </asp:ObjectDataSource>
    
    </div>
    </form>
</body>
</html>
