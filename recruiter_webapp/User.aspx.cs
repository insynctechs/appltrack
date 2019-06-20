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
    public partial class User : System.Web.UI.Page
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> userList = new List<DataRow>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["user_id"] != null)
            {
                GetUserDetails(Convert.ToInt32(Session["user_ref_id"]));
            }
        }

        public void GetUserDetails(int id)
        {
            try
            {
                var url = string.Format("api/Users/GetDetails?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                userList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }
    }
}