using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using MainDataModuleTableAdapters;
using System.Data;
using System.Web.Script;

/// <summary>
/// Summary description for OutMapController
/// </summary>
public class OutMapController
{



    public string Convert_to_standard_time(TimeSpan tm)
    {
        string str = "";
        string hour = "";
        string min = "";
        string sec = "";

        hour = tm.Hours.ToString();
        min = tm.Minutes.ToString();
        if (hour.Length == 1) { hour = "0" + hour; }
        if (min.Length == 1) { min = "0" + min; }

        str = hour + ":" + min;

        return str;

    }
    
    
    
    
    
    
    
    public string Module_MoreDetails = "AFVTASFYTFQUEHFU1231TFYGUGRDEHIJOJNNKKEWSRDBKJNR";  // for loading car details
    public string Module_PervWay = "AFVTASUREHFIUEHIUEFHIUHEFIUHIEHFOPWDAFHIUWHAIDII";  // for loading car Way   این قسمت برای مرور مسیر طی شده دستی ست شده است
    public string JsHeader =

"var player = nokiaMapLoader.getPlayer({ "+
"    \"onInitDone\": GetInfo, "+
"    \"token\": \"15b0b4806591a73caf37230e70dde1cc\", "+
"    \"debug\": { \"console\": false } }); "+
"    function GetInfo() { "+
"        player.showGUI(nokia.maps.mapplayer.MapPlayer.GUI_LAYER_LIST); ";

    public string GenerateOviMap(string JavaScriptAdditional,string LayerName)
    {

        return "<script type=\"text/javascript\">" + JsHeader + JavaScriptAdditional + " var layer = player.map.createLayer({name: \"" + LayerName + "\"}); var mapObjects = layer.addMapObjects(PassedWay); var ix = mapObjects.length / 2; var rem = ix % 1;if (rem > 0) ix = ix - rem;   player.map.moveTo({position: mapObjects[ix], scale: 3000});}  </script>";
    }
    public string ConvertToShamsi(DateTime dt, int _type)
    {
        //1:ShortDate
        //2:ShortDate Time
        //3:NameDate
        //4:NameDate Time

        FarsiLibrary.Utils.PersianDate pd;
        pd = FarsiLibrary.Utils.PersianDateConverter.ToPersianDate(dt);
        string year = pd.Year.ToString();
        string month = pd.Month.ToString();
        string day = pd.Day.ToString();
        string hour = pd.Hour.ToString();
        string min = pd.Minute.ToString();
        string sec = pd.Second.ToString();
        string str = "";
        if (month.Length == 1) month = "0" + month;
        if (day.Length == 1) day = "0" + day;
        if (hour.Length == 1) hour = "0" + hour;
        if (min.Length == 1) min = "0" + min;
        if (sec.Length == 1) sec = "0" + sec;

        if (_type == 1) { str = year + "/" + month + "/" + day; }
        if (_type == 2) { str = year + "/" + month + "/" + day + " " + hour + ":" + min + ":" + sec; }
        if (_type == 3) { str = FarsiLibrary.Utils.PersianDateConverter.ToPersianDate(dt).ToWritten(); }
        if (_type == 4) { str = FarsiLibrary.Utils.PersianDateConverter.ToPersianDate(dt).ToWritten() + " " + hour + ":" + min + ":" + sec; }
        return str;

    }
    public string ConvertToMilady(string dt, int _type)
    {
        //1:ShortDate
        //2:ShortDate Time
        //3:NameDate
        //4:NameDate Time
        string dat = dt;
        string tm = "";
        if (dt.Split(' ').Length != 1)
        {
           dat = dt.Split(' ')[0];
           tm = dt.Split(' ')[1];
        }

        DateTime pd = FarsiLibrary.Utils.PersianDateConverter.ToGregorianDateTime(new FarsiLibrary.Utils.PersianDate(dat));
        string year = pd.Year.ToString();
        string month = pd.Month.ToString();
        string day = pd.Day.ToString();
        string hour = pd.Hour.ToString();
        string min = pd.Minute.ToString();
        string sec = pd.Second.ToString();
        string str = "";


        if (month.Length == 1) month = "0" + month;
        if (day.Length == 1) day = "0" + day;
        if (hour.Length == 1) hour = "0" + hour;
        if (min.Length == 1) min = "0" + min;
        if (sec.Length == 1) sec = "0" + sec;

        if (_type == 1) { str = year + "/" + month + "/" + day; }
        if (_type == 2) { str = year + "/" + month + "/" + day + " " + hour + ":" + min + ":" + sec; }
        if (_type == 3) { str = FarsiLibrary.Utils.PersianDateConverter.ToPersianDate(dt).ToWritten(); }
        if (_type == 4) { str = FarsiLibrary.Utils.PersianDateConverter.ToPersianDate(dt).ToWritten() + " " + hour + ":" + min + ":" + sec; }
        if (_type == 5) { str = year + "/" + month + "/" + day + " " + tm; }
        return str;

    }




    public string str1;
    public string str2;
    public string str3;
    public string str4;
    public string str5;




    public string get_connection_string()
    {
        System.Configuration.Configuration rootWebConfig =
        System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~\\");
        System.Configuration.ConnectionStringSettings connString;

        connString = rootWebConfig.ConnectionStrings.ConnectionStrings["AriaAGConnectionString"];
        if (connString != null) { return connString.ConnectionString.ToString(); }
        else
        {
            return "";
        }
    }
}