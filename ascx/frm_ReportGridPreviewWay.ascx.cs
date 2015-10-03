using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using MainDataModuleTableAdapters;

public partial class ascx_frm_ReportGridPreviewWay : System.Web.UI.UserControl
{

    public static bool IsInteger(string theValue)
    {
        try
        {
            Convert.ToInt32(theValue);
            return true;
        }
        catch
        {
            return false;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        /*
         
         * 
         * 
         * 
         * 
         *     var chk_filter_reportID = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_filter_io").checked;
    var dtFrom = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_from").value;
    var dtTo = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_to").value;
    var chk_ibit0 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit0_ignition").checked;
    var chk_ibit1 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit1_input1").checked;
    var chk_ibit2 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit2_input2").checked;
    var chk_ibit3 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit3_input3").checked;
    var chk_ibit4 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit4_input4").checked;
    var chk_obit1 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit1_output1").checked;
    var chk_obit2 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit2_output2").checked;
    var chk_obit3 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit3_output3").checked;
    var chk_obit4 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit4_output4").checked;
    var chk_chk_filter_speed = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_filter_speed").checked;
    var drp_speed_select_arrows = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_drp_speed_select_arrows").value;
    var txt_speed_km = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_speed_km").value;
    var chk_filter_geo = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_filter_geo").checked;
    var txt_geo_center_name = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_geo_center_name").value;
    var txt_geo_center_km = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_geo_center_km").value;
         * 
         *     var stringQuery = "tp=prvw&chksen="+chkRepIdLists+"&cfr="+chk_filter_reportID+
         *     "&df="+dtFrom+"&dt="+dtTo+"&ci0="+chk_ibit0+"&ci1="+chk_ibit1+"&ci2="+chk_ibit2+
    "&ci3="+chk_ibit3+"&ci4="+chk_ibit4+"&co1="+chk_obit1+"&co2="+chk_obit2+"&co3="+
            chk_obit3+"&co4="+chk_obit4+"&cfs="+chk_chk_filter_speed+"&cssg="+drp_speed_select_arrows+
            "&tsk="+txt_speed_km+"&cfgeo="+chk_filter_geo+"&cgcn="+txt_geo_center_name+
            "&gck="+txt_geo_center_km+"";
         * 
         * 
         * tp=prvw&chksen=&cfr=false&df=1389/09/02 00:01&dt=1389/09/03 23:59&
         * ci0=false&ci1=false&ci2=false&ci3=false&ci4=false&co1=false&co2=false&co3=false&co4=false&
         * cfs=false&cssg=>&tsk=&cfgeo=false&cgcn=&gck=
        */

    
            string chk_filter_reportID = Request.QueryString["cfr"].ToString();
            string chkRepIdLists = Request.QueryString["chksen"].ToString();

            string dtFrom = Request.QueryString["df"].ToString();
            string dtTo = Request.QueryString["dt"].ToString();

            string chk_ibit0 = Request.QueryString["ci0"].ToString();
            string chk_ibit1 = Request.QueryString["ci1"].ToString();
            string chk_ibit2 = Request.QueryString["ci2"].ToString();
            string chk_ibit3 = Request.QueryString["ci3"].ToString();
            string chk_ibit4 = Request.QueryString["ci4"].ToString();
            string chk_obit1 = Request.QueryString["co1"].ToString();
            string chk_obit2 = Request.QueryString["co2"].ToString();
            string chk_obit3 = Request.QueryString["co3"].ToString();
            string chk_obit4 = Request.QueryString["co4"].ToString();
            string chk_chk_filter_speed = Request.QueryString["cfs"].ToString();
            string drp_speed_select_arrows = Request.QueryString["cssg"].ToString();
            string txt_speed_km = Request.QueryString["tsk"].ToString();
            string chk_filter_geo = Request.QueryString["cfgeo"].ToString();
            string txt_geo_center_name = Request.QueryString["cgcn"].ToString();
            string txt_geo_center_km = Request.QueryString["gck"].ToString();

            string selcar = Request.QueryString["selcar"].ToString();

        // for selected cars
            string[] arselcat;
            arselcat = selcar.Split('x');
            selcar = "";
            for (int i = 0; i < arselcat.Length; i++)
            {
                if (IsInteger(arselcat[i]))
                {
                if (selcar != "")
                {
                    selcar =  "," + selcar ;
                }
                selcar = arselcat[i] + selcar;
                }
            }
            if (selcar == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "j1", "alert('لطفا یکی از وسایط نقلیه را انتخاب نمایید')",true);
                Response.Redirect(Request.Url.PathAndQuery);
            }
            
        //------------------------

        // for selected reports
            if (chkRepIdLists != null)
            {
                string[] archkRepIdLists;
                archkRepIdLists = chkRepIdLists.Split('-');
                chkRepIdLists = "";

                for (int i = 0; i < archkRepIdLists.Length; i++)
                {
                    if (IsInteger(archkRepIdLists[i]))
                    {
                        if (chkRepIdLists != "")
                        {
                            chkRepIdLists = "," + chkRepIdLists;
                        }
                        chkRepIdLists = archkRepIdLists[i] + chkRepIdLists;
                    }
                }

            }
        //---------------
        // filter speed
            //chk_chk_filter_speed 
            //drp_speed_select_arrows
            //txt_speed_km
            string filterspeed = "";
            if (chk_chk_filter_speed == "true")
            {
                filterspeed = " and ( gd_speed " + drp_speed_select_arrows + " " + txt_speed_km + " )";
            }


        //---------------------------

            if (chkRepIdLists != "")
            {
                chkRepIdLists = " and gd_rep_id in (" + chkRepIdLists + ") ";
            }

            dtFrom = new main_class().Convert_to_Midaly(dtFrom.Split(' ')[0], dtFrom.Split(' ')[1]);
            dtTo = new main_class().Convert_to_Midaly(dtTo.Split(' ')[0], dtTo.Split(' ')[1]);

            int ownerID = Convert.ToInt32(Session["OwnerID"].ToString());
            string tp = new tbl_OwnerTableAdapter().fun_GetOwnerUnitType(ownerID).ToString();
            string sql =
"  select gd_car_id as [کد موقعیت یاب],(select top 1 isnull(c_name,'')+' '+isnull(c_family,'') from tbl_units where c_unit_id=[gd_car_id]) as [نام], " +
" (select top 1 isnull(c_car_no,'') from tbl_units where c_unit_id=gd_car_id) as [شماره متحرک], " +
" (select  top 1 isnull(c_car_badaneh,'') from tbl_units where c_unit_id=gd_car_id) as [مدل متحرک], " +
" (dbo.SDateStr(gd_date)+' '+dbo.TimePart(gd_date)) AS [تاريخ], " +
" gd_speed as [سرعت],(select top 1 RepDifValue from tbl_report_define where RepDifID = gd_rep_id and RepUnitModel = '" + tp + "') as [نوع گزارش], " +
" gd_Input_id as [کدخروجی],gd_Output_Id as [کدورودی],gd_mile as [مسافت طی شده], " +
" (SELECT TOP 1 fa_name FROM Positions ORDER BY (Abs(POINT_X-gps_data.gd_e)+Abs(POINT_Y-gps_data.gd_n)) ASC ) AS [نام شهر]  " +
" from GPS_Data " +
            "            WHERE  ((GPS_Data.gd_date BETWEEN '" + dtFrom + "' AND '" + dtTo + "') " + chkRepIdLists + " " + filterspeed + " and (  gd_car_id  in (" + selcar + ") ))  order by gd_date asc;  ";


            SqlConnection scn = new SqlConnection(new main_class().get_connection_string());
            scn.Open();
            SqlCommand sc = new SqlCommand(sql, scn);
            SqlDataReader sdr = sc.ExecuteReader();
            GridView1.DataSource = sdr;
            GridView1.DataBind();
        

    }
}
