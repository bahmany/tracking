using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MainDataModuleTableAdapters;

public partial class ascx_frm_UnitsManagerAdmin : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lnk_delete.Visible = false;
        }
    }
    protected void drp_ownerID_SelectedIndexChanged(object sender, EventArgs e)
    {
        drp_unitsGroupList.DataBind();
        GridView1.DataBind();
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        int RowID = Convert.ToInt32((sender as LinkButton).ToolTip);
        foreach (DataRow dr in new tbl_unitsTableAdapter().GetInformationOfByID(RowID))
        {
            drp_ownerID.SelectedValue = dr["c_owner_link"].ToString();
            drp_unitsGroupList.DataBind();
            GridView1.DataBind();
            if (dr["c_group_link"] != null)
            {
                drp_unitsGroupList.SelectedValue = dr["c_group_link"].ToString();
            }   
            SelectedValue.Text = dr["c_unit_id"].ToString();
            Session["code"] = RowID.ToString();
            lnk_delete.Visible = true;


        }
      
    }
    protected void lnk_post_Click(object sender, EventArgs e)
    {
        if (Session["code"] != null)
        {
            int UnitRowID = Convert.ToInt32(Session["code"].ToString());
            int GroupID = -1;
            if (drp_unitsGroupList.Items.Count != 0)
            {
                GroupID = Convert.ToInt32(drp_unitsGroupList.SelectedValue);
            }
            if (GroupID != -1)
            {
                new tbl_unitsTableAdapter().UpdateQuery1(Convert.ToInt32(drp_ownerID.SelectedValue), Convert.ToInt32(SelectedValue.Text), GroupID, UnitRowID);
            }
            else
            {
                new tbl_unitsTableAdapter().UpdateQuery2(Convert.ToInt32(drp_ownerID.SelectedValue), Convert.ToInt32(SelectedValue.Text), UnitRowID);

            }
            GridView1.DataBind();
            Session.Remove("code");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "dfwe", "alert('تغییرات ثبت شد');", true);
        }
        else
        {

                new tbl_unitsTableAdapter().InsertQuery(
                    Convert.ToInt32(drp_ownerID.SelectedValue),
                    Convert.ToInt32(drp_unitsGroupList.SelectedValue),
                    "",
                    "",
                    1, "", "", "", "", "", "", "", "", "", Convert.ToInt32(SelectedValue.Text), "", "", "", "");
                GridView1.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "dfwe", "alert('اضافه سازی با موفقیت انجام شد');", true);
        }
        SelectedValue.Text = "";
    }
    protected void lnk_delete_Click(object sender, EventArgs e)
    {
        if (Session["code"] != null)
        {
            try
            {
                int UnitRowID = Convert.ToInt32(Session["code"].ToString());
                new tbl_unitsTableAdapter().DeleteQuery(UnitRowID);
                GridView1.DataBind();
                Session.Remove("code");
                lnk_delete.Visible = false;
            }
            catch (Exception __e)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "dfwe", "<script type=\"text/javascript\">alert('سیستم توانایی حذف این مورد را ندارد چون در بانک اطلاعاتی موقعیت برای این وسیله ثبت شده است')</script> ",false);

            }
        }
    }
}
