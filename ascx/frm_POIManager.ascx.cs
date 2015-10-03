using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;


public partial class ascx_frm_POIManager : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["OwnerID"] = 0;
       // Session["OwnerWeight"] = 0;

        if (!IsPostBack)
        {
            FillTree();
        }
    }
    string GetConnectionString()
    {
        return "Data Source=.;Initial Catalog=AriaAG;Persist Security Info=True;User ID=sa;PassWord=009100";
    }
    private int ExeSQLQry(string qry)
    {
        SqlConnection conn = new SqlConnection(GetConnectionString());
        SqlCommand cmd = new SqlCommand(qry, conn);
        conn.Open();
        return cmd.ExecuteNonQuery();

    }
    int poi_Layers_INSERT(int parentID, string caption)
    {
        string qry = " INSERT INTO tbl_poi_layers " +
                     " ( pl_parent_node_id " +
                     " , pl_caption " +
                     " , pl_owner_link " +
                     " , pl_weight " +
                     " ,[pl_is_last]) " +
                     " VALUES " +
                     " ( " + parentID.ToString() + " " +
                     " , '" + caption + "' " +
                     " , " + Session["OwnerID"].ToString() + " " +
                     " , " + Session["OwnerWeight"].ToString() + " " +
                     " , 1  ) ";
        ExeSQLQry(qry);
        return GetLastInsetedID(parentID, caption);

    }
    void poi_Layers_UPDATE(int pl_id, string caption)
    {
        string qry = " UPDATE tbl_poi_layers " +
                     " SET pl_caption = '" + caption + "'" +
                     " WHERE pl_id = " + pl_id.ToString();
        ExeSQLQry(qry);

    }
    int GetLastInsetedID(int parentID, string caption)
    {
        string qry = " SELECT  MAX(pl_id) AS fMAX FROM tbl_poi_layers ";
        int r = 0;

        SqlDataAdapter sda = new SqlDataAdapter(qry, GetConnectionString());
        DataSet ds = new DataSet();
        ds.Clear();
        sda.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            r = int.Parse(ds.Tables[0].Rows[0][0].ToString());
        }
        else
        {
            r = 0;
        }
        return r;
    }

    protected void RadTreeView1_NodeClick(object sender, Telerik.Web.UI.RadTreeNodeEventArgs e)
    {
        pnl_edit.Visible = true;
        txtCaptionEdit.Text = e.Node.Text;
     
    }
    protected void btnAddBranch_Click(object sender, EventArgs e)
    {
        Telerik.Web.UI.RadTreeNode n = new Telerik.Web.UI.RadTreeNode();
        n.Text = txtCaptionEdit.Text;
        if (rtvLayers.Nodes.Count == 0)
        {
            n.Value = poi_Layers_INSERT(0, txtCaptionEdit.Text).ToString();
            rtvLayers.Nodes.Add(n);
        }
        else
        {
            if (rtvLayers.SelectedNode != null)
            {
                if (rtvLayers.SelectedNode.ParentNode != null)
                {
                    n.Value = poi_Layers_INSERT(int.Parse(rtvLayers.SelectedNode.ParentNode.Value), txtCaptionEdit.Text).ToString();
                    rtvLayers.SelectedNode.ParentNode.Nodes.Add(n);
                }
                else
                {

                }



            }
        }

    }
    protected void btnAddSubBranch_Click(object sender, EventArgs e)
    {
        Telerik.Web.UI.RadTreeNode n = new Telerik.Web.UI.RadTreeNode();
        n.Text = txtCaptionEdit.Text;
        if (rtvLayers.Nodes.Count == 0)
        {
            n.Value = poi_Layers_INSERT(0, txtCaptionEdit.Text).ToString();
            rtvLayers.Nodes.Add(n);
        }
        else
        {
            if (rtvLayers.SelectedNode != null)
            {
                n.Value = poi_Layers_INSERT(int.Parse(rtvLayers.SelectedNode.Value), txtCaptionEdit.Text).ToString();
                rtvLayers.SelectedNode.Nodes.Add(n);
            }
        }
    }


    protected void btnCaptionEdit_Click(object sender, EventArgs e)
    {
        Telerik.Web.UI.RadTreeNode n = new Telerik.Web.UI.RadTreeNode();
        n.Text = txtCaptionEdit.Text;
        if (rtvLayers.Nodes.Count == 0)
        {

        }
        else
        {
            if (rtvLayers.SelectedNode != null)
            {
                rtvLayers.SelectedNode.Text = txtCaptionEdit.Text;
                poi_Layers_UPDATE(int.Parse(rtvLayers.SelectedNode.Value), txtCaptionEdit.Text);
            }
        }



    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    void FillTree()
    {
        string qry = " SELECT  * FROM tbl_poi_layers " +
                     " WHERE pl_owner_link = " + Session["OwnerID"].ToString() +
                     " AND pl_weight = " + Session["OwnerWeight"].ToString() +
                     " Order By pl_parent_node_id , pl_id ";

        SqlDataAdapter sda = new SqlDataAdapter(qry, GetConnectionString());
        DataSet ds = new DataSet();
        ds.Clear();
        sda.Fill(ds);
        int parID, priParID = 0;
        if (ds.Tables[0].Rows.Count > 0)
        {
            int mainNodeCount = 0;
            Boolean nodeAdded = false;
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                nodeAdded = false;
                Telerik.Web.UI.RadTreeNode n = new Telerik.Web.UI.RadTreeNode();
                n.Value = ds.Tables[0].Rows[i]["pl_id"].ToString().Trim();
                n.Text = ds.Tables[0].Rows[i]["pl_caption"].ToString().Trim();
                n.NavigateUrl = "javascript:SetActiveNodeID(" + ds.Tables[0].Rows[i]["pl_id"].ToString() + ",'" + ds.Tables[0].Rows[i]["pl_caption"].ToString() + "');";

                if (ds.Tables[0].Rows[i]["pl_parent_node_id"].ToString() == "0")
                {
                    rtvLayers.Nodes.Add(n);
                    mainNodeCount++;
                    nodeAdded = true;
                }
                else
                {
                    for (int j = 0; j < rtvLayers.Nodes.Count; j++)
                    {
                        if (ds.Tables[0].Rows[i]["pl_parent_node_id"].ToString() == rtvLayers.Nodes[j].Value)
                        {
                            rtvLayers.Nodes[j].Nodes.Add(n);
                            nodeAdded = true;
                        }

                    }

                }
                if (nodeAdded == false)
                {
                    for (int z = 0; z < mainNodeCount; z++)
                    {
                        if (node(rtvLayers.Nodes[z], ds.Tables[0].Rows[i]["pl_parent_node_id"].ToString()) != null)
                        {
                            node(rtvLayers.Nodes[z], ds.Tables[0].Rows[i]["pl_parent_node_id"].ToString()).Nodes.Add(n);  // 
                        }
                    }
                }
            }

        }


    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    Telerik.Web.UI.RadTreeNode node(Telerik.Web.UI.RadTreeNode nod, string v)
    {
        Telerik.Web.UI.RadTreeNode nn = null;
        Boolean f = false;
        for (int i = 0; i < nod.Nodes.Count; i++)
        {
            if (nod.Nodes[i].Value == v)
            {
                f = true;
                nn = nod.Nodes[i];
            }
        }
        if (f == false)
        {
            for (int i = 0; i < nod.Nodes.Count; i++)
            {
                nn = node(nod.Nodes[i], v);
                if (nn != null)
                {
                    f = true;
                    break;
                }
            }

        }

        return nn;
    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Telerik.Web.UI.RadTreeNode n = new Telerik.Web.UI.RadTreeNode();
        n.Text = "---";
        if (rtvLayers.Nodes.Count == 0)
        {
            n.Value = poi_Layers_INSERT(0, "---").ToString();
            rtvLayers.Nodes.Add(n);
        }
        else
        {
            if (rtvLayers.SelectedNode != null)
            {
                n.Value = poi_Layers_INSERT(int.Parse(rtvLayers.SelectedNode.ParentNode.Value), "---").ToString();

                rtvLayers.SelectedNode.ParentNode.Nodes.Add(n);
            }
        }
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Telerik.Web.UI.RadTreeNode n = new Telerik.Web.UI.RadTreeNode();
        n.Text = "---";
        if (rtvLayers.Nodes.Count == 0)
        {
            n.Value = poi_Layers_INSERT(0, "---").ToString();
            rtvLayers.Nodes.Add(n);
        }
        else
        {
            if (rtvLayers.SelectedNode != null)
            {
                n.Value = poi_Layers_INSERT(int.Parse(rtvLayers.SelectedNode.Value), "---").ToString();
                rtvLayers.SelectedNode.Nodes.Add(n);
            }
        }
    }


    protected void btnDeleteBranch_Click(object sender, EventArgs e)
    {
        Session["NodeChilds"] = "";
        nodeChildWhere(rtvLayers.SelectedNode);

       // Label1.Text = Session["NodeChilds"].ToString();

        if (Session["NodeChilds"].ToString().Length > 0)
        {
            string nodeDelQRY = " Delete From tbl_poi_layers Where " + Session["NodeChilds"].ToString();
           // Label2.Text = nodeDelQRY;
            rtvLayers.SelectedNode.Remove();

            ExeSQLQry(nodeDelQRY);
        }


    }

    protected void rtvLayers_NodeClick(object sender, Telerik.Web.UI.RadTreeNodeEventArgs e)
    {
        txtCaptionEdit.Text = e.Node.Text;
    }
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        Telerik.Web.UI.RadTreeNode n = new Telerik.Web.UI.RadTreeNode();
        n.Text = txtCaptionEdit.Text;
        if (rtvLayers.Nodes.Count == 0)
        {
            //n.Value = poi_Layers_INSERT(0, "---").ToString();
            //rtvLayers.Nodes.Add(n);
        }
        else
        {
            if (rtvLayers.SelectedNode != null)
            {
                rtvLayers.SelectedNode.Text = txtCaptionEdit.Text;
                poi_Layers_UPDATE(int.Parse(rtvLayers.SelectedNode.Value), txtCaptionEdit.Text);
            }
        }
        pnl_edit.Visible = false;
    }
    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        Session["NodeChilds"] = "";
        nodeChildWhere(rtvLayers.SelectedNode);
        if (Session["NodeChilds"].ToString().Length > 0)
        {
            string nodeDelQRY = " Delete From tbl_poi_layers Where " + Session["NodeChilds"].ToString();
            rtvLayers.SelectedNode.Remove();
        }

    }


    void nodeChildWhere(Telerik.Web.UI.RadTreeNode nod)
    {
        if (Session["NodeChilds"].ToString() != "")
        {
            Session["NodeChilds"] = Session["NodeChilds"].ToString() + " OR ";
        }

        Session["NodeChilds"] = Session["NodeChilds"].ToString() + " ( pl_id = " + nod.Value + " ) OR ( pl_parent_node_id = " + nod.Value + " ) ";

        for (int i = 0; i < nod.Nodes.Count; i++)
        {
            nodeChildWhere(nod.Nodes[i]);
        }
    }   
    /*
    
  
    void nodeChildWhere(Telerik.Web.UI.RadTreeNode nod)
    {
        if (Session["NodeChilds"].ToString().Length > 0)
        {
            Session["NodeChilds"] = Session["NodeChilds"] + " OR ";
        }

        Session["NodeChilds"] = Session["NodeChilds"] + " ( pl_id = " + nod.Value + " ) ";

        for (int i = 0; i < nod.Nodes.Count; i++)
        {
            nodeChildWhere(nod.Nodes[i]);
        }
    }
 */
}
