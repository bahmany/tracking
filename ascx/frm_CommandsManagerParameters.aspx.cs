using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ascx_frm_CommandsManagerParameters : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int commandID = Convert.ToInt32(Request.QueryString["commandID"].ToString());

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        ObjectDataSource1.Insert();
        GridView1.DataBind();
        txt_def.Text = "";
        txt_exp.Text = "";
        txt_ParamFaName.Text = "";
        txt_paramName.Text = "";
    }
}
