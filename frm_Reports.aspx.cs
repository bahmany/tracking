using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;
using Telerik.Web.UI;
using System.Drawing;
using System.Data;

public partial class Reports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {




        tbl_CommandsTableAdapter cm = new tbl_CommandsTableAdapter();
        
        
        string ModuleName = "";
        if (Request.QueryString["pid"] != null)
        {
            ModuleName = Request.QueryString["pid"].ToString();
            ModuleName = new tbl_modulesTableAdapter().GetFormNameFromID(Convert.ToInt32(ModuleName));
            string username = "guest";
            string pass = "pRS+UaJqCcwAcBEcdkJ6UmEQwvtkSm4GGero4+PfWIUrC7XpxXsgxi9xr0ha6paZ";
            if (Request.Cookies["username"] != null && Request.Cookies["password"] != null)
            {
                username = Request.Cookies["username"].Value.ToString();
                pass = Request.Cookies["password"].Value.ToString();
            }
            if (ModuleName != "")
            {
                Control cnt = LoadControl(new main_class().Load_Control(ModuleName, username, pass));
                ph.Controls.Add(cnt);
            }

        }


        if (!IsPostBack)
        {
            trv_units.Nodes.Clear();
            foreach (DataRow dr in new tbl_units_groupsTableAdapter().GetDataBy(Convert.ToInt32(Session["OwnerID"].ToString())))
            {
                RadTreeNode rtn = new RadTreeNode(dr["cg_name"].ToString());
                foreach (DataRow dr1 in new tbl_unitsTableAdapter().GetDataByGroupID(
                    Convert.ToInt32(Session["OwnerID"].ToString()),
                    Convert.ToInt32(dr["cg_id"].ToString())))
                {
                    RadTreeNode rtn1 = new RadTreeNode(dr1["c_unit_id"].ToString());

                    if (dr1["c_family"] != null)
                    {
                        rtn1.ToolTip = dr1["c_family"].ToString();
                    }



                    rtn1.Text = dr1["c_unit_id"].ToString();

                    //rtn1.NavigateUrl = "javascript:ShowLastPostStaticWin(" + dr1["c_unit_id"].ToString() + ")";
                    rtn1.DataBind();
                    
                    
                    rtn1.ForeColor = Color.Black;
                    
                   
                    rtn.Nodes.Add(rtn1);
                    
                   

                }
                trv_units.Nodes.Add(rtn);
                
            }
        }
    }
}
