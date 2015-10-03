using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;

public partial class ascx_frm_UsersAdmin : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
 
    }
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
       
    }
    protected void LinkButton4_Click1(object sender, EventArgs e)
    {
        
        pnl_add_new_cleint.Visible = true;

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        pnl_add_new_cleint.Visible = false;
    }
    protected void LinkButton5_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void LinkButtonDELETE_Click(object sender, EventArgs e)
    {
        try
        {
            MainDataModuleTableAdapters.tbl_usersListTableAdapter mdmta = new MainDataModuleTableAdapters.tbl_usersListTableAdapter();
            mdmta.DeleteQuery(Convert.ToInt32((sender as LinkButton).ToolTip.ToString()));

            GridView1.DataBind();
        }
        catch
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Noooo", "alert('حذف این کاربر امکان پذیر نیست')");
        }
    }
    protected void LinkButtonChangePass_Click(object sender, EventArgs e)
    {
        pnl_change_password.Visible = true;
        Session["UserID"] = (sender as LinkButton).ToolTip.ToString();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            MainDataModuleTableAdapters.tbl_usersListTableAdapter mdmta = new MainDataModuleTableAdapters.tbl_usersListTableAdapter();
            mdmta.UpdateQuery(new main_class().Encode(txt_newpass.Text), Convert.ToInt32(Session["UserID"].ToString()));
            pnl_change_password.Visible = false;
        }
        catch (Exception ee)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Noooo", "alert('تغییر رمز این کاربر امکان پذیر نیست')" + ee.Message.ToString());
        }
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        MainDataModuleTableAdapters.tbl_usersListTableAdapter mdmta = new MainDataModuleTableAdapters.tbl_usersListTableAdapter();
        mdmta.UpdateQuery_ChangeBlock(false,Convert.ToInt32((sender as LinkButton).ToolTip.ToString()));
        GridView1.DataBind();
    }
    protected void LinkButton4_Click2(object sender, EventArgs e)
    {
        MainDataModuleTableAdapters.tbl_usersListTableAdapter mdmta = new MainDataModuleTableAdapters.tbl_usersListTableAdapter();
        mdmta.UpdateQuery_ChangeBlock(true,Convert.ToInt32((sender as LinkButton).ToolTip.ToString()) );
        GridView1.DataBind();
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        try
        {
            MainDataModuleTableAdapters.tbl_usersListTableAdapter mdmta = new MainDataModuleTableAdapters.tbl_usersListTableAdapter();
            mdmta.UpdateQuery_ChangeGroup(Convert.ToInt32(DropDownList1.SelectedValue.ToString()), Convert.ToInt32(Session["UserID"].ToString()));
            pnl_change_group.Visible = false;
        }
        catch (Exception ee)
        {
            Page.ClientScript.RegisterClientScriptBlock(GetType(), "Noooo", "alert('تغییر رمز این کاربر امکان پذیر نیست')" + ee.Message.ToString());
        }
 
    }
    protected void LinkButton5fff_Click(object sender, EventArgs e)
    {
        pnl_change_group.Visible = true;
        Session["UserID"] = (sender as LinkButton).ToolTip.ToString();

    }
    protected void drp_selectOwner_SelectedIndexChanged(object sender, EventArgs e)
    {
        new tbl_unitsTableAdapter().ChangeOwner(Convert.ToInt32((sender as DropDownList).SelectedValue), Convert.ToInt32((sender as DropDownList).ToolTip));
        GridView1.DataBind();
    }
}
