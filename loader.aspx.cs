using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;
using System.Data;


public partial class NvMapSub_loader : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
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
                ph_ascxloader.Controls.Add(cnt);
            }

        }
      
    }
}
