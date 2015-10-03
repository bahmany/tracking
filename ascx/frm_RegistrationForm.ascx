<%@ Control Language="C#" AutoEventWireup="true" CodeFile="frm_RegistrationForm.ascx.cs" Inherits="frmRegistrationForm" %>
<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>


<div style="font-family: tahoma; font-size: 11px" dir="rtl">


<p>
    <br />
</p>
<asp:Panel ID="pnl_registration_form" runat="server">
    <table>
        <tr>
            <td colspan="5" height="20">
                <asp:Label ID="Label17" runat="server" Font-Size="18px" 
                    Text="فرم ثبت نام"></asp:Label>
                &nbsp;پیام ها

            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" class="_lbl" 
                Text="نام" />
                <span>*</span></td>
            <td class="style8">
                <asp:TextBox ID="TextBox6" runat="server" CssClass="_txtbox" Width="245px"></asp:TextBox>
            </td>
            
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" class="_lbl" 
                Text="نام خانوادگی" />
                <span class="style7">*</span></td>
            <td>
                <asp:TextBox ID="TextBox15" runat="server" CssClass="_txtbox" Width="245px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label3" runat="server" class="_lbl" 
                Text="نام شرکت" />
            </td>
            <td>
                <asp:TextBox ID="TextBox16" runat="server" CssClass="_txtbox" Width="245px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label4" runat="server" class="_lbl" 
                Text="شماره تماس" />
            </td>
            <td>
                <asp:TextBox ID="TextBox17" runat="server" CssClass="_txtbox" Width="245px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label5" runat="server" class="_lbl" 
                Text="ایمیل" />
                <span>*</span></td>
            <td>
                <asp:TextBox ID="TextBox18" runat="server" CssClass="_txtbox" Width="245px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td >
                <asp:Label ID="Label11" runat="server" class="_lbl" 
                Text="نام کاربری" />
                <span>*</span></td>
            <td>
                <asp:TextBox ID="TextBox23" runat="server" CssClass="_txtbox" Width="245px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label6" runat="server" class="_lbl" 
                Text="رمز عبور" />
                <span>*<asp:CompareValidator ID="CompareValidator1" 
                runat="server" ControlToCompare="TextBox19" ControlToValidate="TextBox24" 
                ErrorMessage="  Wrong Password !" ValidationGroup="rereyt"></asp:CompareValidator></span></td>
            <td>
                <asp:TextBox ID="TextBox19" runat="server" CssClass="_txtbox" 
                TextMode="Password" Width="245px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label12" runat="server" class="_lbl" 
                Text="تایید رمز عبود" />
                <span>*</span></td>
            <td>
                <asp:TextBox ID="TextBox24" runat="server" CssClass="_txtbox" 
                TextMode="Password" Width="245px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td >
                <asp:Label ID="Label7" runat="server" class="_lbl" 
                Text="حرفه" />
            </td>
            <td>
                <asp:TextBox ID="TextBox20" runat="server" CssClass="_txtbox" Width="245px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label8" runat="server" class="_lbl" 
                Text="نحوه آشنایی" />
            </td>
            <td >
                <asp:TextBox ID="TextBox21" runat="server" CssClass="_txtbox" Height="99px" 
                Width="284px" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label9" runat="server" class="_lbl" 
                Text="سایر توضیحات" />
            </td>
            <td>
                <asp:TextBox ID="TextBox22" runat="server" CssClass="_txtbox" Width="245px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style8">
                <asp:Button ID="Button1" runat="server" CssClass="_btn" 
                Text="تایید" Width="100px" 
                onclick="Button1_Click" />
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="TextBox6" CssClass="_lbl" 
                    ErrorMessage="نام را وارد کنید" ValidationGroup="rereyt"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="TextBox15" CssClass="_lbl" 
                    ErrorMessage="نام خانوادگی را وارد نمایید" ValidationGroup="rereyt"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="TextBox18" CssClass="_lbl" 
                    ErrorMessage="ایمیل را وارد نمایید" ValidationGroup="rereyt"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ControlToValidate="TextBox19" CssClass="_lbl" 
                    ErrorMessage="رمز عبور را وارد نمایید" ValidationGroup="rereyt"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="TextBox18" CssClass="_lbl" 
                    ErrorMessage="تایید رمز عبور صحیح نمی باشد" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                    ValidationGroup="rereyt"></asp:RegularExpressionValidator>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="pnl_registration_complete" runat="server" Visible="False">
    <asp:Label ID="Label15" runat="server" CssClass="_lbl" 
    ForeColor="#006600" Text="ثبت نام تکمیل شد"></asp:Label>
    <br />
    <asp:HyperLink ID="HyperLink1" runat="server" 
    NavigateUrl="~/homepage.aspx" Text="لینک"></asp:HyperLink>

</asp:Panel>

<asp:Panel ID="pnl_registration_forget" runat="server" Visible="False">
    <asp:Label ID="Label16" runat="server" Font-Bold="True" 
    ForeColor="#990000" style="font-size: xx-large" 
    Text="نام شما در لیست کاربران وجود دارد"></asp:Label>
    <br />
    <asp:Label ID="Label13" runat="server" CssClass="_lbl" 
    ForeColor="#990000" Text="پاک کردن فرم"></asp:Label>
    <br />
    <asp:Button ID="Button2" runat="server" CssClass="_btn" 
    onclick="Button2_Click" Text="دکمه پاک" />
    <br />
    <asp:Label ID="Label14" runat="server" CssClass="_lbl" 
    ForeColor="#990000" Text="فراموشی رمز عبود"></asp:Label>
    <br />
    <asp:Button ID="Button3" runat="server" CssClass="_btn" 
    Text="دگمه فراموشی" 
        onclick="Button3_Click" />

</asp:Panel>

</div>

