using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;

public partial class ascx_frm_SettingsChangePassword : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txt_oldPassword.Text = "";

        }
    }
    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string hashedNewPass = new main_class().Encode(txt_newPassword.Text);
        string hashedOldPass = new main_class().Encode(txt_oldPassword.Text);
        string uname = Session["username"].ToString();
        txt_newPassword.Text = "";
        txt_newPasswordConfirm.Text = "";
        txt_oldPassword.Text = "";
        if (
            (new tbl_usersTableAdapter().ChangePassword(
            hashedNewPass,
            hashedOldPass,
            uname
            )) == 1)
        {
            Label1.Visible = true;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ds", "alert('رمز شما تغییر کرد');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ds", "alert('لطفا رمز عبور را صحیح وارد نمایید');", true);

        }

    }
}
