using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Collections;
using System.IO;
using MainDataModuleTableAdapters;

/// <summary>
/// Summary description for main_class
/// </summary>
/// 
//namespace parsfoulad
//{
public class main_class
{
    public static string Encrypt(string plainText, string passPhrase, string saltValue, string hashAlgorithm, int passwordIterations, string initVector, int keySize)
    {
        // Convert strings into byte arrays.
        // Let us assume that strings only contain ASCII codes.
        // If strings include Unicode characters, use Unicode, UTF7, or UTF8 
        // encoding.
        byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
        byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);

        // Convert our plaintext into a byte array.
        // Let us assume that plaintext contains UTF8-encoded characters.
        byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);

        // First, we must create a password, from which the key will be derived.
        // This password will be generated from the specified passphrase and 
        // salt value. The password will be created using the specified hash 
        // algorithm. Password creation can be done in several iterations.
        PasswordDeriveBytes password = new PasswordDeriveBytes(
                                                        passPhrase,
                                                        saltValueBytes,
                                                        hashAlgorithm,
                                                        passwordIterations);

        // Use the password to generate pseudo-random bytes for the encryption
        // key. Specify the size of the key in bytes (instead of bits).
        byte[] keyBytes = password.GetBytes(keySize / 8);

        // Create uninitialized Rijndael encryption object.
        RijndaelManaged symmetricKey = new RijndaelManaged();

        // It is reasonable to set encryption mode to Cipher Block Chaining
        // (CBC). Use default options for other symmetric key parameters.
        symmetricKey.Mode = CipherMode.CBC;

        // Generate encryptor from the existing key bytes and initialization 
        // vector. Key size will be defined based on the number of the key 
        // bytes.
        ICryptoTransform encryptor = symmetricKey.CreateEncryptor(
                                                         keyBytes,
                                                         initVectorBytes);

        // Define memory stream which will be used to hold encrypted data.
        MemoryStream memoryStream = new MemoryStream();

        // Define cryptographic stream (always use Write mode for encryption).
        CryptoStream cryptoStream = new CryptoStream(memoryStream,
                                                     encryptor,
                                                     CryptoStreamMode.Write);
        // Start encrypting.
        cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);

        // Finish encrypting.
        cryptoStream.FlushFinalBlock();

        // Convert our encrypted data from a memory stream into a byte array.
        byte[] cipherTextBytes = memoryStream.ToArray();

        // Close both streams.
        memoryStream.Close();
        cryptoStream.Close();

        // Convert encrypted data into a base64-encoded string.
        string cipherText = Convert.ToBase64String(cipherTextBytes);

        // Return encrypted string.
        return cipherText;
    }
    public static string Decrypt(string cipherText, string passPhrase, string saltValue, string hashAlgorithm, int passwordIterations, string initVector, int keySize)
    {
        // Convert strings defining encryption key characteristics into byte
        // arrays. Let us assume that strings only contain ASCII codes.
        // If strings include Unicode characters, use Unicode, UTF7, or UTF8
        // encoding.
        byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
        byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);

        // Convert our ciphertext into a byte array.
        byte[] cipherTextBytes = Convert.FromBase64String(cipherText);

        // First, we must create a password, from which the key will be 
        // derived. This password will be generated from the specified 
        // passphrase and salt value. The password will be created using
        // the specified hash algorithm. Password creation can be done in
        // several iterations.
        PasswordDeriveBytes password = new PasswordDeriveBytes(
                                                        passPhrase,
                                                        saltValueBytes,
                                                        hashAlgorithm,
                                                        passwordIterations);

        // Use the password to generate pseudo-random bytes for the encryption
        // key. Specify the size of the key in bytes (instead of bits).
        byte[] keyBytes = password.GetBytes(keySize / 8);

        // Create uninitialized Rijndael encryption object.
        RijndaelManaged symmetricKey = new RijndaelManaged();

        // It is reasonable to set encryption mode to Cipher Block Chaining
        // (CBC). Use default options for other symmetric key parameters.
        symmetricKey.Mode = CipherMode.CBC;

        // Generate decryptor from the existing key bytes and initialization 
        // vector. Key size will be defined based on the number of the key 
        // bytes.
        ICryptoTransform decryptor = symmetricKey.CreateDecryptor(
                                                         keyBytes,
                                                         initVectorBytes);

        // Define memory stream which will be used to hold encrypted data.
        MemoryStream memoryStream = new MemoryStream(cipherTextBytes);

        // Define cryptographic stream (always use Read mode for encryption).
        CryptoStream cryptoStream = new CryptoStream(memoryStream,
                                                      decryptor,
                                                      CryptoStreamMode.Read);

        // Since at this point we don't know what the size of decrypted data
        // will be, allocate the buffer long enough to hold ciphertext;
        // plaintext is never longer than ciphertext.
        byte[] plainTextBytes = new byte[cipherTextBytes.Length];

        // Start decrypting.
        int decryptedByteCount = cryptoStream.Read(plainTextBytes,
                                                   0,
                                                   plainTextBytes.Length);

        // Close both streams.
        memoryStream.Close();
        cryptoStream.Close();

        // Convert decrypted data into a string. 
        // Let us assume that the original plaintext string was UTF8-encoded.
        string plainText = Encoding.UTF8.GetString(plainTextBytes,
                                                   0,
                                                   decryptedByteCount);

        // Return decrypted string.   
        return plainText;
    }
    public string Encode(string str)
    {
        string plainText = str;    // original plaintext

        string passPhrase = "bahmanymb@gmail.com";        // can be any string
        string saltValue = "mohammad_mrb@yahoo.com";        // can be any string
        string hashAlgorithm = "SHA1";             // can be "MD5"
        int passwordIterations = 2;                  // can be any number
        string initVector = "@1B2ceD4e5F6g7H8"; // must be 16 bytes
        int keySize = 128;                // can be 192 or 128
        return Encrypt(plainText, passPhrase, saltValue, hashAlgorithm, passwordIterations, initVector, keySize);


    }
    public string Decode(string str)
    {
        string plainText = str;    // original plaintext

        string passPhrase = "bahmanymb@gmail.com";        // can be any string
        string saltValue = "mohammad_mrb@yahoo.com";        // can be any string
        string hashAlgorithm = "SHA1";             // can be "MD5"
        int passwordIterations = 2;                  // can be any number
        string initVector = "@1B2ceD4e5F6g7H8"; // must be 16 bytes
        int keySize = 128;                // can be 192 or 128
        return Decrypt(plainText, passPhrase, saltValue, hashAlgorithm, passwordIterations, initVector, keySize);


    }
    public struct user
    {
        public bool is_user_available;
        public string user_name;
        public string user_email;
        public string user_family;
        public DateTime last_visit_milady;
        public string last_visit_shamsi;
        public int user_id;
    }
    public main_class()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    #region ConvertRaghamToHorof
    /// <summary>
    /// عدد رادریافت وبه حروف تبدیل می کند 
    /// </summary>
    /// <param name="Ragham">رقم </param>
    /// <returns>به حروف عدد را برمی گرداند</returns>

    /// <summary>
    /// یک عدد به صورت سه رقم جدا را دریافت وبه حروف تبدیل می کند
    /// </summary>
    /// <param name="Ragham"></param>
    /// <returns></returns>
    public static string ConvertRaghamToHorof(string Ragham)
    {
        string horof = "";

        try
        {
            string[] AddJoda = Ragham.Split(',');
            for (int i = 0; i < AddJoda.Length; i++)
            {
                //MessageBox.Show(AddJoda[i]);
                string strh = pishConvertRaghamToHorof3(int.Parse(AddJoda[i]), AddJoda.Length - i);
                if (horof == "")
                {
                    horof = horof + strh;
                }
                else
                {
                    if (strh != "") horof = horof + " و " + strh;
                }

            }
            return horof;
        }
        catch (Exception e1)
        {
            return "error";
        }
        finally
        {
        }

    }
    /// <summary>
    /// اعداد از صفر تا 19 را به حروف تبدیل میکند
    /// </summary>
    /// <param name="Ragham">عدد بین 0 تا 19</param>
    /// <returns>حروف را برمی گرداند در صورت خطا -1  و درصورت عدد نامعتبر تهی برمی گرداند</returns>
    private static string ConvertRaghamToHorof0to19(int Ragham)
    {
        try
        {
            //اعداد صفر  تا بیست
            if (Ragham > 19) return "";
            switch (Ragham)
            {
                case 0:
                    return "صفر";
                    break;

                case 1:
                    return "یک ";
                    break;
                case 2:
                    return "دو";
                    break;
                case 3:
                    return "سه ";
                    break;
                case 4:
                    return "چهار";
                    break;
                case 5:
                    return "پنج ";
                    break;
                case 6:
                    return "شش ";
                    break;
                case 7:
                    return "هفت ";
                    break;
                case 8:
                    return "هشت ";
                    break;
                case 9:
                    return "نه ";
                    break;
                case 10:
                    return "ده ";
                case 11:
                    return "یازده ";
                case 12:
                    return "دوازده ";
                case 13:
                    return "سیزده ";
                case 14:
                    return "چهارده ";
                case 15:
                    return "پانزده ";
                case 16:
                    return "شانزده ";
                case 17:
                    return "هیفده ";
                case 18:
                    return "هیجده ";
                case 19:
                    return "نوزده ";
                //case 20:
                //    return "بیست"; 

            }


            return "";
        }
        catch (Exception e)
        {
            return "-1";
        }
        finally
        {
        }

    }
    /// <summary>
    /// اعداد از بیست   تا نود نه را به حروف تبدیل میکند
    /// </summary>
    /// <param name="Ragham">عدد بین 20 تا 99</param>
    /// <returns>حروف را برمی گرداند در صورت خطا -1  و درصورت عدد نامعتبر تهی برمی گرداند</returns>
    private static string ConvertRaghamToHorof20to99(int Ragham)
    {
        try
        {
            //اعداد صفر  تا بیست
            if (!(Ragham > 19 && Ragham < 100)) return "";
            // برای تبدیل به حروف  رقم دوم
            string str = ConvertRaghamToHorof0to19(int.Parse(Ragham.ToString().Substring(1)));
            if (Ragham > 19 && Ragham < 30)
            {
                if (Ragham == 20)
                {
                    return "بیست";
                }
                else
                {
                    return "بیست و" + str;
                }

            }
            else if (Ragham > 29 && Ragham < 40)
            {
                if (Ragham == 30)
                {
                    return "سی";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "سی و" + str;
                }
            }
            else if (Ragham > 39 && Ragham < 50)
            {
                if (Ragham == 40)
                {
                    return "چهل";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "چهل و" + str;
                }
            }
            else if (Ragham > 49 && Ragham < 60)
            {
                if (Ragham == 50)
                {
                    return "پنجاه";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "پنجاه و" + str;
                }
            }
            else if (Ragham > 59 && Ragham < 70)
            {
                if (Ragham == 60)
                {
                    return "شصت";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "شصت و" + str;
                }
            }
            else if (Ragham > 69 && Ragham < 80)
            {
                if (Ragham == 70)
                {
                    return "هفتاد";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "هفتادو" + str;
                }
            }
            else if (Ragham > 79 && Ragham < 90)
            {
                if (Ragham == 80)
                {
                    return "هشتاد";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "هشتادو" + str;
                }
            }
            else if (Ragham > 89 && Ragham < 100)
            {
                if (Ragham == 90)
                {
                    return "نود";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "نودو" + str;
                }
            }
            return "";
        }
        catch (Exception e)
        {
            return "-1";
        }
        finally
        {
        }

    }
    /// <summary>
    /// اعداد از 0   تا نود نه را به حروف تبدیل میکند
    /// </summary>
    /// <param name="Ragham">عدد بین 0 تا 99</param>
    /// <returns>حروف را برمی گرداند در صورت خطا -1  و درصورت عدد نامعتبر تهی برمی گرداند</returns>
    private static string ConvertRaghamToHorof0to99(int Ragham)
    {
        try
        {
            if (Ragham > 99) return "";
            if (Ragham < 20)
            {
                return ConvertRaghamToHorof0to19(Ragham);
            }
            else if (Ragham < 100)
            {
                return ConvertRaghamToHorof20to99(Ragham);
            }
            return "";
        }
        catch (Exception e)
        {
            return "";
        }
        finally
        { }
    }
    /// <summary>
    /// اعداد از صد  تانهصدو نودو نه را به حروف تبدیل میکند
    /// </summary>
    /// <param name="Ragham">عدد بین 100 تا 999</param>
    /// <returns>حروف را برمی گرداند در صورت خطا -1  و درصورت عدد نامعتبر تهی برمی گرداند</returns>
    private static string ConvertRaghamToHorof100to999(int Ragham)
    {
        try
        {
            //اعداد 100  تا 999
            if (!(Ragham > 99 && Ragham < 1000)) return "";
            // برای تبدیل به حروف  رقم دوم

            string str = ConvertRaghamToHorof0to99(int.Parse(Ragham.ToString().Substring(1)));
            if (Ragham > 99 && Ragham < 200)
            {
                if (Ragham == 100)
                {
                    return "صد";
                }
                else
                {
                    return "صدو" + str;
                }

            }
            else if (Ragham > 199 && Ragham < 300)
            {
                if (Ragham == 200)
                {
                    return "دویست";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "دویست و" + str;
                }
            }
            else if (Ragham > 299 && Ragham < 400)
            {
                if (Ragham == 300)
                {
                    return "سیصد";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "سیصدو" + str;
                }
            }
            else if (Ragham > 399 && Ragham < 500)
            {
                if (Ragham == 400)
                {
                    return "چهارصد";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "چهارصدو" + str;
                }
            }
            else if (Ragham > 499 && Ragham < 600)
            {
                if (Ragham == 500)
                {
                    return "پانصد";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "پانصدو" + str;
                }
            }
            else if (Ragham > 599 && Ragham < 700)
            {
                if (Ragham == 600)
                {
                    return "ششصد";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "ششصدو" + str;
                }
            }
            else if (Ragham > 699 && Ragham < 800)
            {
                if (Ragham == 700)
                {
                    return "هفتصد";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "هفتصدو" + str;
                }
            }
            else if (Ragham > 799 && Ragham < 900)
            {
                if (Ragham == 800)
                {
                    return "هشتصد";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "هشتصدو" + str;
                }
            }
            else if (Ragham > 899 && Ragham < 1000)
            {
                if (Ragham == 900)
                {
                    return "نهصد";
                }
                else
                {
                    //string str = ConvertRaghamToHorof0to20(Ragham.ToString().Substring(1));
                    return "نهصدو" + str;
                }
            }
            return "";
        }
        catch (Exception e)
        {
            return "-1";
        }
        finally
        {
        }

    }
    /// <summary>
    /// اعداد از صفر تا 999 را به حروف تبدیل می کند
    /// </summary>
    /// <param name="Ragham"></param>
    /// <returns></returns>
    private static string ConvertRaghamToHorof0to999(int Ragham)
    {
        try
        {

            if (!(Ragham < 1000)) return "";

            if (Ragham < 20)
            {
                return ConvertRaghamToHorof0to19(Ragham);
            }
            else if (Ragham > 19 && Ragham < 100)
            {
                return ConvertRaghamToHorof20to99(Ragham);
            }
            else if (Ragham > 99 && Ragham < 1000)
            {
                return ConvertRaghamToHorof100to999(Ragham);
            }
            else
            {
                return "خطا برنامه نویسی";
            }

            return "";
        }
        catch (Exception e)
        {
            return "-1";
        }
        finally
        {
        }

    }
    /// <summary>
    /// یک عدد سه رقمی و موقعیت انرا دریافت و به حروف تبدیل می کند
    /// </summary>
    /// <param name="Ragham">عدد سه رقمی</param>
    /// <param name="LocationRagham"> موقیت عدد 2 =هزار 3== میلیون 4= میلیارد</param>
    /// <returns></returns>
    private static string pishConvertRaghamToHorof3(int Ragham, int LocationRagham)
    {
        try
        {   //اگر عدد صفر نیازبه پیش ندارد
            if (Ragham == 0) return "";
            if (Ragham > 1000) return "";

            //string str = ConvertRaghamToHorof0to999(Ragham);
            if (Ragham == 0) return "";
            switch (LocationRagham)
            {
                case 1:
                    return ConvertRaghamToHorof0to999(Ragham);
                case 2:
                    return ConvertRaghamToHorof0to999(Ragham) + " هزار";
                case 3:
                    return ConvertRaghamToHorof0to999(Ragham) + " میلیون ";
                case 4:
                    return ConvertRaghamToHorof0to999(Ragham) + " میلیارد";
                case 5:
                    return ConvertRaghamToHorof0to999(Ragham) + "تریلیارد";
                case 6:

                    return ConvertRaghamToHorof0to999(Ragham) + " ??? ";
                case 7:

                    return ConvertRaghamToHorof0to999(Ragham) + " ??? ";
                case 8:

                    return ConvertRaghamToHorof0to999(Ragham) + " ??? ";
                case 9:

                    return ConvertRaghamToHorof0to999(Ragham) + " ??? ";
            }

            return "";
        }
        catch (Exception e)
        {
            return "error";
        }
        finally
        {
        }

    }

    /// <summary>
    /// یک رقم را سه رقم سه رقم جدا می کند
    /// </summary>
    /// <param name="Ragham">رقم که باید حداکثر دوازده رقم باشد</param>
    /// <returns>جداشده سه رقم سه رقم را برمی گرداند</returns>
    public static string ConvertRaghamToJodaJoda(Int64 Ragham)
    {

        try
        {
            string Add = Ragham.ToString();
            Add = Add.Trim(); //فقط دوازده رقم را پشتیبانی می کند
            if (Add.Length > 15) Add = Add.Substring(0, 15);
            if (Add.Trim() == "")
            {

                return "";
            }

            string j = "";

            if ((Add.Length > 3 && Add.Length < 6) || Add.Length == 6)
            {
                //MessageBox.Show(i.Substring(3, 1));
                Add = Add.Substring(0, Add.Length - 3) + "," + Add.Substring(Add.Length - 3, 3);
            }
            else if ((Add.Length > 6 && Add.Length < 9) || Add.Length == 9)
            {

                Add = Add.Substring(0, Add.Length - 6) +
                       "," + Add.Substring(Add.Length - 6, 3) +
                       "," + Add.Substring(Add.Length - 3, 3);

            }
            else if ((Add.Length > 9 && Add.Length < 12) || Add.Length == 12)
            {
                //MessageBox.Show(i.Substring(3, 1));
                Add = Add.Substring(0, Add.Length - 9) +
                      "," + Add.Substring(Add.Length - 9, 3) +
                      "," + Add.Substring(Add.Length - 6, 3) +
                "," + Add.Substring(Add.Length - 3, 3);
                //Add = Add.Substring(0, 3) +
                //       "," + Add.Substring(3, 3) +
                //       "," + Add.Substring(6, 3) +
                //       "," + Add.Substring(9, Add.Length - 9);
            }
            else if (Add.Length > 12 && Add.Length < 15)
            {
                //MessageBox.Show(i.Substring(3, 1));
                Add = Add.Substring(0, 3) +
                       "," + Add.Substring(3, 3) +
                       "," + Add.Substring(6, 3) +
                        "," + Add.Substring(9, 3) +
                       "," + Add.Substring(12, Add.Length - 12);
            }
            else if (Add.Length < 3)
            {

            }

            return Add;
        }


        catch (Exception e)
        {
            //ClsGlobalClass.ShowMessageErrorFarsi(e, "ConvertRaghamToJodaJoda(Int64 Ragham)");
            return "";

        }
        finally
        {
            //ObjBankPatern.SqlConnection.Close();
            //cmd.Dispose();
            //dap.Dispose();
        }
    }
    #endregion ConvertRaghamToHorof
    public string GetParamValue(string param_name)
    {
        string res = "";
        SqlConnection sqlc = new SqlConnection(get_connection_string());
        SqlCommand sqlcm = new SqlCommand(string.Format("select st_value from tbl_settings where (st_name = '{0}')", param_name), sqlc);
        sqlc.Open();
        SqlDataReader sqldr = sqlcm.ExecuteReader();

        if (sqldr.HasRows)
        {
            while (sqldr.Read())
            {
                res = Decode(sqldr["st_value"].ToString());
            }
        }
        return res;
    }
    public bool send_user_forgotten_password(string user_email)
    {

        SqlConnection sqlc = new SqlConnection(get_connection_string());
        SqlCommand sqlcm = new SqlCommand(string.Format("select u_pass from tbl_users where (u_email = '{0}')", user_email), sqlc);
        sqlc.Open();
        SqlDataReader sqldr = sqlcm.ExecuteReader();

        if (sqldr.HasRows)
        {
            while (sqldr.Read())
            {
                send_email(user_email, GetParamValue("pub_fa_company_name") + "'s Password",
                    "<p style=\"padding: 10px; font-family: Tahoma; font-size: 20px; font-weight: bold; background-color: #000099; color: #FFFFFF; height: 23px; text-align: left; vertical-align: middle;\">Atiehfoulad</p> " +
                    "<div> Your Password is :" + Decode(sqldr["u_pass"].ToString()) + "</div>");
                break;

            }
        }
        if (sqldr.HasRows != true) { return false; } else { return true; }

    }
    public string get_value_from_setting(string value)
    {
        string txt = "";
        SqlConnection sqlc = new SqlConnection(get_connection_string());
        SqlCommand sqlcm = new SqlCommand(string.Format("select * from tbl_settings where (st_name = '{0}')", value), sqlc);
        sqlc.Open();
        SqlDataReader sqldr = sqlcm.ExecuteReader();

        if (sqldr.HasRows)
        {
            while (sqldr.Read())
            {
                return txt = Decode(sqldr["st_value"].ToString());
            }
        }
        return txt;

    }
    public void send_email(string _to, string subject, string body)
    {
        MailMessage Message = new MailMessage();
        SmtpClient Smtp = new SmtpClient();
        System.Net.NetworkCredential SMTPUserInfo = new System.Net.NetworkCredential(GetParamValue("pub_email_address"), GetParamValue("pub_email_password"));
        Message.From = new MailAddress(GetParamValue("pub_email_address"), GetParamValue("pub_en_company_name"));
        Message.To.Add(new MailAddress(_to, "Clients"));
        Message.IsBodyHtml = true;
        Message.Subject = subject;

        Message.Body = body;
        Smtp.Host = GetParamValue("pub_smtp");
        Smtp.UseDefaultCredentials = false;
        Smtp.Credentials = SMTPUserInfo;
        Smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
        Smtp.Send(Message);
    }
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
    public bool check_if_user_email_exists(string email)
    {
        SqlConnection sqlc = new SqlConnection(get_connection_string());
        SqlCommand sqlcm = new SqlCommand(string.Format("select * from registration where (reg_email = '{0}')", email), sqlc);
        sqlc.Open();
        SqlDataReader sqldr = sqlcm.ExecuteReader();
        if (sqldr.HasRows) { return true; } else { return false; }
    }
    public bool is_user_available_by_username(string username)
    {

        bool is_ava = false;
        SqlConnection sqlc = new SqlConnection(get_connection_string());
        sqlc.Open();
        SqlCommand sqlcm = new SqlCommand("select count(*) as total from tbl_users where (cast(u_username as nvarchar(max)) = '" + username + "')", sqlc);
        SqlDataReader sqldr = sqlcm.ExecuteReader();
        if (sqldr.HasRows != true)
        { is_ava = false; }
        else
        {
            if (sqldr.HasRows)
            {
                while (sqldr.Read())
                {
                    if (sqldr["total"].ToString() != "1")
                    {
                        is_ava = false;
                    }
                    else { is_ava = true; }
                }
            }
            sqldr.Close();
            sqlc.Close();

        }
        return is_ava;
    }
    public string Convert_Record_to_Its_Value(string TableName, string FieldName, string KeyField, string KeyFieldValue)
    {
        string str = "-1";
        SqlConnection sqlc = new SqlConnection(get_connection_string());
        SqlCommand sqlcm = new SqlCommand(string.Format("select top 1 {0} from {1} where ({2} = {3})",
            FieldName, TableName, KeyField, KeyFieldValue
            ), sqlc);
        sqlc.Open();
        SqlDataReader sqldr = sqlcm.ExecuteReader();
        if (sqldr.HasRows)
        {
            while (sqldr.Read())
            {
                str = sqldr[FieldName].ToString();
            }
        }
        sqldr.Close();
        return str;
    }
    public string get_user_id(string _email)
    {
        string str = "-1";
        SqlConnection sqlc = new SqlConnection(get_connection_string());
        SqlCommand sqlcm = new SqlCommand(string.Format("select * from registration where (reg_email = '{0}')", _email), sqlc);
        sqlc.Open();
        SqlDataReader sqldr = sqlcm.ExecuteReader();
        if (sqldr.HasRows)
        {
            while (sqldr.Read())
            {
                str = sqldr["id"].ToString();
            }
        }
        sqldr.Close();
        return str;
    }
    public string get_user_email(int id)
    {
        string str = "-1";
        SqlConnection sqlc = new SqlConnection(get_connection_string());
        SqlCommand sqlcm = new SqlCommand(string.Format("select * from registration where (id = {0})", id), sqlc);
        sqlc.Open();
        SqlDataReader sqldr = sqlcm.ExecuteReader();
        if (sqldr.HasRows)
        {
            while (sqldr.Read())
            {
                str = sqldr["reg_email"].ToString();
            }
        }
        sqldr.Close();
        return str;
    }
    public user check_user(string user_name, string user_pass, string page_address)
    {
        user _user = new user();

        SqlConnection sqlc = new SqlConnection(get_connection_string());
        SqlCommand sqlcm = new SqlCommand(string.Format("select * from registration where (reg_email = '{0}') and (reg_pass = '{1}')", user_name, user_pass), sqlc);
        sqlc.Open();
        SqlDataReader sqldr = sqlcm.ExecuteReader();

        _user.is_user_available = false;
        if (sqldr.HasRows)
        {
            while (sqldr.Read())
            {
                if (_user.is_user_available == true)
                {
                    _user.is_user_available = false; // for disabling hackers purposes "SQL INJECTION"
                    break;
                }

                _user.is_user_available = true;
                _user.user_email = sqldr["reg_email"].ToString();
                _user.user_family = sqldr["reg_familly"].ToString();
                _user.user_name = sqldr["reg_name"].ToString();
                _user.user_id = Convert.ToInt32(sqldr["id"].ToString());

            }

        }
        sqldr.Close();
        if (_user.is_user_available == true)
        {


            SqlCommand _sqlcm = new SqlCommand(
                string.Format("insert into visits (vi_user_id,vi_addr,vi_date) values ({0},'{1}',GetDate())", _user.user_id, page_address)
                , sqlc);
            _sqlcm.ExecuteNonQuery();
        }

        // for web counter in database ......................................

        SqlCommand __sqlcm = new SqlCommand("insert into visits_count (_date) values (GetDate())", sqlc);
        __sqlcm.ExecuteNonQuery();

        return _user;
    }
    public int execute_command(string command)
    {

        SqlConnection sqlc = new SqlConnection(new main_class().get_connection_string());
        sqlc.Open();
        SqlCommand sqlcm = new SqlCommand(command, sqlc);
        return sqlcm.ExecuteNonQuery();
        sqlc.Close();
    }
    public void insert_into_visitor()
    {
        execute_command("insert into visits_count (_date) values (GetDate())");
    }
    public int GetUser_GroupID(string username)
    {
        int groupid = 0;

        SqlConnection sqlc = new SqlConnection(get_connection_string());
        SqlCommand sqlcm = new SqlCommand("select * from tbl_users where u_username = '" + username + "'", sqlc);
        sqlc.Open();
        SqlDataReader sqldr = sqlcm.ExecuteReader();

        while (sqldr.Read())
        {
            groupid = Convert.ToInt16(sqldr["u_group"].ToString());
        }


        sqlc.Close();
        return groupid;

    }
    public string Load_Control(string form_name, string username, string password)
    {

        tbl_users_permissionTableAdapter upta = new tbl_users_permissionTableAdapter();
        MainDataModule.tbl_users_permissionDataTable dta = new MainDataModule.tbl_users_permissionDataTable();
        upta.Fill(dta, username, password, form_name);
        int user_premission = 0;
        int u_moduleid = 0;
        int group_id = 0;
        string m_name = "";
        try
        {
            DataRow dr = dta[0];
            user_premission = Convert.ToInt16(Convert.ToBoolean(dr["up_blocked"].ToString()));
            u_moduleid = Convert.ToInt16(dr["up_module_link"].ToString());
            //  group_id = Convert.ToInt16(dr["up_module_link"].ToString());


        }
        catch
        {
            user_premission = 2;
        }

        try
        {
            tbl_modulesTableAdapter mta = new tbl_modulesTableAdapter();
            MainDataModule.tbl_modulesDataTable mdt = new MainDataModule.tbl_modulesDataTable();
            mta.FillBy(mdt, form_name);
            DataRow drm = mdt[0];
            m_name = drm["m_frm_name"].ToString();
            //m_frm_name
        }
        catch
        { m_name = ""; }

        // 1 = blocked
        // 0 = true
        // 2 = null

        int group_premission = 0;
        try
        {
            group_id = Convert.ToInt32(new tbl_usersTableAdapter().ScalarQuery_GetUserGroupID(username));
            tbl_groups_permissionTableAdapter gpta = new tbl_groups_permissionTableAdapter();
            MainDataModule.tbl_groups_permissionDataTable gta = new MainDataModule.tbl_groups_permissionDataTable();
            gpta.Fill(gta, group_id, form_name);
            DataRow drm = gta[0];
            group_premission = Convert.ToInt16(Convert.ToBoolean(drm["gd_blocked"].ToString()));
        }
        catch
        {
            group_premission = 2;
        }




        bool load = false;

        if (group_premission == 0)
        {
            if (user_premission == 0) { load = true; }
            if (user_premission == 2) { load = true; }
            if (user_premission == 1) { load = false; }
        }
        if (group_premission == 1)
        {
            if (user_premission == 0) { load = true; }
            if (user_premission == 2) { load = false; }
            if (user_premission == 1) { load = false; }
        }
        if (group_premission == 2)
        {
            if (user_premission == 0) { load = true; }
            if (user_premission == 2) { load = false; }
            if (user_premission == 1) { load = false; }
        }
        //Control ctr = 
        if (load == true)
        {
            if (m_name == "") { return "~\\ascx\\frm_AccessDenied.ascx"; } else { return "~\\ascx\\" + m_name + ".ascx"; }
        }
        else
        {
            return "~\\ascx\\frm_AccessDenied.ascx";
        }
        //return ctor;

    }


    public string Convert_to_Midaly(string ShamsiDate, string time)
    {
        string str = "";
        string year = "";
        string month = "";
        string day = "";
        string hour = "";
        string min = "";
        string sec = "";
        DateTime dtt;


        FarsiLibrary.Utils.PersianDate pd = new FarsiLibrary.Utils.PersianDate(ShamsiDate);
        dtt = FarsiLibrary.Utils.PersianDateConverter.ToGregorianDateTime(pd);

        year = dtt.Year.ToString();
        month = dtt.Month.ToString();
        day = dtt.Day.ToString();
        if (month.Length == 1) { month = "0" + month; }
        if (day.Length == 1) { day = "0" + day; }
        DateTime dt = Convert.ToDateTime(year + "/" + month + "/" + day + " " + time);



        year = dt.Year.ToString();
        month = dt.Month.ToString();
        day = dt.Day.ToString();
        hour = dt.Hour.ToString();
        min = dt.Minute.ToString();
        sec = dt.Second.ToString();

        if (month.Length == 1) { month = "0" + month; }
        if (day.Length == 1) { day = "0" + day; }
        if (hour.Length == 1) { hour = "0" + hour; }
        if (min.Length == 1) { min = "0" + min; }
        if (sec.Length == 1) { sec = "0" + sec; }


        str = year + "/" + month + "/" + day + " " + hour + ":" + min + ":" + sec;

        return str;

    }
    public string Convert_to_Midaly(string ShamsiDate)
    {
        string str = "";
        string year = "";
        string month = "";
        string day = "";

        DateTime dtt;


        FarsiLibrary.Utils.PersianDate pd = new FarsiLibrary.Utils.PersianDate(ShamsiDate);
        dtt = FarsiLibrary.Utils.PersianDateConverter.ToGregorianDateTime(pd);

        year = dtt.Year.ToString();
        month = dtt.Month.ToString();
        day = dtt.Day.ToString();
        if (month.Length == 1) { month = "0" + month; }
        if (day.Length == 1) { day = "0" + day; }
        DateTime dt = Convert.ToDateTime(year + "/" + month + "/" + day);

        year = dt.Year.ToString();
        month = dt.Month.ToString();
        day = dt.Day.ToString();

        if (month.Length == 1) { month = "0" + month; }
        if (day.Length == 1) { day = "0" + day; }

        str = year + "/" + month + "/" + day + " ";

        return str;

    }
    public string Convert_to_Shamsi(DateTime dt)
    {
        string str = "";

        FarsiLibrary.Utils.PersianDate pd = FarsiLibrary.Utils.PersianDateConverter.ToPersianDate(dt);


        string year = "";
        string month = "";
        string day = "";


        year = pd.Year.ToString();
        month = pd.Month.ToString();
        day = pd.Day.ToString();

        if (month.Length == 1) { month = "0" + month; }
        if (day.Length == 1) { day = "0" + day; }

        str = year + "/" + month + "/" + day;

        return str;

    }
    public string Convert_to_standard_time(TimeSpan tm)
    {
        string str = "";
        string hour = "";
        string min = "";
        string sec = "";

        hour = tm.Hours.ToString();
        min = tm.Minutes.ToString();
        sec = tm.Seconds.ToString();

        if (hour.Length == 1) { hour = "0" + hour; }
        if (min.Length == 1) { min = "0" + min; }
        if (sec.Length == 1) { sec = "0" + sec; }

        str = hour + ":" + min + ":" + sec;

        return str;

    }
    public ArrayList GenerateCellNoList(int CellNoLength, string FirstPartNumber, int CellGeneratedCount)
    {
        string static_number = FirstPartNumber;
        int all_count = CellNoLength;
        int result_count = all_count - static_number.Length;
        int generatecount = CellGeneratedCount;
        string from = "", _to = "";
        for (int i = 0; i < result_count; i++)
        {
            from = from + "0";
            _to = _to + "9";
        }

        Random rnd = new Random();
        ArrayList al = new ArrayList();
        string no = "";
        for (int i = 0; i < generatecount; i++)
        {
            no = rnd.Next(Convert.ToInt32(from), Convert.ToInt32(_to)).ToString();
            int len = result_count - no.Length;

            for (int l = 0; l < len; l++)
            {
                no = "0" + no;
            }

            if (al.IndexOf(static_number + no) > 0)
            {

                al.Remove(static_number + no);
                i = i - 1;
            }

            al.Add(static_number + no);








        }
        return al;
    }




    public struct MessageProperties
    {
        public string MessageBody;
        public int MessageCharacterCount;
        public bool isFarsi;
        public int howManyMessage;
    }
    public MessageProperties GetAMessageCount(string message,int messageCount)
    {
        MessageProperties mp = new MessageProperties();
        bool hasFarsi = false;
        bool hasEnglish = false;
        bool hasNumber = false;
        int chcode = 0;

        for (int i = 0; i < message.Length; i++)
        {
            chcode = (int)message[i];
            if (chcode >= 48 && chcode <= 57)
            {
                hasNumber = true;
            }

            if (chcode >= 58 && chcode <= 126)
            {
                hasEnglish = true;
            }

            if (chcode >= 1547 && chcode <= 1791)
            {
                hasFarsi = true;
            }
        }

        if (message == "") { }

        int msgSetCount = Convert.ToInt32( messageCount );

        int messagecount = message.Length / msgSetCount;

        double mc = (message.Length / Convert.ToDouble(msgSetCount));
        if (Convert.ToDouble(messagecount) < (mc))
        {
            messagecount = messagecount + 1;
        }

        mp.MessageCharacterCount = message.Length;
        if (message == "") { messagecount = 1; hasEnglish = true; mp.MessageCharacterCount = 10; }
        mp.howManyMessage = messagecount;
        mp.isFarsi = !hasEnglish;
        mp.MessageBody = message;
        

        return mp;
    }
    public string loadFromHtml(string FileAddr)
    {
        string path = System.Web.HttpContext.Current.Server.MapPath(FileAddr);//"~/htmlfrm/html_CarInfoWindow_Point.htm");
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
        return str;
    }
    public string GenerateWhereStatementFromCarIDAndGroup(string QueryString)
    {
        string str = "";

        return str;
    }
    public SqlDataReader GetDataReader(string sqlString)
    {
        SqlConnection scn = new SqlConnection(new main_class().get_connection_string());
        scn.Open();
        SqlCommand scm = new SqlCommand(sqlString, scn);
        SqlDataReader sdr = scm.ExecuteReader();
        return sdr;
    }













}

