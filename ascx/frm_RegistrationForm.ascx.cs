using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;
using System.Text.RegularExpressions;

public partial class frmRegistrationForm : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void clearform()
    {
        TextBox6.Text = "";
        TextBox15.Text = "";
        TextBox16.Text = "";
        TextBox17.Text = "";
        TextBox18.Text = "";
        TextBox19.Text = "";
        TextBox20.Text = "";
        TextBox21.Text = "";
        TextBox22.Text = "";

    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        if (new main_class().is_user_available_by_username(TextBox23.Text) == false)
        {
            if (new MainDataModuleTableAdapters.tbl_usersTableAdapter().CheckEmail(TextBox18.Text) == 0)
            {

                tbl_usersTableAdapter md = new tbl_usersTableAdapter();
                md.InsertIntoUsers(
                    TextBox23.Text, 
                    new main_class().Encode(TextBox19.Text), 
                    "", 
                    TextBox6.Text, 
                    TextBox15.Text, 
                    TextBox16.Text, 
                    TextBox17.Text, 
                    TextBox18.Text, 
                    TextBox20.Text, 
                    TextBox21.Text, 
                    TextBox22.Text, 
                    Convert.ToInt32(Session["OwnerID"].ToString()));
                pnl_registration_complete.Visible = true;
                pnl_registration_form.Visible = false;
                pnl_registration_forget.Visible = false;
            }
            else
            {
                pnl_registration_complete.Visible = false;
                pnl_registration_form.Visible = false;
                pnl_registration_forget.Visible = true;
       
            }
            /*
            main_class mc = new main_class();
            string str = mc.get_value_from_setting("email_registration_body");
            str = Regex.Replace(str,"000", mc.get_value_from_setting("pub_en_company_name"));
            str = Regex.Replace(str, "001", TextBox23.Text);
            str = Regex.Replace(str, "002", TextBox19.Text);
            str = Regex.Replace(str, "003", TextBox23.Text);
            str = Regex.Replace(str, "004", TextBox19.Text);
            str = Regex.Replace(str, "005", mc.get_value_from_setting("home_page_address"));
            str = Regex.Replace(str, "006", mc.get_value_from_setting("home_page_address"));
            str = Regex.Replace(str, "007", mc.get_value_from_setting("fa_address_of_company"));
            str = Regex.Replace(str, "008", mc.get_value_from_setting("en_address_of_company"));
            mc.send_email(TextBox18.Text, "Registration in " + mc.get_value_from_setting("pub_en_company_name"), str);
            */

        }
        else
        {
            pnl_registration_complete.Visible = false;
            pnl_registration_form.Visible = false;
            pnl_registration_forget.Visible = true;
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        clearform();
        pnl_registration_forget.Visible = false;
        pnl_registration_form.Visible = true;
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/links.aspx?page_id=3"); // loading forgotten pass form
    }
}
