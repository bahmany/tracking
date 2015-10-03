using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MainDataModuleTableAdapters;

public partial class ascx_frm_CustomerManager : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["code"] != null)
            {
                Session.Remove("code");
            }
        }
    }
    public void clearform()
    {
        
        txt_addr.Text = "";
        txt_addrzarori.Text = "";
        txt_datebirth.Text = "";
        txt_family.Text = "";
        txt_handcode.Text = "";
        txt_MilliCode.Text = "";
        txt_name.Text = "";
        txt_postalcode.Text = "";
        txt_shsh.Text = "";
        txt_tel.Text = "";
        txt_telzarori.Text = "";
        txt_UnittID.Text = "";
        txt_cellno.Text = "";
        txt_PelakNo.Text = "";
        txt_Model.Text = "";
        txt_ShomarehKhas.Text = "";

    }
    protected void lnk_post_Click(object sender, EventArgs e)
    {

        try
        {

            if (Session["code"] == null)
            {
                //ods_customer.Insert();

            }
            else
            {
                string won = Session["OwnerID"].ToString();
                ods_customer.UpdateParameters["c_owner_link"].DefaultValue = won;
                ods_customer.Update();

            }
            clearform();
            dls_custmers.DataBind();

            Session.Remove("code");
        }
        catch (Exception _e)
        {
            Page.RegisterStartupScript("cc", "<script type=\"text/javascript\">alert('لطفا کد وسیله نقلیه را اصلاح نمایید')</script> ");

        }
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

    }
    protected void lnk_edit_Click(object sender, EventArgs e)
    {
        foreach (DataRow dr in new MainDataModuleTableAdapters.tbl_unitsTableAdapter().GetInformationOfByID
            (Convert.ToInt32((sender as LinkButton).ToolTip)))
        {
            Session["code"] = (sender as LinkButton).ToolTip;
            txt_addr.Text = dr["c_address"].ToString();
            txt_addrzarori.Text = dr["c_address_necessary"].ToString();
            txt_datebirth.Text = dr["c_birth_date"].ToString();
            txt_family.Text = dr["c_family"].ToString();
            txt_handcode.Text = dr["c_handcode"].ToString();
            txt_MilliCode.Text = dr["c_melli_code"].ToString();
            txt_name.Text = dr["c_name"].ToString();
            txt_postalcode.Text = dr["c_postal_code"].ToString();
            txt_shsh.Text = dr["c_shsh"].ToString();
            txt_tel.Text = dr["c_phonelineno"].ToString();
            txt_telzarori.Text = dr["c_phoneline_necessary"].ToString();
            drp_group.SelectedValue = dr["c_group_link"].ToString();
            drp_jensiat.SelectedValue = dr["c_sex"].ToString();
            txt_UnittID.Text = dr["c_unit_id"].ToString();
            txt_cellno.Text = dr["c_car_cellno"].ToString();
            txt_PelakNo.Text = dr["c_car_no"].ToString();
            txt_Model.Text = dr["c_car_badaneh"].ToString();

            //lt_jqexecuter.Text = "<script> var maskHeight = $(document).height(); var maskWidth = $(window).width();$('#mask').css({ 'width': maskWidth, 'height': maskHeight });$('#mask').fadeIn(1000);$('#mask').fadeTo(\"slow\", 0.8);var winH = $(window).height();var winW = $(window).width();$('#dialog').css('top', winH / 2 - $('#dialog').height() / 2);$('#dialog').css('left', winW / 2 - $('#dialog').width() / 2);$('#dialog').fadeIn(2000); </script>";
          }
    }
    protected void lnk_delete_Click(object sender, EventArgs e)
    {
        if (Session["code"] != null)
        {
            int id = Convert.ToInt32(Session["code"].ToString());
            //new MainDataModuleTableAdapters.tbl_customersTableAdapter().DeleteQuery(id);

        }
        if (Request.Cookies["code"] != null)
        {
            int id = Convert.ToInt32(Request.Cookies["code"].Value.ToString());
            //new MainDataModuleTableAdapters.tbl_customersTableAdapter().DeleteQuery(id);

        }
        
        
    }
    protected void lnk_delete_Click1(object sender, EventArgs e)
    {
       
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }
    protected void LinkButton1_Click1(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.PathAndQuery);
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.PathAndQuery);
    }
    protected void LinkButton3_Click(object sender, EventArgs e)
    {

        
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        
      
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {

    }
    protected void drp_cellpermission_SelectedIndexChanged(object sender, EventArgs e)
    {

        
    }
    protected void LinkButton2_Click1(object sender, EventArgs e)
    {



    }
    protected void chk_active_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void lnk_delete_Click2(object sender, EventArgs e)
    {
        try
        {
            new tbl_unitsTableAdapter().DeleteQuery(Convert.ToInt32((sender as LinkButton).ToolTip));
            dls_custmers.DataBind();
        }
        catch (Exception _e)
        {
            Page.RegisterStartupScript("cc", "<script type=\"text/javascript\">alert('سیستم توانایی حذف این مورد را ندارد چون در بانک اطلاعاتی موقعیت برای این وسیله ثبت شده است')</script> ");
        }
    }
}
