using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainDataModuleTableAdapters;

public partial class MasterPage : System.Web.UI.MasterPage
{

    private bool AuthenticateMe(string userName, string password)
    {
        bool auth = false;
        //password = new main_class().Encode(password);
        if (new tbl_usersTableAdapter().CheckIfUserNameExistsOrNot(userName, password) == 1)
        {
            auth = true;
            Session["OwnerID"] = new tbl_usersTableAdapter().GetOwnerIDfromUsername(userName, password).ToString();
            Session["OwnerWeight"] = new tbl_OwnerTableAdapter().GetOwnerWieght(Convert.ToInt32(Session["OwnerID"].ToString()));
            Session["userName"] = userName;
            Session["password"] = password;
            HttpContext.Current.Session.Timeout = 999;
            Response.Cookies.Add(new HttpCookie("password", password));
            Response.Cookies.Add(new HttpCookie("userName", userName));
            Response.Cookies.Add(new HttpCookie("OwnerID", new main_class().Encode(Session["OwnerID"].ToString())));
            Response.Cookies.Add(new HttpCookie("OwnerWeight", new main_class().Encode(Session["OwnerWeight"].ToString())));
        }



        return auth;
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["OwnerID"] == null)
        {
            Response.Redirect("login.aspx");
        }



        //Page.Title = Page.AppRelativeVirtualPath;

        try
        {
            if (!AuthenticateMe(Request.Cookies["userName"].Value.ToString(), Request.Cookies["password"].Value.ToString()))
            {
                Response.Redirect("login.aspx");
            }
        }
        catch (Exception _e)
        {
            Response.Redirect("login.aspx");
        }

        

    }


    public string add_nec_script_codes()
    {
        string scr = "";
        //loader.aspx?pid=14
        string addr = Page.AppRelativeVirtualPath;
        if (addr == "~/gmap.aspx" || addr == "~/loaderWithMS.aspx")
        {

            
            scr = " <meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=no\" /> " +
            " <script src=\"http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyDFtOUrVz0KO4benTh1ktEJ1IegXBjaPkg\" type=\"text/javascript\"> " +
            "    /*ABQIAAAArrevZR6A2Il2kVkLEx835hShUouseIHqOXoXQLY8cwfSo1jZ3xSbp3vx8p7EuTAMPKfotRSpJRItIQ*/ " +
            " </script> " +
            "    <script src=\"js/epoly.js\" type=\"text/javascript\"></script> ";


        }
        return scr;
    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Session["OwnerID"] = "";
        Session["OwnerWeight"] = "";
        Session["userName"] = "";
        Session["password"] = "";
        Response.Cookies.Add(new HttpCookie("password", ""));
        Response.Cookies.Add(new HttpCookie("userName", ""));
        Response.Cookies.Add(new HttpCookie("OwnerID", ""));
        Response.Cookies.Add(new HttpCookie("OwnerWeight", ""));
        Response.Redirect("login.aspx");

    }
}
