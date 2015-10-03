using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ascx_frm_ReportsIDManager : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lnk_post_Click(object sender, EventArgs e)
    {
        ods_repDef.Insert();
        GridView1.DataBind();
    }
}
