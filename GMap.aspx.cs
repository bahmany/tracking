using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

using System.Data.SqlClient;
using MainDataModuleTableAdapters;
using Telerik.Web.UI;
using System.Drawing;



public partial class GMap : System.Web.UI.Page
{

  


    public string GenerateCarsListForJS()
    {
        int CustomerID; 
        if (Request.Cookies["CustomerID"] != null)
        {
           CustomerID  = Convert.ToInt32(Request.Cookies["CustomerID"].Value.ToString());
        } else {CustomerID =1;}
        MainDataModuleTableAdapters.GPS_DataGetTopTableAdapter gd_tta =
            new MainDataModuleTableAdapters.GPS_DataGetTopTableAdapter();
        MainDataModule.GPS_DataGetTopDataTable gd_da = new MainDataModule.GPS_DataGetTopDataTable();
        gd_tta.Fill(gd_da, CustomerID);
        gd_tta.Fill(gd_da, CustomerID);
        int i = 0;
        string str = "";
        foreach (DataRow dr in gd_da.Rows)
        {

            str = str + string.Format
                (
                "atp({0}, {1}, {2}, {3}, '{4}', '{5}', {6}, {7}, {8});"
                ,
                dr["id"].ToString(),
                dr["gd_car_id"].ToString(),
                dr["gd_e"].ToString(),
                dr["gd_n"].ToString(),
                dr["RepDifValue"].ToString(),
                dr["shDate"].ToString(),
                dr["speed"].ToString(),
                dr["Input"].ToString(),
                dr["Output"].ToString()
                );
            //atp(ID, UnitID,e,n,rep_type,dt,sped) 

        }
        return str;
    }
    public string GenerateCarsListForJStoCompare()
    {
        int CustomerID;
        if (Request.Cookies["CustomerID"] != null)
        {
            CustomerID = Convert.ToInt32(Request.Cookies["CustomerID"].Value.ToString());
        }
        else { CustomerID = 1; }

        MainDataModuleTableAdapters.GPS_DataGetTopTableAdapter gd_tta =
            new MainDataModuleTableAdapters.GPS_DataGetTopTableAdapter();
        MainDataModule.GPS_DataGetTopDataTable gd_da = new MainDataModule.GPS_DataGetTopDataTable();
        gd_tta.Fill(gd_da, CustomerID);
        int i = 0;
        string str = "ArrayOfOnlinePosDBID2.length = 0;";
        foreach (DataRow dr in gd_da.Rows)
        {
            //str = str + string.Format("atp2({0}, {1}, {2}, {3}, '{4}', '{5}', {6}, {7}, {8});"
            str = str + string.Format("?{0}, {1}, {2}, {3}, '{4}', '{5}', {6}, {7}, {8}"
            ,
              dr["id"].ToString(),
              dr["gd_car_id"].ToString(),
              dr["gd_e"].ToString(),
              dr["gd_n"].ToString(),
              dr["RepDifValue"].ToString(),
              dr["shDate"].ToString(),
              dr["speed"].ToString(),
              dr["Input"].ToString(),
              dr["Output"].ToString()
              );
            //ID, UnitID, e, n, rep_type, dt, sped,inp,out
        }
        return str;
    }

