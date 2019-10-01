using System;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text.RegularExpressions;
using System.Net.Mail;
using System.Data;
using System.Linq;
using System.Web.Script.Services;
using System.Collections.Generic;

namespace recruiter_webapp.Helpers
{

    public class Utils
    {
        //public static int userid = 101; // For testing purpose

        // This method is used to resolve the current IP address. 
        public string GetIpAddress() {
            string ipAddress = "";
            if(System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
            {
                ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
            }
            else if(System.Web.HttpContext.Current.Request.UserHostAddress.Length.ToString() != null)
            {
                ipAddress = System.Web.HttpContext.Current.Request.UserHostAddress;
            }
            return ipAddress;
        }

        // This method is used to create a numeric timestamp (Used for creating a unique filename)
        public static String GetTimestamp(DateTime value)
        {
            return value.ToString("yyyyMMddHHmmssffff");
        }

        // This method is used to create a numeric timestamp (Used for creating a unique filename)
        public static String GetDatestamp(DateTime value)
        {
            return value.ToString("yyyyMMdd");
        }


        // This method is used to generate a random 8 character long alpha-numeric password.
        public static string GeneratePassword()
        {
            string PasswordLength = "8";
            string NewPassword = "";

            string allowedChars = "";
            allowedChars = "1,2,3,4,5,6,7,8,9,0";
            allowedChars += "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,";
            allowedChars += "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,";


            char[] sep = { ',' };
            string[] arr = allowedChars.Split(sep);


            string IDString = "";
            string temp = "";

            Random rand = new Random();

            for (int i = 0; i < Convert.ToInt32(PasswordLength); i++)
            {
                temp = arr[rand.Next(0, arr.Length)];
                IDString += temp;
                NewPassword = IDString;

            }
            return NewPassword;
        }

























        public static string FormatCompanyWebsiteLink(string CompanyName)
        {
            if (CompanyName == "" || CompanyName == null)
            {
                return String.Empty;
            }
            string[] starr = { " incorporated", " corporation", " industries", " industry", " international", " company", " companies", " llc", " inc", " corp" };
            string cname = CompanyName;
            cname = cname.Trim().Replace("&amp;", "&");
            cname = cname.Replace("–", " ");
            cname = cname.Replace("-", " ");//
            cname = cname.Replace("—", " ");
            cname = cname.Replace("–", " ");
            cname = cname.Replace("—", " ");
            cname = cname.Replace("-", " ");//
            cname = cname.Replace("&#151;", " ");
            cname = cname.Replace("&mdash;", " ");
            cname = cname.Replace("&#189;", "½");
            cname = cname.Replace("&#188;", "¼");
            cname = cname.Replace("&#190;", "¾");
            cname = cname.Replace("&quot;", "“");
            cname = cname.Replace("&quot;", "”");
            cname = cname.Replace("&#39;", "’");
            cname = cname.Replace("&deg;", "°");
            cname = cname.Replace("&deg;C", "ºC");
            cname = cname.Replace("&trade;", "™");
            cname = cname.Replace("&#246;", "ö");
            cname = cname.Replace("&#181;", "µ");
            cname = cname.Replace("&#252;", "ü");
            cname = cname.Replace("&#8226;", "•");
            cname = cname.Replace("&#169;", "©");
            cname = cname.Replace("&reg;", "®");
            cname = cname.Replace("&eacute;", "é");
            cname = cname.Replace(" ", " ");
            cname = cname.Replace("&", " and ");
            cname = cname.Replace(",", " ");
            cname = cname.Replace(".", "");
            cname = cname.Replace("/", " ");
            cname = cname.Replace("'", " ");
            cname = cname.Replace("’", " ");
            cname = cname.Replace("'", " ");
            cname = cname.Replace("’", " ");
            cname = cname.Replace("°", " ");
            cname = cname.Replace("™", " ");
            cname = cname.Replace("®", " ");
            cname = cname.Replace("#", " ");
            cname = cname.Replace("^", " ");
            cname = cname.Replace("$", " ");
            cname = cname.Replace("|", " ");
            cname = cname.Replace(":", " ");
            cname = cname.Replace(";", " ");
            cname = cname.Replace("<", " ");
            cname = cname.Replace(">", " ");
            cname = cname.Replace("?", " ");
            cname = cname.Replace("[", " ");
            cname = cname.Replace("]", " ");
            cname = cname.Replace("ö", "o");
            cname = cname.Replace("ä", "a");
            cname = cname.Replace("™", " ");
            cname = cname.Replace("\"", " ");
            cname = cname.Replace(@"\", " ");
            cname = cname.Replace("-", " ");//
            cname = cname.Replace("&#228", "a");
            cname = cname.Replace("&#151;", " ");
            cname = cname.Replace("&mdash;", " ");
            cname = cname.Replace("&#189;", " ");
            cname = cname.Replace("&#188;", " ");
            cname = cname.Replace("&#190;", " ");
            cname = cname.Replace("&quot;", " ");
            cname = cname.Replace("&quot;", " ");
            cname = cname.Replace("&#39;", " ");
            cname = cname.Replace("&deg;", " ");
            cname = cname.Replace("&deg;C", " ");
            cname = cname.Replace("&trade;", " ");
            cname = cname.Replace("&#246;", " ");
            cname = cname.Replace("&#181;", " ");
            cname = cname.Replace("&#252;", " ");
            cname = cname.Replace("&#8226;", " ");
            cname = cname.Replace("&#8482;", " ");
            cname = cname.Replace("&#169;", " ");
            cname = cname.Replace("&reg;", " ");
            cname = cname.Replace("&eacute;", " ");
            cname = cname.Replace("ü", "u");
            cname = cname.Replace("©", " ");
            cname = cname.Replace("é", "e");
            cname = cname.Replace("---", " ");
            cname = cname.Replace("--", " ");
            cname = Regex.Replace(cname, @"[^\w\s]", "");
            foreach (string s in starr)
            {
                if (cname.ToLower().Contains(s))
                    cname = cname.Replace(cname.Substring(cname.ToLower().IndexOf(s), s.Length), "");
            }
            //for co
            cname = System.Text.RegularExpressions.Regex.Replace(cname, @"(\sco)(\W|\s)*$", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            cname = cname.Replace("   ", " ");
            cname = cname.Replace("  ", " ");
            cname = cname.Trim();
            if (cname.Length >= 4)
            {
                if (cname.Substring(cname.Length - 4) == " and")
                    cname = cname.Substring(0, cname.Length - 4);
            }
            return cname;
        }

        public static string ReplaceContent(string Content, int type)
        {
            string _replacecontent = string.Empty;
            if (Content == "" || Content == null)
            {
                return String.Empty;
            }
            switch (type)
            {
                case 0:
                    _replacecontent = Content.Trim().Replace(" & ", " &amp; ");
                    _replacecontent = _replacecontent.Replace("™", "&trade;");
                    _replacecontent = _replacecontent.Replace("—", "&#151;");
                    _replacecontent = _replacecontent.Replace("\"", "&quot;");
                    _replacecontent = _replacecontent.Replace("®", "&reg;");
                    _replacecontent = _replacecontent.Replace("'", "&#96;");
                    _replacecontent = _replacecontent.Replace("ü", "&#252;");
                    _replacecontent = _replacecontent.Replace("™", "&trade;");
                    _replacecontent = _replacecontent.Replace("é", "&eacute;");
                    break;
                case 1:
                    _replacecontent = Content.Trim().Replace(" & ", " &amp; ");
                    _replacecontent = _replacecontent.Replace("</span> –", "</span> -");
                    _replacecontent = _replacecontent.Replace("</span>–", "</span> -");
                    _replacecontent = _replacecontent.Replace("–", "-");
                    _replacecontent = _replacecontent.Replace("-", "-");//
                    _replacecontent = _replacecontent.Replace("—", "-");
                    _replacecontent = _replacecontent.Replace("–", "-");
                    _replacecontent = _replacecontent.Replace("—", "-");
                    _replacecontent = _replacecontent.Replace("-", "-");//
                    _replacecontent = _replacecontent.Replace("&#151;", "-");
                    _replacecontent = _replacecontent.Replace("&mdash;", "-");
                    _replacecontent = _replacecontent.Replace(">“", ">&quot;");
                    _replacecontent = _replacecontent.Replace("> “", ">&quot;");
                    _replacecontent = _replacecontent.Replace("” <", "&quot;<");
                    _replacecontent = _replacecontent.Replace("”<", "&quot;<");
                    _replacecontent = _replacecontent.Replace("½", "&#189;");
                    _replacecontent = _replacecontent.Replace("¼", "&#188;");
                    _replacecontent = _replacecontent.Replace("¾", "&#190;");
                    _replacecontent = _replacecontent.Replace("“", "&quot;");
                    _replacecontent = _replacecontent.Replace("”", "&quot;");
                    _replacecontent = _replacecontent.Replace("'", "&#96;");
                    _replacecontent = _replacecontent.Replace("’", "&#39;");
                    _replacecontent = _replacecontent.Replace("°", "&deg;");
                    _replacecontent = _replacecontent.Replace("ºC", "&deg;C");
                    _replacecontent = _replacecontent.Replace("™", "&trade;");
                    _replacecontent = _replacecontent.Replace("ö", "&#246;");
                    _replacecontent = _replacecontent.Replace("µ", "&#181;");
                    _replacecontent = _replacecontent.Replace("ü", "&#252;");
                    _replacecontent = _replacecontent.Replace("•", "&#8226;");
                    _replacecontent = _replacecontent.Replace("©", "&#169;");
                    _replacecontent = _replacecontent.Replace("®", "&reg;");
                    _replacecontent = _replacecontent.Replace("é", "&eacute;");
                    _replacecontent = _replacecontent.Replace("&#xa0;", "&nbsp;");
                    break;
                case 2:
                    _replacecontent = Content.Trim().Replace(" & ", " &amp; ");
                    _replacecontent = _replacecontent.Replace("</span> –", "</span> -");
                    _replacecontent = _replacecontent.Replace("</span>–", "</span> -");
                    _replacecontent = _replacecontent.Replace("–", "-");
                    _replacecontent = _replacecontent.Replace("-", "-");//
                    _replacecontent = _replacecontent.Replace("—", "-");
                    _replacecontent = _replacecontent.Replace("–", "-");
                    _replacecontent = _replacecontent.Replace("—", "-");
                    _replacecontent = _replacecontent.Replace("-", "-");//
                    _replacecontent = _replacecontent.Replace("&#151;", "-");
                    _replacecontent = _replacecontent.Replace("&mdash;", "-");
                    _replacecontent = _replacecontent.Replace(">“", ">&quot;");
                    _replacecontent = _replacecontent.Replace("> “", ">&quot;");
                    _replacecontent = _replacecontent.Replace("” <", "&quot;<");
                    _replacecontent = _replacecontent.Replace("”<", "&quot;<");
                    _replacecontent = _replacecontent.Replace("½", "&#189;");
                    _replacecontent = _replacecontent.Replace("¼", "&#188;");
                    _replacecontent = _replacecontent.Replace("¾", "&#190;");
                    _replacecontent = _replacecontent.Replace("“", "&quot;");
                    _replacecontent = _replacecontent.Replace("”", "&quot;");
                    _replacecontent = _replacecontent.Replace("’", "&#39;");
                    _replacecontent = _replacecontent.Replace("°", "&deg;");
                    _replacecontent = _replacecontent.Replace("ºC", "&deg;C");
                    _replacecontent = _replacecontent.Replace("™", "&trade;");
                    _replacecontent = _replacecontent.Replace("ö", "&#246;");
                    _replacecontent = _replacecontent.Replace("µ", "&#181;");
                    _replacecontent = _replacecontent.Replace("ü", "&#252;");
                    _replacecontent = _replacecontent.Replace("•", "&#8226;");
                    _replacecontent = _replacecontent.Replace("©", "&#169;");
                    _replacecontent = _replacecontent.Replace("®", "&reg;");
                    _replacecontent = _replacecontent.Replace("é", "&eacute;");
                    _replacecontent = _replacecontent.Replace("&#xa0;", "&nbsp;");
                    break;
                case 3:
                    _replacecontent = Content.Trim().Replace("&amp;", "&");
                    _replacecontent = _replacecontent.Replace("–", "-");
                    _replacecontent = _replacecontent.Replace("-", "-");//
                    _replacecontent = _replacecontent.Replace("—", "-");
                    _replacecontent = _replacecontent.Replace("–", "-");
                    _replacecontent = _replacecontent.Replace("—", "-");
                    _replacecontent = _replacecontent.Replace("-", "-");//
                    _replacecontent = _replacecontent.Replace("&#151;", "-");
                    _replacecontent = _replacecontent.Replace("&mdash;", "-");
                    _replacecontent = _replacecontent.Replace("&#189;", "½");
                    _replacecontent = _replacecontent.Replace("&#188;", "¼");
                    _replacecontent = _replacecontent.Replace("&#190;", "¾");
                    _replacecontent = _replacecontent.Replace("&quot;", "“");
                    _replacecontent = _replacecontent.Replace("&quot;", "”");
                    _replacecontent = _replacecontent.Replace("&#39;", "’");
                    _replacecontent = _replacecontent.Replace("&deg;", "°");
                    _replacecontent = _replacecontent.Replace("&deg;C", "ºC");
                    _replacecontent = _replacecontent.Replace("&trade;", "™");
                    _replacecontent = _replacecontent.Replace("&#246;", "ö");
                    _replacecontent = _replacecontent.Replace("&#181;", "µ");
                    _replacecontent = _replacecontent.Replace("&#252;", "ü");
                    _replacecontent = _replacecontent.Replace("&#8226;", "•");
                    _replacecontent = _replacecontent.Replace("&#169;", "©");
                    _replacecontent = _replacecontent.Replace("&reg;", "®");
                    _replacecontent = _replacecontent.Replace("&eacute;", "é");
                    _replacecontent = _replacecontent.Replace(" ", "-");
                    _replacecontent = _replacecontent.Replace("&", "and");
                    _replacecontent = _replacecontent.Replace(",", "-");
                    _replacecontent = _replacecontent.Replace(".", "");
                    _replacecontent = _replacecontent.Replace("/", "-");
                    _replacecontent = _replacecontent.Replace("'", "-");
                    _replacecontent = _replacecontent.Replace("’", "-");
                    _replacecontent = _replacecontent.Replace("'", "-");
                    _replacecontent = _replacecontent.Replace("’", "-");
                    _replacecontent = _replacecontent.Replace("°", "-");
                    _replacecontent = _replacecontent.Replace("™", "-");
                    _replacecontent = _replacecontent.Replace("®", "-");
                    _replacecontent = _replacecontent.Replace("#", "-");
                    _replacecontent = _replacecontent.Replace("^", "-");
                    _replacecontent = _replacecontent.Replace("$", "-");
                    _replacecontent = _replacecontent.Replace("|", "-");
                    _replacecontent = _replacecontent.Replace(":", "-");
                    _replacecontent = _replacecontent.Replace(";", "-");
                    _replacecontent = _replacecontent.Replace("<", "-");
                    _replacecontent = _replacecontent.Replace(">", "-");
                    _replacecontent = _replacecontent.Replace("?", "-");
                    _replacecontent = _replacecontent.Replace("[", "-");
                    _replacecontent = _replacecontent.Replace("]", "-");
                    _replacecontent = _replacecontent.Replace("ö", "-");
                    _replacecontent = _replacecontent.Replace("™", "-");
                    _replacecontent = _replacecontent.Replace("\"", "-");
                    _replacecontent = _replacecontent.Replace(@"\", "-");
                    _replacecontent = _replacecontent.Replace("-", "-");//
                    _replacecontent = _replacecontent.Replace("&#151;", "-");
                    _replacecontent = _replacecontent.Replace("&mdash;", "-");
                    _replacecontent = _replacecontent.Replace("&#189;", "-");
                    _replacecontent = _replacecontent.Replace("&#188;", "-");
                    _replacecontent = _replacecontent.Replace("&#190;", "-");
                    _replacecontent = _replacecontent.Replace("&quot;", "-");
                    _replacecontent = _replacecontent.Replace("&quot;", "-");
                    _replacecontent = _replacecontent.Replace("&#39;", "-");
                    _replacecontent = _replacecontent.Replace("&deg;", "-");
                    _replacecontent = _replacecontent.Replace("&deg;C", "-");
                    _replacecontent = _replacecontent.Replace("&trade;", "-");
                    _replacecontent = _replacecontent.Replace("&#246;", "-");
                    _replacecontent = _replacecontent.Replace("&#181;", "-");
                    _replacecontent = _replacecontent.Replace("&#252;", "-");
                    _replacecontent = _replacecontent.Replace("&#8226;", "-");
                    _replacecontent = _replacecontent.Replace("&#169;", "-");
                    _replacecontent = _replacecontent.Replace("&reg;", "-");
                    _replacecontent = _replacecontent.Replace("&eacute;", "-");
                    _replacecontent = _replacecontent.Replace("ü", "u");
                    _replacecontent = _replacecontent.Replace("©", "-");
                    _replacecontent = _replacecontent.Replace("é", "e");
                    _replacecontent = _replacecontent.Replace("---", "-");
                    _replacecontent = _replacecontent.Replace("--", "-");
                    break;
            }
            return _replacecontent;
        }

        public static string FirstWords(string input, int numberWords)
        {
            try
            {
                int words = numberWords;
                for (int i = 0; i < input.Length; i++)
                {
                    if (input[i] == ' ')
                    {
                        words--;
                    }
                    if (words == 0)
                    {
                        return input.Substring(0, i);
                    }
                }
            }
            catch (Exception)
            {
            }
            return input;
        }

        private static HttpClient client;
        public static HttpClient Client
        {
            get
            {
                if (client == null)
                {
                    client = new HttpClient();
                    client.BaseAddress = new Uri(ConfigurationManager.AppSettings["Api"].ToString());
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                }
                return client;
            }
        }

        #region Mail Component

        #region Sending Mail 
        public static bool SendMail(string strFromAddress, string strToAddress, string strCCAddress, string strBCCAddress, string strSubject, string strBodyContent, bool IsBodyHtml)
        {
            try
            {
                if (ValidateMailAddress(ref strFromAddress) & ValidateMailAddress(ref strToAddress) & ValidateMailAddress(ref strSubject) & ValidateMailAddress(ref strBodyContent))
                {
                    string strUsername = System.Configuration.ConfigurationManager.AppSettings["MailServerUsername"];
                    string strPassword = System.Configuration.ConfigurationManager.AppSettings["MailServerpassword"];
                    //Create a new MailMessage object and specify the"From" and "To" addresses
                    MailMessage Email = new System.Net.Mail.MailMessage();
                    Email.From = new MailAddress(strFromAddress.ToString());
                    Email = EmailAddressCollection(strToAddress.ToString(), "TO", ref Email);

                    if (ValidateMailAddress(ref strCCAddress))
                        Email = EmailAddressCollection(strCCAddress.ToString(), "CC", ref Email);
                    if (ValidateMailAddress(ref strBCCAddress))
                        Email = EmailAddressCollection(strBCCAddress.ToString(), "BCC", ref Email);
                    Email.Subject = strSubject.ToString();
                    Email.Body = strBodyContent.ToString();
                    Email.IsBodyHtml = IsBodyHtml;

                    System.Net.Mail.SmtpClient mailClient = new System.Net.Mail.SmtpClient();

                    if (strUsername.Trim().Length > 0 & strPassword.Trim().Length > 0)
                    {
                        //This object stores the authentication values
                        System.Net.NetworkCredential basicAuthenticationInfo = new System.Net.NetworkCredential(strUsername, strPassword);
                        mailClient.UseDefaultCredentials = false;
                        mailClient.Credentials = basicAuthenticationInfo;
                    }
                    //Put your own, or your ISPs, mail server name onthis next line
                    mailClient.Host = System.Configuration.ConfigurationManager.AppSettings["MailServerIP"];
                    mailClient.Send(Email);
                    return true;
                }
                else
                    return false;

            }
            catch (Exception ex)
            {
                //CommonLogger.Info("Failed to send a Mail for Following MailAddress: From :" + strFromAddress + "  ToAddress :");
                //CommonLogger.Error("Failed to send a Mail fro following reason" + ex.StackTrace);
                ex.ToString();
                return false;
            }
        }
        #endregion

        #region ValidateMailAddress
        private static bool ValidateMailAddress(ref string mailaddress)
        {
            return (string.IsNullOrEmpty(mailaddress) ? false : true);
        }
        #endregion

        #region MailAddressCollection 
        private static MailMessage EmailAddressCollection(string EmailAddress, string type, ref MailMessage MailObject)
        {
            char[] _MailSeparator = new char[] { Convert.ToChar(System.Configuration.ConfigurationManager.AppSettings["MailAddressSeparator"]) };
            switch (type.ToUpper())
            {
                case "TO":
                    {
                        string[] _address = EmailAddress.Split(_MailSeparator);
                        foreach (string _MailID in _address)
                        {
                            if (_MailID != "")
                                MailObject.To.Add(new MailAddress(_MailID));
                        }
                        break;
                    }
                case "CC":
                    {
                        string[] _address = EmailAddress.Split(_MailSeparator);
                        foreach (string _MailID in _address)
                        {
                            if (_MailID != "")
                                MailObject.CC.Add(new MailAddress(_MailID));
                        }
                        break;
                    }
                case "BCC":
                    {
                        string[] _address = EmailAddress.Split(_MailSeparator);
                        foreach (string _MailID in _address)
                        {
                            if (_MailID != "")
                                MailObject.Bcc.Add(new MailAddress(_MailID));
                        }
                        break;
                    }
            }
            return MailObject;
        }
        #endregion


        #endregion

        public static string ApiURL
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["Api"].ToString();
            }
        }

        public static string WebURL
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["WebURL"].ToString();
            }
        }

        public static string MetaRobots
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["MetaRobots"].ToString();
            }
        }

        public static void setErrorLabel(System.Web.UI.WebControls.Label label, string message)
        {
            label.Text = message;
            label.ForeColor = Constants.failureColor;
        }

        public static void setSuccessLabel(System.Web.UI.WebControls.Label label, string message)
        {
            label.Text = message;
            label.ForeColor = Constants.successColor;
        }

    }
}