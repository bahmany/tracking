using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;

public partial class ascx_frm_CommandsManager : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        ods_commands.Insert();
        GridView1.DataBind();
    }
    protected void LinkButton2_DataBinding(object sender, EventArgs e)
    {

        
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {

    }
    protected void HyperLink1_DataBinding(object sender, EventArgs e)
    {
        int CID = Convert.ToInt32((sender as HyperLink).ToolTip);
        (sender as HyperLink).Text = "    " + new tbl_CommandsParamTableAdapter().GetCommandParamCount(CID).Value.ToString() + "    ";

    }
}