    public string GenerateWhereClause(int UnitID)
    {
        string sql = "";
        string fromdate;
        string fromtime;
        string todate;
        string totime;
        string[] str;
        str = txt_from.Text.Split(' ');
        fromdate = str[1];
        fromtime = str[0];
        str = txt_to.Text.Split(' ');
        todate = str[1];
        totime = str[0];

        OutMapController omc = new OutMapController();
        try
        {
            fromdate = omc.ConvertToMilady(fromdate, 1) + " " + fromtime;
            todate = omc.ConvertToMilady(todate, 1) + " " + totime;
            sql = string.Format("gd_date between '{0}' and '{1}' ", fromdate, todate);
        }
        catch
        {
            lbl_msg.Text = "لطفا تاریخ را اصلاح کنید";
        }

        if (chk_Filter.Checked)
        {
            sql = sql + " and " + drp_selectFilter.SelectedValue + " " + drp_selectMass.SelectedValue + " " + txt_FilterValue.Text;
        }

        sql = " where gd_car_id = " + UnitID.ToString() + " and " + sql;
        return sql;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //txt_FilterValue.ClientID
        if (!IsPostBack)
        {
            OutMapController omc = new OutMapController();
          //  //TextBox1.ClientID
            txt_from.Text = "00:01 " + omc.ConvertToShamsi(DateTime.Now.AddDays(-1), 1);
            txt_to.Text = "23:59 " + omc.ConvertToShamsi(DateTime.Now, 1);
            RadTreeView1.Nodes.Clear();
            
            if (Session["OwnerID"] == null)
            {
                Response.Redirect("login.aspx");
            }

            foreach (DataRow dr in new tbl_units_groupsTableAdapter().GetDataBy(Convert.ToInt32(Session["OwnerID"].ToString())))
            {
                RadTreeNode rtn = new RadTreeNode(dr["cg_name"].ToString());
                foreach (DataRow dr1 in new tbl_unitsTableAdapter().GetDataByGroupID(
                    Convert.ToInt32(Session["OwnerID"].ToString()),
                    Convert.ToInt32(dr["cg_id"].ToString())))
                {
                    RadTreeNode rtn1 = new RadTreeNode(dr1["c_unit_id"].ToString());
                    
                    if (dr1["c_family"]!= null)
                    {
                        rtn1.ToolTip = dr1["c_family"].ToString();
                    }
                    

                    
                    rtn1.Text = dr1["c_unit_id"].ToString();
                    
                    rtn1.NavigateUrl = "javascript:ShowLastPostStaticWin(" + dr1["c_unit_id"].ToString() + ")";
                    rtn1.DataBind();
                    rtn1.ForeColor = Color.White;
                    rtn.Nodes.Add(rtn1);

                }
                RadTreeView1.Nodes.Add(rtn);
            }
        }

        /*

        // new OutMapController().GetCarListIcons(2);
        if (!IsPostBack)
        {
            OutMapController omc = new OutMapController();
            //TextBox1.ClientID
            TextBox3.Text = omc.ConvertToShamsi(DateTime.Now.AddDays(-1), 1);
            TextBox4.Text = omc.ConvertToShamsi(DateTime.Now, 1);

            string hour = DateTime.Now.Hour.ToString();
            string min = DateTime.Now.Minute.ToString();
            if (hour.Length == 1) hour = "0" + hour;
            if (min.Length == 1) min   = "0" + min ;


            TextBox1.Text = hour + ":" + min;
            TextBox2.Text = hour + ":" + min;
        }*/
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

/*
        string UnitID = Request.Cookies["UnitID"].ToString();
        OutMapController omc = new OutMapController();
        string _from = omc.ConvertToMilady(TextBox3.Text, 1) + " " + TextBox1.Text;
        string _to = omc.ConvertToMilady(TextBox4.Text, 1) + " " + TextBox2.Text;
        sqld_way.SelectParameters["gd_car_id"].DefaultValue = Request.Cookies["UnitID"].Value.ToString();
        sqld_way.SelectParameters["from"].DefaultValue = _from;
        sqld_way.SelectParameters["_to"].DefaultValue = _to;
        if (CheckBox1.Checked)
        {

            string arr = "";
            string _field = "";
            if (RadioButton1.Checked) arr = "<";
            if (RadioButton2.Checked) arr = ">";
            if (RadioButton3.Checked) arr = "=";
            if (Convert.ToInt16(DropDownList1.SelectedValue.ToString()) == 1) { _field = "سرعت"; sqld_way.FilterExpression = _field + arr + TextBox5.Text; }
            if (Convert.ToInt16(DropDownList1.SelectedValue.ToString()) == 2) { _field = "گزارش"; sqld_way.FilterExpression = _field + " like '*" + TextBox5.Text + "*'"; }
            if (Convert.ToInt16(DropDownList1.SelectedValue.ToString()) == 3) { _field = "مسافت طی شده"; sqld_way.FilterExpression = _field + "='" + TextBox5.Text + "'"; }
        }
        else sqld_way.FilterExpression = "";

        DataView dv = new DataView();
        DataTable dt = new DataTable();
        dv = (DataView)sqld_way.Select(DataSourceSelectArguments.Empty);
        dt = dv.ToTable();

        string str = "";
        string str2 = "";
        string str3 = "";
        string str4 = "";
        int i = 0;
        foreach (DataRow dr in dt.Rows)
        {
            if (i == 0) { str = str + string.Format(" new GLatLng({0},{1}) ", dr["y"].ToString(), dr["x"].ToString()); }
            else
            {
                str = str + string.Format(" , new GLatLng({0},{1}) ", dr["y"].ToString(), dr["x"].ToString());
            }
            i = i + 1;
            //   str2 = str2 + string.Format(" _bounds.extend(new GLatLng({0},{1})); addPoint(new GLatLng({0},{1}));", dr["y"].ToString(), dr["x"].ToString());
            str3 = string.Format("{0}", DateTime.Parse(dr["gd_date"].ToString()).ToString("HH:mm:ss"));
            // str4 = str4 + string.Format(" addLabel(new GLatLng({0},{1}),'{2}',{3});", dr["y"].ToString(), dr["x"].ToString(), str3, dr["id"].ToString());
            str2 = str2 + string.Format(" addPoint(new GLatLng({0},{1}));", dr["y"].ToString(), dr["x"].ToString());

        }
        //str2 = " _bounds = new GLatLngBounds();" + str2 + " map.setCenter(_bounds.getCenter(), map.getBoundsZoomLevel(_bounds));";
        str = " polyline = new GPolyline([" + str + "], 10);map.addOverlay(polyline); " + str2 + str4;
        str = str + str2 + " createall();";

        //Response.Write("<script type=\"text/javascript\">" + str + "</script>");
        Literal1.Text = ("<span onclick=\"" + str + " \"" + ">نمایش مسیر طی شده</span>");


        //Control foundControl = FindControlRecursive(Page, "Label2");

        //        ((HtmlControl)foundControl).Attributes.Add("onclick", str);


        // Page.Title = new OutMapController().ConvertToShamsi(DateTime.Now, 1);
        //this.RegisterStartupScript("dsfasdf", str);
        //Page.RegisterClientScriptBlock("dsfds", str);


        //Response.Redirect("NvMapBrowser.aspx?ModuleID=AFVTASUREHFIUEHIUEFHIUHEFIUHIEHFOPWDAFHIUWHAIDII&UnitID=" + Request.QueryString["UnitID"].ToString() + "");
        this.GridView1.DataBind();*/
    }
    public static Control FindControlRecursive(Control rootControl, string id)
    {
        if (rootControl != null)
        {
            if (rootControl.ID == id)
            {
                return rootControl;
            }

            for (int i = 0; i < rootControl.Controls.Count; i++)
            {
                Control child;

                if ((child = FindControlRecursive(rootControl.Controls[i], id)) != null)
                {
                    return child;
                }
            }
        }

        return null;
    }

