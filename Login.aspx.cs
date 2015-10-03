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
using System.Web.Security;
using MainDataModuleTableAdapters;


public partial class GoogleMap : System.Web.UI.Page
{

    public void checkBrowser()
    {
        string br = Request.Browser.Type;

        int indexMozilla = br.IndexOf('z');
        int indexFirefox = br.IndexOf('x');

        if (indexFirefox + indexMozilla > 0)
        {

        }
        else
        {
            Response.Redirect("DownloadFireFox.aspx");
        }


    }


    protected void Page_Load(object sender, EventArgs e)
    {
        checkBrowser();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }

    protected void sqld_way_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
     

    }
    protected void GetAllNewPositions(object sender, EventArgs e)
    {

    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
       

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }

    private bool AuthenticateMe(string userName, string password, bool rememberUserName)
    {
        bool auth = false;
        password = new main_class().Encode(password);
        if (new tbl_usersTableAdapter().CheckIfUserNameExistsOrNot(userName, password) == 1)
        {
            auth = true;
            Session["OwnerID"] = new tbl_usersTableAdapter().GetOwnerIDfromUsername(userName, password).ToString();
            Session["OwnerWeight"] = new tbl_OwnerTableAdapter().GetOwnerWieght(Convert.ToInt32(Session["OwnerID"].ToString()));
            Session["userName"] = userName;
            Session["password"] = password;
            Response.Cookies.Add(new HttpCookie("password",password));
            Response.Cookies.Add(new HttpCookie("userName", userName));
            Response.Cookies.Add(new HttpCookie("OwnerID", Session["OwnerID"].ToString()));
            Response.Cookies.Add(new HttpCookie("OwnerWeight", Session["OwnerWeight"].ToString()));
        }



        return auth;
    }




    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        bool authenticated = AuthenticateMe(Login1.UserName, Login1.Password, Login1.RememberMeSet);

        if (authenticated)
        {

            FormsAuthentication.RedirectFromLoginPage(Login1.UserName, Login1.RememberMeSet);
            
            

        }
    }
}
