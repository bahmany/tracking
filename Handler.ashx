<%@ WebHandler Language="C#" Class="Handler_CarWindow" %>

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
using MainDataModuleTableAdapters;
public class Handler_CarWindow : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public string GenerateCarsListForJS()
    {
        int OwnerID = 0;
        OwnerID = Convert.ToInt32(HttpContext.Current.Session["OwnerID"].ToString());
        string str = "";
        foreach (DataRow dr in new MainDataModuleTableAdapters.GPS_DataGetTopTableAdapter().GetData(OwnerID))
        {
            
            string strname = " ";
            if (new MainDataModuleTableAdapters.tbl_unitsTableAdapter().GetCarOwnerNameByUnitID(Convert.ToInt32(dr["gd_car_id"].ToString()))!= null)
            {
                strname = new MainDataModuleTableAdapters.tbl_unitsTableAdapter().GetCarOwnerNameByUnitID(Convert.ToInt32(dr["gd_car_id"].ToString()));

            }
            str = str + string.Format
                (
                "?{0},{1},{2},{3},{4},{5}"
                ,
                dr["id"].ToString(),
                dr["gd_car_id"].ToString(),
                dr["gd_e"].ToString(),
                dr["gd_n"].ToString(),
                dr["speed"].ToString(),
                strname
                );
        }
        return str;
    }

    public string GetInformationWindow(int UnitID)
    {
        string path = System.Web.HttpContext.Current.Server.MapPath("~/htmlfrm/html_CarInfoWindow_Detail.htm");
        string str;
        System.IO.FileStream fs = File.Open(path, FileMode.Open);
        HttpContext.Current.Session["UnitID"] = UnitID.ToString();

        byte[] b = new byte[fs.Length];
        UTF8Encoding temp = new UTF8Encoding(true);
        str = "";
        while (fs.Read(b, 0, b.Length) > 0)
        {
            str = str + (temp.GetString(b));
        }

        fs.Close();
        string gd_car_id = "-1";
        string gd_date;
        string gd_rep_id = "-1";
        string gd_input_id = "-1";
        string gd_output_id = "-1";
        string gd_en = "-1";
        string gd_speed = "-1";
        foreach (DataRow dr in new MainDataModuleTableAdapters.GPS_DataTableAdapter().GetLatestPosByUnitID(UnitID))
        {
            gd_car_id = dr["gd_car_id"].ToString();
            gd_date = new OutMapController().ConvertToShamsi(Convert.ToDateTime(dr["gd_date"].ToString()), 4);
            if (dr["gd_input_id"] != null) { gd_input_id = dr["gd_input_id"].ToString(); }
            if (dr["gd_output_id"] != null) { gd_output_id = dr["gd_output_id"].ToString(); }
            if ((gd_input_id == "-1") && (gd_output_id == "-1")) { gd_input_id = dr["gd_iostatus"].ToString(); }
            gd_rep_id = dr["gd_rep_id"].ToString();
            gd_en = "e:" + dr["gd_e"].ToString() + " n:" + dr["gd_n"].ToString();
            gd_speed = dr["gd_speed"].ToString();
            string id = dr["id"].ToString();

            str = Regex.Replace(str, "#1", gd_car_id);
            str = Regex.Replace(str, "#2", gd_date);
            str = Regex.Replace(str, "#3", gd_rep_id);
            str = Regex.Replace(str, "#4", gd_input_id);
            str = Regex.Replace(str, "#5", gd_output_id);
            str = Regex.Replace(str, "#6", gd_en);
            str = Regex.Replace(str, "#7", gd_speed);
            str = Regex.Replace(str, "#8", id);

            string gud = Guid.NewGuid().ToString();
            HttpContext.Current.Session["guid"] = gud;
            HttpContext.Current.Session["UnitID"] = gd_car_id;

            str = Regex.Replace(str, "#8", gud);

        }
        return str;
    }
    
    
    

    
    
    public string GetInformationPoint(int PointID)
    {
        string path = System.Web.HttpContext.Current.Server.MapPath("~/htmlfrm/html_CarInfoWindow_Point.htm");
        string str;
        System.IO.FileStream fs = File.Open(path, FileMode.Open);
        //HttpContext.Current.Session["UnitID"] = PointID.ToString();

        byte[] b = new byte[fs.Length];
        UTF8Encoding temp = new UTF8Encoding(true);
        str = "";
        while (fs.Read(b, 0, b.Length) > 0)
        {
            str = str + (temp.GetString(b));
        }

        fs.Close();
        string gd_car_id = "-1";
        string gd_date;
        string gd_rep_id = "-1";
        string gd_input_id = "-1";
        string gd_output_id = "-1";
        string gd_en = "-1";
        string gd_speed = "-1";
        foreach (DataRow dr in new MainDataModuleTableAdapters.GPS_DataTableAdapter().GetPositionDetailByPositionID_DataTable(PointID))
        {
            gd_car_id = dr["gd_car_id"].ToString();
            gd_date = new OutMapController().ConvertToShamsi(Convert.ToDateTime(dr["gd_date"].ToString()), 4);
            if (dr["gd_input_id"] != null) { gd_input_id = dr["gd_input_id"].ToString(); }
            if (dr["gd_output_id"] != null) { gd_output_id = dr["gd_output_id"].ToString(); }
            if ((gd_input_id == "-1") && (gd_output_id == "-1")) { gd_input_id = dr["gd_iostatus"].ToString(); }
            gd_rep_id = dr["gd_rep_id"].ToString();
            gd_en = "e:" + dr["gd_e"].ToString() + " n:" + dr["gd_n"].ToString();
            gd_speed = dr["gd_speed"].ToString();
            string id = dr["id"].ToString();

            str = Regex.Replace(str, "#1", gd_car_id);
            str = Regex.Replace(str, "#2", gd_date);
            str = Regex.Replace(str, "#3", gd_rep_id);
            str = Regex.Replace(str, "#4", gd_input_id);
            str = Regex.Replace(str, "#5", gd_output_id);
            str = Regex.Replace(str, "#6", gd_en);
            str = Regex.Replace(str, "#7", gd_speed);
            str = Regex.Replace(str, "#8", id);

            string gud = Guid.NewGuid().ToString();
            HttpContext.Current.Session["guid"] = gud;
            HttpContext.Current.Session["UnitID"] = gd_car_id;

            str = Regex.Replace(str, "#8", gud);
            

        }
        return str;
    }

    public string GetInformationOnlineWindow(int UnitID)
    {
        string path = System.Web.HttpContext.Current.Server.MapPath("~/htmlfrm/html_CarInfoWindow_Online.htm");
        string str;
        System.IO.FileStream fs = File.Open(path, FileMode.Open);


        byte[] b = new byte[fs.Length];
        UTF8Encoding temp = new UTF8Encoding(true);
        str = "";
        while (fs.Read(b, 0, b.Length) > 0)
        {
            str = str + (temp.GetString(b));
        }

        fs.Close();
        string gd_car_id = "-1";
        string gd_date;
        string gd_rep_id = "-1";
        string gd_input_id = "-1";
        string gd_output_id = "-1";
        string gd_en = "-1";
        string gd_speed = "-1";
        foreach (DataRow dr in new MainDataModuleTableAdapters.GPS_DataTableAdapter().GetLatestPosByUnitID(UnitID))
        {
            gd_car_id = dr["gd_car_id"].ToString();
            gd_date = new OutMapController().ConvertToShamsi(Convert.ToDateTime(dr["gd_date"].ToString()), 4);
            if (dr["gd_input_id"] != null) { gd_input_id = dr["gd_input_id"].ToString(); }
            if (dr["gd_output_id"] != null) { gd_output_id = dr["gd_output_id"].ToString(); }
            if ((gd_input_id == "-1") && (gd_output_id == "-1")) { gd_input_id = dr["gd_iostatus"].ToString(); }
            gd_rep_id = dr["gd_rep_id"].ToString();
            gd_en = "e:" + dr["gd_e"].ToString() + " n:" + dr["gd_n"].ToString();
            gd_speed = dr["gd_speed"].ToString();
            string id = dr["id"].ToString();
            str = Regex.Replace(str, "#1", gd_car_id);
            str = Regex.Replace(str, "#2", gd_date);
            str = Regex.Replace(str, "#3", gd_rep_id);
            str = Regex.Replace(str, "#4", gd_input_id);
            str = Regex.Replace(str, "#5", gd_output_id);
            str = Regex.Replace(str, "#6", gd_en);
            str = Regex.Replace(str, "#7", gd_speed);
            str = Regex.Replace(str, "#8", id);


        }
        return str;
    }


    public string GetPOIForm(int PointID)
    {
        string path = System.Web.HttpContext.Current.Server.MapPath("~/htmlfrm/html_POI_Form.htm");
        string str;
        System.IO.FileStream fs = File.Open(path, FileMode.Open);
        //GetDataBy

        byte[] b = new byte[fs.Length];
        UTF8Encoding temp = new UTF8Encoding(true);
        str = "";
        while (fs.Read(b, 0, b.Length) > 0)
        {
            str = str + (temp.GetString(b));
        }

        fs.Close();

        string LayerName = "";
        string name = "";
        string telno = "";
        string cellno = "";
        string addr = "";


        //HttpContext.Current.Session["OwnerID"] = 3;
        int ssid = Convert.ToInt32(HttpContext.Current.Session["OwnerID"].ToString());
        
        foreach (DataRow dr in
            new MainDataModuleTableAdapters.tbl_poiTableAdapter().GetDataBy(
            ssid,PointID).Rows)
        {
            


            LayerName =new tbl_poi_layersTableAdapter().GetLayerName(Convert.ToInt32(dr["p_poi_layer_link"].ToString()));
            name =dr["p_nf_name"].ToString();
            telno=dr["p_tel"].ToString(); 
            cellno =dr["p_mobile"].ToString();
            addr =dr["p_addr"].ToString();



        }

        str = Regex.Replace(str, "#1", LayerName);
        str = Regex.Replace(str, "#2", name);
        str = Regex.Replace(str, "#3", telno);
        str = Regex.Replace(str, "#4", cellno);
        str = Regex.Replace(str, "#5", addr);
        return str;
    }




    public void send_command(string guid)
    {
        // getting unit id and command id from GUID --------------------
        MainDataModuleTableAdapters.tbl_CommandsEntryValueTableAdapter cevt = new MainDataModuleTableAdapters.tbl_CommandsEntryValueTableAdapter();
        Guid gd = new Guid(guid);
        int commandid = (int)cevt.GetCommandIDByGUID(gd);
        int unitid = (int)cevt.GetUnitIDByGUID(gd);
        string commandname = new MainDataModuleTableAdapters.tbl_CommandsTableAdapter().GetCommandNameByCommandID(commandid);
        string param = "";
        string cell = new MainDataModuleTableAdapters.tbl_unitsTableAdapter().GetCellNoFromUnitID(unitid);
        // generating command
        int i = 0;

        foreach (DataRow dr in new MainDataModuleTableAdapters.tbl_CommandsParamTableAdapter().GetDataByCommandID(commandid))
        {
            if (i != 0)
            {
                param = param + "," + cevt.GetParamValue(unitid, Convert.ToInt32(dr["cmdp_id"].ToString()));
            }
            else
            {
                param = cevt.GetParamValue(unitid, Convert.ToInt32(dr["cmdp_id"].ToString()));
            }
            i++;
        }

        //new MainDataModuleTableAdapters.SMSTableAdapter().Insert(
        //--------------------------------------------------------------
        // command name and command param retrieved .
        new MainDataModuleTableAdapters.SMSTableAdapter().Insert(
            cell,
            cell,
            commandname + "=" + param,
            "pending",
            new MainDataModuleTableAdapters.SMSTableAdapter().GetTAG(),
            0,
            DateTime.Now, DateTime.Now, "GPRS", commandname);




    }


    public void send_command_GetPos(string UnitID,string CommandStr)
    {
        // getting unit id and command id from GUID --------------------
        string cell = new MainDataModuleTableAdapters.tbl_unitsTableAdapter().GetCellNoFromUnitID(
            Convert.ToInt32(UnitID)
            
            );
        // generating command
       // int i = 0;

        new MainDataModuleTableAdapters.SMSTableAdapter().Insert(
            cell,
            cell,
            CommandStr,
            "pending",
            new MainDataModuleTableAdapters.SMSTableAdapter().GetTAG(),
            0,
            DateTime.Now, DateTime.Now, "GPRS", CommandStr);




    }


    public void ProcessRequest(HttpContext context)
    {
        //string ownersessionID = HttpContext.Current.Session["OwnerID"].ToString();


        if (context.Request.Params["gmonlcd"] != null) // for first time position strings for markers
        {
            context.Response.Write(GenerateCarsListForJS());
            context.Response.End();
            
        }
        
        

        if (context.Request.Params["_UnitID"] != null)
        {
            string UnitID = context.Request.Params["_UnitID"];
            context.Session["UnitID"] = UnitID;
            string unitid = "";
            for (int i = 0; i < UnitID.Length; i++)
            {
                if (UnitID[i] != ',')
                {
                    unitid += UnitID[i];

                }
                else
                {
                    break;
                }
            }

            // RegisterStartupScript(this, this.GetType(), "foo", "foo('a');", true); 
            context.Response.Write(GetInformationWindow(Convert.ToInt32(unitid)));
            context.Response.End();

        }
        if (context.Request.Params["OnlineUnitID"] != null)
        {
            int UnitID = Convert.ToInt32(context.Request.Params["OnlineUnitID"].ToString());
            context.Response.Write(GetInformationOnlineWindow(UnitID));
            context.Response.End();
        }

        if (context.Request.Params["ptnid"] != null)
        {
            int pointID = Convert.ToInt32(context.Request.Params["ptnid"].ToString());
            context.Response.Write(GetInformationPoint(pointID));
            context.Response.End();
        }

        if (context.Request.Params["CommandID"] != null)
        {
            string str = "Data Source=.;Initial Catalog=AriaAG;Persist Security Info=True;User ID=sa;PassWord=009100";
            FormRunTime_F f = new FormRunTime_F();
            string gud = Guid.NewGuid().ToString();
            HttpContext.Current.Session["HWguid"] = gud;

            str = f.CommandsDesign(HttpContext.Current.Session["HWguid"].ToString(), 2, null, "", str, Convert.ToInt32(context.Request.Params["CommandID"]), "lblMainTitle", "lblMainValue", "lblStbTitle", "lblStbDESC", "txt", "btn");
            context.Response.Write(str);
            context.Response.End();
        }

        if (context.Request.Params["sc"] != null)
        {
            string gu = HttpContext.Current.Session["HWguid"].ToString();
            Guid g = new Guid(gu);
            new MainDataModuleTableAdapters.tbl_CommandsSendTableAdapter().Insert(
                g,
                0, DateTime.Now);

            send_command(gu);



            context.Response.Write("   ");
            context.Response.End();
        }

        if (context.Request.Params["geposunid"] != null)
        {
            string unitid = HttpContext.Current.Session["UnitID"].ToString();
            
            if (unitid[0] == '1')
            {
                if (HttpContext.Current.Session["UnitID"] != null)
                {
                    string UnitID = HttpContext.Current.Session["UnitID"].ToString();
                    send_command_GetPos(UnitID, "$st+getposition=0000");
                }



            }
            if (unitid[0] == '2')
            {
                if (HttpContext.Current.Session["UnitID"] != null)
                {
                    string UnitID = HttpContext.Current.Session["UnitID"].ToString();
                    send_command_GetPos(UnitID, "at$getpds?");
                }
            }
            context.Response.Write(" ");
            context.Response.End();
        }



        //  >>   handler.ashx?getlatestch=1&UID=1010000001&ID=2514511
        //  <<   [UnitID,ID]
        //  >> if Change Detected  handler.ashx?getlatestch=1&UID=1010000001
        //  << [ID, UnitID, e, n, rep_type, dt, sped, inp, out]
        if (context.Request.Params["getlatestch"] != null)
        {
            string pos = context.Request.Params["getlatestch"].ToString();
            if (pos == "1")
            {
                context.Response.Write(
                    GetLatesPos(Convert.ToInt32(context.Request.Params["ID"].ToString()),
                    Convert.ToInt32( HttpContext.Current.Session["OwnerID"].ToString())
                    ));
                  
                
            }
            if (pos == "2")
            {

                context.Response.Write(new MainDataModuleTableAdapters.GPS_DataTableAdapter().GetLatestUpDateJS(
                    Convert.ToInt32(context.Request.Params["UID"].ToString())
                    ));
            }
            context.Response.End();
        }

        if (context.Request.Params["getprvway"] != null)
        //@id,@gd_car_id,@gd_e,@gd_n,@gd_speed,@gd_rep_id,@gd_Input_id,@gd_Output_Id
        {
            int UnitID = Convert.ToInt32(context.Request.Params["getprvway"].ToString());
            string from = context.Request.Params["from"];
            string _to = context.Request.Params["_to"];
            string filter = context.Request.Params["filter"];
            string isfilterActive = context.Request.Params["isfilterActive"];

            OutMapController omc = new OutMapController();
            

            DateTime dt_from = Convert.ToDateTime(omc.ConvertToMilady(from,5));
            DateTime dt_to = Convert.ToDateTime(omc.ConvertToMilady(_to, 5));
            // filter does not work :) :) :) :) :) :) and remains
            string strrr = new MainDataModuleTableAdapters.GPS_DataTableAdapter().GetPreviewWayInString(dt_from, dt_to, UnitID);
            context.Response.Write(strrr);
            context.Response.End();
            
                        
        }
        //GPS_DataTableAdapter
        if (context.Request.Params["getposbyposid"] != null)
        {
            int posid = Convert.ToInt32(context.Request.Params["getposbyposid"].ToString());
            string strrr = new MainDataModuleTableAdapters.GPS_DataTableAdapter().GetPositionDetailsByPositionID(
                posid);
            context.Response.Write(strrr);
            context.Response.End();
        }

        if (context.Request.Params["getfrmpoi"] != null)
        {
            string txt_name = context.Request.Params["tn"];
            string txt_tel = context.Request.Params["tt"];
            string txt_mob = context.Request.Params["tm"];
            string txt_addr = context.Request.Params["ta"];
            double lat = Convert.ToDouble(context.Request.Params["n"]);
            double lng = Convert.ToDouble(context.Request.Params["e"]);
            int layerid = Convert.ToInt32(context.Request.Params["lid"]);
            int getfrmpoi = Convert.ToInt32(context.Request.Params["getfrmpoi"]);
            int ownerID = Convert.ToInt32(context.Session["OwnerID"].ToString());
            string b = "";
            try
            {
                if (getfrmpoi != -1)
                {

                    new tbl_poiTableAdapter().Update(
                        txt_name, txt_tel, txt_mob, txt_addr, layerid,
                         lat, lng,
                         context.Request.Params["cl"],
                         context.Request.Params["shpnm"],
                         Convert.ToInt32(context.Request.Params["getfrmpoi"])
                         );
                }
                else
                {
                    new tbl_poiTableAdapter().InsertQuery
                        (
                        txt_name, txt_tel, txt_mob, txt_addr,
                        layerid, ownerID, lat, lng,
                        context.Request.Params["shpnm"]
                        );
                    b = new tbl_poiTableAdapter().GetPointIDByData(lat, lng, txt_name, ownerID).ToString();
                    
                }

                string sstr = "alert('نقطه مورد نظر ثبت شد'); gmrk.ID=" + b + "; POICurrentSelectedPointID=" + b + ";" + " CreateLabelPoi(" +
                    b + ",gmrk.getLatLng(),'" + txt_name + " " +
                    context.Request.Params["shpnm"]
                    + "'," + b + ",'" + txt_name + "');";


                context.Response.Write(sstr);
                
            }
            catch (Exception ee)
            {
                context.Response.Write("alter('"+"اطلاعات مورد نظر شما ثبت نشد لطفا اطلاعات ورودی را اصلاح نمایید"+"');");
            }
        }

        if (context.Request.Params["getfrmunderpoi"] != null)
        {
            context.Response.Write(GetPOIForm(
                Convert.ToInt32(context.Request.Params["pid"].ToString())));
        }
        
        if (context.Request.Params["getfrmunderpoidiv"] != null)
        {
            context.Response.Write(
                POI_Divs(
                Convert.ToInt32(context.Request.Params["getfrmunderpoidiv"].ToString()),
                context.Request.Params["oi"].ToString())
                );
        }
        //gvmepoimrklist  give me POI marker List
        if (context.Request.Params["gvmepoimrklist"] != null)
        {
            context.Response.Write(gvmepoimrklist(
                Convert.ToInt32(
                context.Request.Params["gvmepoimrklist"].ToString()
                )));
         }


        if (context.Request.Params["updpoi"] != null)  // POI Update
        {

            int PointID = Convert.ToInt32(context.Request.Params["updpoi"].ToString());
            double _e = Convert.ToDouble(context.Request.Params["e"].ToString());
            double _n = Convert.ToDouble(context.Request.Params["n"].ToString());
            new tbl_poiTableAdapter().UpdatePOIPosition(_e, _n, PointID);
            
        }
        
    }



    public string POI_Divs(int LayerID,string OwnerID)
    {
        string str="";
        main_class mc = new main_class();
        
        string pfrm = "";
        int intOwnerID = Convert.ToInt32(HttpContext.Current.Session["OwnerID"].ToString());
        foreach (DataRow dr in new tbl_poiTableAdapter().GetDateBySelectedLayer(intOwnerID, LayerID))
        {
            string frm = mc.loadFromHtml("~/htmlfrm/html_POI_Grd.htm");
            frm = Regex.Replace(frm, "#1", dr["p_nf_name"].ToString());
            frm = Regex.Replace(frm, "#2", dr["p_id"].ToString());
            frm = Regex.Replace(frm, "#3", dr["p_addr"].ToString());
            str = str + frm;
        }
        if (str == "") { str = "اطلاعاتی یافت نشد"; }
        return str;
        
    }


    public string gvmepoimrklist(int LayerID)
    {
        string str = "";
        string ch ="";
        int intOwnerID = Convert.ToInt32(HttpContext.Current.Session["OwnerID"].ToString());
        foreach (DataRow dr in new tbl_poiTableAdapter().GetDateBySelectedLayer(intOwnerID, LayerID))
        {
            if (str=="") {ch="";} else {ch="?";}

            str = str + ch + string.Format("{0},{1},{2},{3},{4},{5},{6}", dr["p_e"].ToString(), dr["p_n"].ToString(), dr["p_nf_name"].ToString(), dr["p_poi_layer_link"].ToString(), dr["p_color"].ToString(), dr["p_id"].ToString(), dr["p_shopname"].ToString());
        }
       


        return str;
    }
    
    

    public string GetLatesPos(int PointID, int OwnerID)
    {
        string str = "";
        foreach (DataRow dr in new MainDataModuleTableAdapters.GPS_DataGetTopTableAdapter().GetData(OwnerID))
        {
            if (PointID < Convert.ToInt32(dr["id"].ToString()))
            { //ID, UnitID, e, n, rep_type, dt, sped, inp, out
                str = str + string.Format
                    (
                    "?{0},{1},{2},{3},{4},{5},{6},{7},{8}"
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
            }

        }
        return str;

    }

    
     
    public bool IsReusable {
        get 
        {
            return false;
        }
    }

}




