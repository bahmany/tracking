using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;

public partial class ascx_frm_OwnerAdd : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (txt_ownerName.Text != "")
        {
            new tbl_OwnerTableAdapter().InsertQuery(txt_ownerName.Text);
            GridView1.DataBind();
        }
    }
}
