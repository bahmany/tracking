using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;

public partial class ascx_frm_GroupManager : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        new tbl_groupsTableAdapter().Insert(txt_group_name.Text, "", Convert.ToInt32(Session["OwnerID"].ToString()));
        GridView1.DataBind();
    }
}
