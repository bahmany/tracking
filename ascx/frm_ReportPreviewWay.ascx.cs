using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;

public partial class ascx_frm_ReportPreviewWay : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            OutMapController omc = new OutMapController();
            txt_from.Text =  omc.ConvertToShamsi(DateTime.Now.AddDays(-1), 1) +" 00:01";
            txt_to.Text =  omc.ConvertToShamsi(DateTime.Now, 1) +" 23:59";
        }
       
        /**/
        
        string UnitSeriesName = "";
        try
        {
            int unitMode = Convert.ToInt16(new tbl_unitsTableAdapter().GetUnitIDModel(Convert.ToInt32(Session["OwnerID"].ToString())));

            if (unitMode == 1) UnitSeriesName = "X1";
            if (unitMode == 2) UnitSeriesName = "A1";
            if (unitMode == 3) UnitSeriesName = "P1";

        }
        catch (Exception __e)
        {
            UnitSeriesName = "X1";
        }
        
        ods_RepID.SelectParameters["RepUnitModel"].DefaultValue = UnitSeriesName;
    }


    public void getFilterString()
    {

    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }
}
