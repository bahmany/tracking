<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_SettingsChangePassword.ascx.cs" Inherits="ascx_frm_SettingsChangePassword" %>
<div dir="rtl" style="padding: 10px">


    <table>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#003300" 
                    Text="رمز شما تغییر کرد" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                رمز قبلی</td>
            <td>
                <asp:TextBox ID="txt_oldPassword" runat="server" 
                    ontextchanged="TextBox1_TextChanged" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                رمز جدید</td>
            <td>
                <asp:TextBox ID="txt_newPassword" runat="server" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                تکرار رمز جدید<asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToCompare="txt_newPassword" ControlToValidate="txt_newPasswordConfirm" 
                    ErrorMessage="*"></asp:CompareValidator></td>
            <td>
                <asp:TextBox ID="txt_newPasswordConfirm" runat="server" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تائید تغییر رمز عبور</asp:LinkButton>
            </td>
        </tr>
    </table>


</div>