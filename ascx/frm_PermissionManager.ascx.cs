using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ascx_frm_PermissionManager : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (RadioButton1.Checked == true) { GridView2.Visible = true; }
        if (RadioButton2.Checked == true) { GridView1.Visible = true; }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {

        GridView2.Visible = true;
        GridView1.Visible = false;

    }
    protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
    {

        GridView2.Visible = false;
        GridView1.Visible = true;
       
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        int code = Convert.ToInt32((sender as LinkButton).ToolTip.ToString());
        string sql = "select (select top 1 m_fa_name from tbl_modules where m_id =  tbl_users_permission.up_module_link) as [نام ماژول] , up_blocked as [قفل] from tbl_users_permission where tbl_users_permission.up_user_link = " + code.ToString() + " order by up_blocked desc";
        SqlDataSource sds = new SqlDataSource(new main_class().get_connection_string(), sql);
        GridView4.DataSource = sds;
        GridView4.DataBind();

    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        int code = Convert.ToInt32((sender as LinkButton).ToolTip.ToString());
        string sql = "select (select top 1 m_fa_name from tbl_modules where m_id =  tbl_groups_permission.gd_module_link) as [نام ماژول] , gd_blocked as [قفل] from tbl_groups_permission where tbl_groups_permission.gd_tbl_groups_link = " + code.ToString() + " order by gd_blocked desc";
        SqlDataSource sds = new SqlDataSource(new main_class().get_connection_string(), sql);
        GridView4.DataSource = sds;
        GridView4.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        main_class mc = new main_class();
// vvvvv for editing group permission
        if (GridView2.Visible == true)
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                int GroupID = (int)GridView2.DataKeys[i][0];
                CheckBox cb = (CheckBox)GridView2.Rows[i].FindControl("chk_select");
                if (cb.Checked)
                {

                    for (int y = 0; y < GridView3.Rows.Count; y++)
                    {
                        int ModuleID = (int)GridView3.DataKeys[y][0];
                        ListItem li = (ListItem)(GridView3.Rows[y].FindControl("ListBox1") as ListBox).SelectedItem;
                        if (li != null)
                        {
                            mc.execute_command(string.Format("delete from tbl_groups_permission where gd_tbl_groups_link={0} and gd_module_link={1}", GroupID.ToString(), ModuleID.ToString()));
                            mc.execute_command(string.Format("insert into tbl_groups_permission (gd_tbl_groups_link,gd_module_link,gd_blocked) values ({0},{1},{2})", GroupID.ToString(), ModuleID.ToString(), li.Value.ToString()));
                        }
                    }
                }
            }
        }

// vvvvv for editing user permission
        if (GridView1.Visible == true)
        {
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                int UserID = (int)GridView1.DataKeys[i][0];
                CheckBox cb = (CheckBox)GridView1.Rows[i].FindControl("chk_select");
                if (cb.Checked)
                {

                    for (int y = 0; y < GridView3.Rows.Count; y++)
                    {
                        int ModuleID = (int)GridView3.DataKeys[y][0];
                        ListItem li = (ListItem)(GridView3.Rows[y].FindControl("ListBox1") as ListBox).SelectedItem;
                        if (li != null)
                        {
                            mc.execute_command(string.Format("delete from tbl_users_permission where up_user_link={0} and up_module_link={1}", UserID.ToString(), ModuleID.ToString()));
                            mc.execute_command(string.Format("insert into tbl_users_permission (up_user_link,up_module_link,up_blocked) values ({0},{1},{2})", UserID.ToString(), ModuleID.ToString(), li.Value.ToString()));
                        }
                    }
                }
            }
        }
    
    
    
    
    
    
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        GridView3.DataBind();
    }
}
