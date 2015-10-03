using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;
using System.Data.SqlClient;
using Telerik.Web.UI;

public partial class frm_Settings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ModuleName = "";
        string username = "guest";
        string pass = "pRS+UaJqCcwAcBEcdkJ6UmEQwvtkSm4GGero4+PfWIUrC7XpxXsgxi9xr0ha6paZ";
        if (Request.Cookies["username"] != null && Request.Cookies["password"] != null)
        {
            username = Request.Cookies["username"].Value.ToString();
            pass = Request.Cookies["password"].Value.ToString();
        }
        
        

        if (Request.QueryString["pid"] != null)
        {
            
            ModuleName = Request.QueryString["pid"].ToString();
            ModuleName = new tbl_modulesTableAdapter().GetFormNameFromID(Convert.ToInt32(ModuleName));

            if (ModuleName != "")
            {
                Control cnt = LoadControl(new main_class().Load_Control(ModuleName, username, pass));
                ph.Controls.Add(cnt);
            }

        }


GeneratingAllTreeViewsItemsAccordingToUserID(username, pass);
      //  if (Session["ctrlTreeState"] != null)
      //  {
            rtv_settings.ExpandAllNodes();

                //= (RadTreeNode) Session["ctrlTreeState"];
      //  }

            if (!IsPostBack)
            {

                if (rtv_settings.SelectedNode != null)
                {
                    
                    // Session["ctrlTreeState"] = rtv_settings.SelectedNode;
                }


            }
            else
            {
                
            }

        


    }





    public void GeneratingAllTreeViewsItemsAccordingToUserID(string UserName, string Password)
    {
        rtv_settings.Nodes.Clear();
        
        string sql =
            "select * from tbl_menu_settings where wms_parentTreeID = 1 and wms_userLevel >= " +
            "(select g_weight from tbl_groups where g_id  = ( select u_group from tbl_users " +
            " where cast(u_username as nvarchar(max)) = '" + UserName +
            "' and cast(u_pass as nvarchar(max)) = '" + Password + "'  ))  order by wms_priority ";
        SqlDataReader dr = new main_class().GetDataReader(sql);
        while (dr.Read())
        {
            RadTreeNode rtn = new RadTreeNode(dr["wms_name"].ToString());
            string trid = "-1";
            if (dr["wms_id"] == null)
            {
                trid = "-1";
            }
            else
            {
                trid = dr["wms_id"].ToString();
            }
            string sqls = "select * from tbl_menu_settings where wms_parentTreeID = " + trid + " and wms_treeWeight = 2 and wms_userLevel >= " +
            "(select g_weight from tbl_groups where g_id  = ( select u_group from tbl_users " +
            " where cast(u_username as nvarchar(max)) = '" + UserName +
            "' and cast(u_pass as nvarchar(max)) = '" + Password + "'  ))  order by wms_priority ";
            SqlDataReader ddr = new main_class().GetDataReader(sqls);
            while (ddr.Read())
            {
                RadTreeNode rtn1 = new RadTreeNode(ddr["wms_name"].ToString());
                rtn1.NavigateUrl = ddr["wms_link"].ToString();
                rtn.Nodes.Add(rtn1);
            }
            if (ddr.HasRows)
            {
                rtv_settings.Nodes.Add(rtn);
            }
            ddr.Close();
        }
     
        dr.Close();

       
    }
    
}