    protected void sqld_way_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // determine the value of the UnitsInStock field
            int ReportAgent =
            Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "درجه"));
            if (ReportAgent == 1) e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#d2ffcc");
            if (ReportAgent == 2) e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#ccd8ff");
            if (ReportAgent == 3) e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#feffcc");
            if (ReportAgent == 4) e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9566");
        }

    }
    protected void GetAllNewPositions(object sender, EventArgs e)
    {

        //  ScriptManager.RegisterStartupScript(this, this.GetType(), "foo", GenerateCarsListForJStoCompare() + " aca();", true); 
        ScriptManager.RegisterStartupScript(this, this.GetType(), "foo", GenerateCarsListForJStoCompare() + " aca();", true); 

    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        //if (Session["UnitID"] != null)
        {
            //   int unitID = Convert.ToInt32(Session["UnitID"].ToString());
            int unitID = Convert.ToInt32(Session["UnitID"].ToString());
            string points = "";
            string lines = "";
            double e_old = 0;
            double n_old = 0;
            double e_new = 0;
            double n_new = 0;

            string sql = "select top 300 *,dbo.func_ConvertToDateTimePersian(gd_date) as shdate from GPS_Data " + GenerateWhereClause(unitID);
            OutMapController omc = new OutMapController();
            SqlConnection sc = new SqlConnection(omc.get_connection_string());
            sc.Open();
            SqlCommand scm = new SqlCommand(sql, sc);
            SqlDataReader sdr = scm.ExecuteReader();
            //dl_PrevWay.DataSource = sdr;
            //dl_PrevWay.DataBind();
            int i = 0;
            while (sdr.Read())
            {
                if (points != "")
                {
                    points = points + string.Format(" CPW(new GLatLng({0},{1}),'..'); ", sdr["gd_n"].ToString(), sdr["gd_e"].ToString());
                    
                }
                else
                {
                    points = string.Format(" CPW(new GLatLng({0},{1}),'..'); ", sdr["gd_n"].ToString(), sdr["gd_e"].ToString());
                }

                //-----------------------------------------------
                e_new = Convert.ToDouble(sdr["gd_e"].ToString());
                n_new = Convert.ToDouble(sdr["gd_n"].ToString());
                //------------------------------------------------
                if (i == 0)
                {

                }
                else
                {
                    if (i == 1)
                    {
                        lines += string.Format(" new GLatLng({0},{1}) ",n_new.ToString(),e_new.ToString());
                    }
                    else
                    {
                        lines += string.Format(" , new GLatLng({0},{1}) ", n_new.ToString(), e_new.ToString());
                    }
                }
      


                //------------------------------------------------

                i++;
            }

            lines =
                " "+
                " var polyOptions = {geodesic:true}; " +
                " " +
                " var PrevWaypolyline = new GPolyline([" + lines + "], \"#ff0000\", 10, 1); " +
                " map.addOverlay(polyline); ";
            points =
                "  ShowWayPrevGrid(); CPW_Clear(); " + points +
                "  " + points +
                " CPW_ShowMarkers(GMarkerPlay); " +
                " ";
                
                
            if (points != "")
            {
                if (i > 299)
                {
                    points = " alert('موقعیت های فراخوانی شده شما بیش از 500 موقعیت میباشد  سیستم فقط توانایی نمایش 500 موقعیت را دارد لطفا تاریخ ورودی را کوتاه تر نمایید'); " + points;
                }
            }
            else
            {
                points = " alert('در تاریخ های ورودی هیچ موقعیتی یافت نشد'); ";
            }


            ScriptManager.RegisterStartupScript(this, this.GetType(), "ffoo1", points+" "+lines, true);


        }

    }
    protected void Button1_Click2(object sender, EventArgs e)
    {

    }
}

class TreeViewTemplate : ITemplate
{
    public void InstantiateIn(Control container)
    {
        Label lbl = new Label();
        lbl.ID = "lbl1";
        lbl.DataBinding += new EventHandler(handleBinding);
        RadTreeNode node = (RadTreeNode)container;
        lbl.Text = node.ToolTip;
        container.Controls.Add(lbl);
    }

    public void handleBinding(object sender, EventArgs e)
    {
        //Label lbl = (Label)sender;
        //lbl.Text = "adasdasD";

        //RadTreeNode node = (RadTreeNode)lbl.BindingContainer;
        //string nodeValue = (string)DataBinder.Eval(node, "c_name");
        //lbl.Text = "dsdfsdfsdf"+node.Value;
    }
}
