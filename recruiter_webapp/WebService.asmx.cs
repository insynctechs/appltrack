using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;

namespace recruiter_webapp
{

    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {
        public static WebApiHelper wHelper = new WebApiHelper();
        public static List<DataRow> userList = new List<DataRow>();
        Utils utils = new Utils();

        [System.Web.Services.WebMethod(EnableSession = true)]
        public int ValidateUser(string username, string password)
        {
            int ret = 0;
            string ip_address = utils.GetIpAddress();
            try
            {
                var url = string.Format("api/Users/Validate?username=" + username + "&password=" + password + "&ip_address=" + ip_address);
                ret = wHelper.GetExecuteNonQueryResFromWebApi(url);
                if (ret > 0)
                {
                    url = string.Format("api/Users/Get?username=" + username + "&ip_address=" + ip_address);
                    DataTable dt = wHelper.GetDataTableFromWebApi(url);
                    userList = dt.AsEnumerable().ToList();
                    Session.Add("user_id", userList[0]["user_id"]);
                    // Storing frequently used values in session.
                    if (userList[0]["user_id"].ToString() != "1")
                    {
                        Session.Add("user_name", userList[0]["user_name"]);
                        Session.Add("user_type", userList[0]["user_type"]);
                        Session.Add("user_type_name", userList[0]["user_type_name"]);
                        Session.Add("user_email", userList[0]["user_email"]);
                        Session.Add("user_last_logged_in", userList[0]["user_last_logged_in"]);
                    }
                    else // For super admin, limited details stored in session
                    {
                        Session.Add("user_name", "Super Admin");
                        Session.Add("user_type", 1);
                        Session.Add("user_type_name", "Super Admin");
                    }
                }
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
            return ret;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public void LogoutUser()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            //HttpContext.Current.Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
        }
    }
}
