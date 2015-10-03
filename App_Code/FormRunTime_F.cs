using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Web.SessionState;

/// <summary>
/// Summary description for FormRunTime_F
/// </summary>
public class FormRunTime_F 
{



    public FormRunTime_F()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    
    public string mainHtml = "";
    private string GetSelectQuery(int cmdID)
    {

        string unitid = HttpContext.Current.Session["UnitID"].ToString();

        string qry = " SELECT  " +
                     " ISNULL( (SELECT TOP 1 cmdEntVal_Value FROM tbl_CommandsEntryValue V " +
                     " WHERE V.cmdp_id = CP.cmdp_id and V.cmdp_UnitID=" + unitid + " ORDER BY cmdEntVal_ID DESC ) , cmdp_defaultParam ) cmdp_defaultParam , " +
                     " C.cmd_id, C.cmd_name, C.cmd_fa_name, C.cmd_desc, CP.cmdp_id, " +
                     " CP.cmdp_desc, CP.cmdp_type,  CP.cmdp_name, " +
                     " CP.cmdp_faname, CP.cmdp_check_from, CP.cmdp_check_to " +
                     " FROM tbl_Commands C " +
                     " INNER JOIN " +
                     " tbl_CommandsParam CP ON C.cmd_id = CP.cmdp_link_to_tblCommands " +
                     " Where C.cmd_id = " + cmdID.ToString() + " ;";

        return qry;
    }
    private DataSet GetCommandsSelectedRows(int cmdID, string connSTR)
    {
        DataSet ds = new DataSet();
        SqlDataAdapter adap = new SqlDataAdapter(GetSelectQuery(cmdID), connSTR);
        adap.Fill(ds);
        adap.Dispose();
        return ds;

    }
    public string CommandsDesign(string gu,int answerType,Page p, string pageName, string connectionString, int cmdID, string lblMainTitleCSSClass, string lblMainValueCSSClass, string lblStbTitleCSSClass, string lblStbDESCCSSClass, string txtCSSClass, string btnCSSClass)
    {
        DataSet ds = new DataSet();
        ds = GetCommandsSelectedRows(cmdID, connectionString);

        if (ds.Tables[0].Rows.Count == 0)
        {
            if (answerType == 1)
            {
                p.Response.Write(" بر اساس ورودی شما اطلاعاتی موجود نیست ");
            }
            else
            {
                return "";
            }
        }

        string d_FormName = ds.Tables[0].Rows[0]["cmd_fa_name"].ToString();
        string d_FromDESC = ds.Tables[0].Rows[0]["cmd_desc"].ToString();




        string mainHtmlTsgs;
        #region Main HTML

        #region Commands Part
        mainHtmlTsgs = " <table width=\"100%\"> ";
        mainHtmlTsgs += " <table width=\"100%\" dir=\"rtl\" > " +
                      " <tr> " +
            //"     <td  width=\"200px\" valign=\"top\"> " +
            //"         <h4 class=\""+lblCSSClass+"\" align=\"left\" > نام فرم </h1>   " + 
            //"     </td> " +
                      "     <td  width=\"200px\" class=\"" + lblMainTitleCSSClass + "\" align=\"left\" valign=\"top\"> " +
                      " نام فرم " +
                      "     </td> " +
            /////////////////////
                      "     <td width=\"10px\"> " +
                      "     </td> " +
                      "     <td class=\"" + lblMainValueCSSClass + "\" align=\"right\" dir=\"rtl\" width=\"80%\" > " +
                      " " + d_FormName + " " +
                      "     </td> " +
                      " </tr> " +
                      " <tr> " +
                      "     <td class=\"" + lblMainTitleCSSClass + "\" align=\"left\"  width=\"200px\" valign=\"top\"> " +
                      " توضیحات فرم " +
                      "     </td> " +
                      "     <td width=\"10px\"> " +
                      "     </td> " +
                      "     <td class=\"" + lblMainTitleCSSClass + "\" align=\"right\" dir=\"rtl\" width=\"80%\" > " +
                      " " + d_FromDESC + " " +
                      "     </td> " +
                      " </tr> " +
                      " </table> ";
        #endregion
        mainHtmlTsgs += " <br /> ";
        mainHtmlTsgs += " <br /> ";
        #region Commands Param Part
        mainHtmlTsgs += " <table width=\"100%\" dir=\"rtl\" > ";
        mainHtmlTsgs += " <tr> ";
        mainHtmlTsgs += "     <td  width=\"100%\" valign=\"top\"> ";

        int d_CommandParamCount = ds.Tables[0].Rows.Count;
        HttpContext.Current.Session["cmdPcmdC"] = ESP_EncryptText(d_CommandParamCount.ToString());
        HttpContext.Current.Session["cmdPcmdP"] = ESP_EncryptText("0");
        string d_FaName = "";
        string d_Default = "";
        string d_ValidationDESC = "";
        string d_DESC = "";
        int d_cmdp = 0;

        for (int i = 1; i <= d_CommandParamCount; i++)
        {
            // ds
            d_FaName = ds.Tables[0].Rows[i - 1]["cmdp_faname"].ToString();
            d_Default = ds.Tables[0].Rows[i - 1]["cmdp_defaultParam"].ToString();
            //d_ValidationDESC = ds.Tables[i - 1].Rows[0]["cmd_desc"].ToString();
            d_DESC = ds.Tables[0].Rows[i - 1]["cmdp_desc"].ToString();
            d_cmdp = int.Parse(ds.Tables[0].Rows[i - 1]["cmdp_id"].ToString());

            #region SET cmdp_type
            if (ds.Tables[0].Rows[i - 1]["cmdp_type"].ToString().Length > 0)
            {
                HttpContext.Current.Session["cmdPcmdT" + i.ToString()] = ESP_EncryptText(ds.Tables[0].Rows[i - 1]["cmdp_type"].ToString());
            }
            else
            {
                HttpContext.Current.Session["cmdPcmdT" + i.ToString()] = ESP_EncryptText("0");
            }
            #endregion

            #region SET cmdp_check_from
            if (ds.Tables[0].Rows[i - 1]["cmdp_check_from"].ToString().Length > 0)
            {
                HttpContext.Current.Session["cmdPcmdChF" + i.ToString()] = ESP_EncryptText(ds.Tables[0].Rows[i - 1]["cmdp_check_from"].ToString());
            }
            else
            {
                HttpContext.Current.Session["cmdPcmdChF" + i.ToString()] = ESP_EncryptText("0");
            }
            #endregion

            #region SET cmdp_check_to
            if (ds.Tables[0].Rows[i - 1]["cmdp_check_to"].ToString().Length > 0)
            {
                HttpContext.Current.Session["cmdPcmdChT" + i.ToString()] = ESP_EncryptText(ds.Tables[0].Rows[i - 1]["cmdp_check_to"].ToString());
            }
            else
            {
                HttpContext.Current.Session["cmdPcmdChT" + i.ToString()] = ESP_EncryptText("0");
            }
            #endregion

            // 
            mainHtmlTsgs += " <table width=\"100%\" dir=\"rtl\" > ";
            mainHtmlTsgs += " <tr> ";

            mainHtmlTsgs += "     <td class=\"" + lblStbTitleCSSClass + "\" align=\"left\" width=\"200px\" valign=\"top\"> ";
            mainHtmlTsgs += " " + d_FaName + " ";
            mainHtmlTsgs += "     </td> ";

            mainHtmlTsgs += "     <td  width=\"200px\" valign=\"top\"> ";
            //mainHtmlTsgs += "         <input title=\"" + d_cmdp.ToString() + "\" id=\"txt" + i.ToString() + "\" value=\"" + d_Default + "\" type=\"text\"   /> ";
            HttpContext.Current.Session["cmdPcmdI" + i.ToString()] = ESP_EncryptText(d_cmdp.ToString());

            mainHtmlTsgs += " <input class=\"" + txtCSSClass + "\"  id=\"txt" + i.ToString() + "\" value=\"" + d_Default + "\" type=\"text\"   /> ";
            mainHtmlTsgs += "     </td> ";

            mainHtmlTsgs += "     <td class=\"" + lblStbTitleCSSClass + "\" align=\"left\"  valign=\"top\"> ";
            mainHtmlTsgs += " " + d_ValidationDESC + " ";
            mainHtmlTsgs += "     </td> ";

            mainHtmlTsgs += " </tr> ";
            mainHtmlTsgs += " </table> ";
            ////////////////////////////////////////////////////////////////////////
            mainHtmlTsgs += " <table width=\"100%\" dir=\"rtl\" > ";
            mainHtmlTsgs += " <tr> ";

            mainHtmlTsgs += "     <td class=\"" + lblStbTitleCSSClass + "\" align=\"left\" width=\"200px\" valign=\"top\"> ";
            mainHtmlTsgs += " توضیحات ";
            mainHtmlTsgs += "     </td> ";

            mainHtmlTsgs += "     <td class=\"" + lblStbDESCCSSClass + "\" align=\"right\" width=\"80%\" valign=\"top\"> ";
            mainHtmlTsgs += " " + d_DESC + " ";
            mainHtmlTsgs += "     </td> ";

            mainHtmlTsgs += " </tr> ";
            mainHtmlTsgs += " </table> ";

            mainHtmlTsgs += " <br /> ";

        }
        mainHtmlTsgs += "     </td> " +
                        " </tr> " +
                        " </table> ";
        #endregion

        //  <input id="Button3" onclick="txt(3)"  type="button" value="button" />

        #region Submit
        mainHtmlTsgs += " <br /> ";

        mainHtmlTsgs += " <table width=\"100%\" dir=\"rtl\" > ";
        mainHtmlTsgs += " <tr> ";

        mainHtmlTsgs += "     <td align=\"center\"  width=\"100%\" valign=\"top\"> ";
        mainHtmlTsgs += " <a class=\"" + btnCSSClass + "\"  id=\"btnOK\" href=\"javascript:txt(" + d_CommandParamCount + ")\"  > تائید </a> ";
        mainHtmlTsgs += "     </td> ";

        mainHtmlTsgs += " </tr> ";
        mainHtmlTsgs += " </table> ";

        #endregion





        mainHtmlTsgs += " </table> ";

        mainHtmlTsgs += " <script language=\"javascript\" type=\"text/javascript\" > " +
                        "       function txt( xx ) " +
                        " { " +
                        " var i = 1 ; " +
                        " var t1 ; var gu=\""+gu+"\";" +
                        " var par = \"\" ; " +
                        " for ( i = 1 ; i <= xx ; i++ ) " +
                        " { " +
                        "     t1 = document.getElementById(\"txt\" + String(i) ) ; " +
                        "     par = \"" + pageName + "?ID1=\" + String(i) + \"&guid=\""+gu+"\"&ID2=\" + t1.value ; " +
                        "     location = par ; " +
                        
                        " } " +
                        
                        " } " +
                        
                        " <" + "/" + "script" + ">"; //   </script> ";

        #endregion

        /*
            <input title="dd" id="Text1" type="text" value="0"  />   
         */
        if (answerType == 1)
        {
p.Response.Write(mainHtmlTsgs);
return mainHtmlTsgs;
        }
        else
        {
 return mainHtmlTsgs;
        
        }
       


    }
    public bool CheckParamBug(int ID1)
    {
        bool r = false;
        int cmdPcmdCount = int.Parse(ESP_DecryptText(HttpContext.Current.Session["cmdPcmdC"].ToString()));
        int cmdPcmdPosition = 1 + int.Parse(ESP_DecryptText(HttpContext.Current.Session["cmdPcmdP"].ToString()));
        HttpContext.Current.Session["cmdPcmdP"] = ESP_EncryptText(cmdPcmdPosition.ToString());

        if (ID1 != cmdPcmdPosition)
        {
            r = false;
        }
        else
        {
            r = true;
        }

        if (ID1 > cmdPcmdCount)
        {
            r = false;
        }
        else
        {
            r = true;
        }



        return r;
    }
    public string InsertDateToDB(int ID1, string ID2,string GU, Page p, string connectionString, bool showAlert)
    {
        string r = "";
        bool r_check = false;
        string cmdPcmdT = ESP_DecryptText(HttpContext.Current.Session["cmdPcmdT" + ID1.ToString()].ToString());
        string cmdPcmdChF = ESP_DecryptText(HttpContext.Current.Session["cmdPcmdChF" + ID1.ToString()].ToString());
        string cmdPcmdChT = ESP_DecryptText(HttpContext.Current.Session["cmdPcmdChT" + ID1.ToString()].ToString());
        int unitID = Convert.ToInt32(HttpContext.Current.Session["UnitID"].ToString());
        #region Check Type
        if (cmdPcmdT.Length > 0)
        {
            if (cmdPcmdT == "1") // int
            {
                try
                {
                    int.Parse(ID2);
                    r_check = true;
                }
                catch
                {
                    r = " عبارت وارد شده در قسمت " + ID1.ToString() + " باید از نوع عدد صحیح باشد ";
                    r_check = false;
                }

                if (int.Parse(ID2) < int.Parse(cmdPcmdChF))
                {
                    r = " عبارت وارد شده در قسمت " + ID1.ToString() + " نباید کمتر از مقدار مینیمم تعیین شده باشد ";
                    r_check = false;
                }

                if (int.Parse(ID2) > int.Parse(cmdPcmdChT))
                {
                    r = " عبارت وارد شده در قسمت " + ID1.ToString() + " نباید کمتر از مقدار ماکزیمم تعیین شده باشد ";
                    r_check = false;
                }

            }
            else
                if (cmdPcmdT == "2") // float
                {
                    try
                    {
                        float.Parse(ID2);
                        r_check = true;
                    }
                    catch
                    {
                        r = " عبارت وارد شده در قسمت " + ID1.ToString() + " باید از نوع عدد اعشاری باشد ";
                        r_check = false;
                    }

                    if (float.Parse(ID2.ToString()) < float.Parse(cmdPcmdChF))
                    {
                        r = " عبارت وارد شده در قسمت " + ID1.ToString() + " نباید کمتر از مقدار مینیمم تعیین شده باشد ";
                        r_check = false;
                    }

                    if (float.Parse(ID2.ToString()) > float.Parse(cmdPcmdChT))
                    {
                        r = " عبارت وارد شده در قسمت " + ID1.ToString() + " نباید کمتر از مقدار ماکزیمم تعیین شده باشد ";
                        r_check = false;
                    }

                }
                else
                    if (cmdPcmdT == "3")  // string
                    {
                        r_check = true;
                    }
        }
        #endregion

        if (r_check == false)
        {
            return r;
        }
        else
        {
            #region Build Insert Query
            string qry = " INSERT INTO tbl_CommandsEntryValue " +
                         " ( cmdp_id , cmdEntVal_Value,cmdp_guid,cmdp_UnitID ) VALUES " +
                         " ( " + ESP_DecryptText(HttpContext.Current.Session["cmdPcmdI" + ID1.ToString()].ToString()) +
                         " , '" + ID2 + "','"+GU+"',"+unitID+") ";

            if (ID1 == 1)
            {
                HttpContext.Current.Session["cmdPcmdQ"] = ESP_EncryptText(qry);
            }
            else
            {
                HttpContext.Current.Session["cmdPcmdQ"] = ESP_EncryptText(ESP_DecryptText(HttpContext.Current.Session["cmdPcmdQ"].ToString()) + "  " + qry);
            }

            #endregion

            #region exec Insert Query
            if (ID1 == int.Parse(ESP_DecryptText(HttpContext.Current.Session["cmdPcmdC"].ToString())))
            {

                try
                {
                    string qryInsert = ESP_DecryptText(HttpContext.Current.Session["cmdPcmdQ"].ToString());
                    SqlConnection conec = new SqlConnection(connectionString);
                    SqlCommand cmd = new SqlCommand(ESP_DecryptText(HttpContext.Current.Session["cmdPcmdQ"].ToString()), conec);
                    cmd.CommandType = CommandType.Text;
                    conec.Open();
                    cmd.CommandText = qryInsert;
                    cmd.ExecuteNonQuery();
                    conec.Close();
                    r = " اطلاعات ذخیره شد ";
                }
                catch
                {
                    r = " ورود اطلاعات به دیتابیس با مشکل مواجه شد ";
                }
            }
            #endregion
        }

        if (showAlert == true)
        {
            // p.Response.Write(mainHtmlTsgs);
            string pSTRhtml = " <script language=\"javascript\" type=\"text/javascript\" > ";
            pSTRhtml += " alert('" + r + "') ";
            pSTRhtml += " </script> ";
            p.Response.Write(pSTRhtml);

        }


        return r;
    }
    #region Encrypt & Decrypt Functions
    private string ESP_EncryptText(string strText)
    {
        return Encrypt(strText, "d`h!r@a#f");
    }
    private string ESP_DecryptText(string strText)
    {
        return Decrypt(strText, "d`h!r@a#f");
    }
    private string Encrypt(string strText, string strEncrKey)
    {
        byte[] byKey;
        byte[] IV = { 18, 52, 86, 120, 144, 171, 205, 239 };

        try
        {
            byKey = System.Text.Encoding.UTF8.GetBytes(strEncrKey.Substring(0, 8));
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();
            byte[] inputByteArray = Encoding.UTF8.GetBytes(strText);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(byKey, IV), CryptoStreamMode.Write);
            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();
            return Convert.ToBase64String(ms.ToArray());
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }
    private string Decrypt(string strText, string sDecrKey)
    {
        byte[] byKey;
        byte[] IV = { 18, 52, 86, 120, 144, 171, 205, 239 };

        byte[] inputByteArray;

        try
        {
            byKey = System.Text.Encoding.UTF8.GetBytes(sDecrKey.Substring(0, 8));
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();
            inputByteArray = Convert.FromBase64String(strText);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(byKey, IV), CryptoStreamMode.Write);
            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            return encoding.GetString(ms.ToArray());
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }

    #endregion











}
