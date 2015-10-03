using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Data.SqlClient;
using System.Data;

public partial class frm_Commands : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["UnitID"] != null)
        {
            lbl_UnitID.Text = Session["UnitID"].ToString();

        }

        if (Request.Params["HWguid"] != null)
        {
            Session["HWguid"] = Request.Params["HWguid"].ToString();
        }
        if (!IsPostBack)
        {
            #region Get Parameter

            int par_ID1 = 0;
            string par_ID2 = "";

            if (Request.Params["ID1"] != null)
            {
                if (Request.Params["ID2"] != null)
                {
                    
                    string strC = "Data Source=.;Initial Catalog=AriaAG;Persist Security Info=True;User ID=sa;PassWord=009100";
                    string gu = Session["HWguid"].ToString();
                    
                    par_ID1 = Convert.ToInt32(Request.Params["ID1"].ToString());
                    par_ID2 = Convert.ToString(Request.Params["ID2"].ToString());
                    FormRunTime_F f = new FormRunTime_F();
                    if (f.CheckParamBug(par_ID1) == true)
                    {

                        f.InsertDateToDB(par_ID1, par_ID2,gu, Page, strC, true);
                    }
                    else
                    {
                        string error = "Unable to Insert";
                    }
                }
            }

            #endregion;
        }
    }






    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string str = "Data Source=.;Initial Catalog=AriaAG;Persist Security Info=True;User ID=sa;PassWord=009100";
        FormRunTime_F f = new FormRunTime_F();
        f.CommandsDesign(Session["HWguid"].ToString(), 2, Page, "frm_Commands.aspx", str, 2, "lblMainTitle", "lblMainValue", "lblStbTitle", "lblStbDESC", "txt", "btn");
        str = f.mainHtml;

    }
}
