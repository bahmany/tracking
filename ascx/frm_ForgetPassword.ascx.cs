using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ascx_frm_ForgetPassword : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button2_Click(object sender, EventArgs e)
    {


        if (new main_class().send_user_forgotten_password(TextBox6.Text) == false)
        {
            Label3.Visible = true;
            

        }
        else
        {
            Panel2.Visible = false;
            Panel3.Visible = true;

        }
 
    }
}
