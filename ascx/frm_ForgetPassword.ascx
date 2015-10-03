<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_ForgetPassword.ascx.cs" Inherits="ascx_frm_ForgetPassword" %>

<div style="padding: 7px; font-family: tahoma; font-size: 15px; font-weight: bold; background-color: #EBD7C2">
فراموشی رمز عبور
</div>

<div dir="rtl">
<asp:Panel ID="Panel2" runat="server" CssClass="_pnl" Width="495px">
    <div class="style5">
        <asp:Label ID="Label2" runat="server">فراموشی رمز عبور</asp:Label>
        <table class="style1">
            <tr>
                <td colspan="5" height="20">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label ID="Label1" runat="server" class="_lbl" 
                        Text="لطفا ایمیل خود را وارد نمایید"/>
                    :</td>
                <td class="style8">
                    <asp:TextBox ID="TextBox6" runat="server" CssClass="_txtbox" Width="148px"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;<asp:Button ID="Button2" runat="server" CssClass="_btn" 
                        onclick="Button2_Click" Text=" ارسال " Width="82px" />
                </td>
                <td>
                    <asp:Label ID="Label3" runat="server" CssClass="_lbl" ForeColor="#CC0000" 
                        Text=" " Visible="False"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="Label6" runat="server" CssClass="_lbl" ForeColor="#CC0000" 
                        Text="ایمیل ورودی شما در بانک اطلاعاتی یافت نشد" Visible="False"></asp:Label>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    </div>
    <br />
</asp:Panel>
<asp:Panel ID="Panel3" runat="server" Visible="False">
    <asp:Label ID="Label4" runat="server" 
        Text=" "></asp:Label>
</asp:Panel>

</div>
<asp:Panel ID="Panel4" runat="server" Visible="False">
    <asp:Label ID="Label5" runat="server" 
        Text="رمز عبور نظر به ایمیل ارسال گردید"></asp:Label>
</asp:Panel>
