using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class Login : System.Web.UI.UserControl
    {
        public static WebApiHelper wHelper = new WebApiHelper();
        public static List<DataRow> userList = new List<DataRow>();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int ValidateUser(string username, string password)
        {
            int ret = 0;
            string ip_address = "";
            /*
            var user = new Dictionary<string, string>();
            user.Add("username", username);
            user.Add("password", password);
            user.Add("ip_address", "ipadd");
            */
            try
            {
                var url = string.Format("api/Users/Validate?username=" + username + "&password=" + password + "&ip_address=" + ip_address);
                ret = wHelper.GetExecuteNonQueryResFromWebApi(url);
                if(ret > 0)
                {
                    url = string.Format("api/Users/Get?username=" + username + "&ip_address=" + ip_address);
                    DataTable dt = wHelper.GetDataTableFromWebApi(url);
                    userList = dt.AsEnumerable().ToList();
                    //Session["user_id"] = userList[0]["id"];
                }
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
            return ret;
        }
    }
}