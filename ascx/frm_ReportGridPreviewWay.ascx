<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_ReportGridPreviewWay.ascx.cs" Inherits="ascx_frm_ReportGridPreviewWay" %>
<div dir="rtl" style="font-family: tahoma; font-size: 12px;">

    <asp:GridView ID="GridView1" runat="server" BackColor="White" 
        BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
        GridLines="Vertical" Height="131px">
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <EmptyDataTemplate>
            اطلاعاتی یافت نشد
        </EmptyDataTemplate>
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="#DCDCDC" />
    </asp:GridView>

</div>