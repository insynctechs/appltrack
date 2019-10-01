using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class EmployerEdit : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> employerList = new List<DataRow>();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 4)
                {
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }
                    if (Request.QueryString["id"] != null)
                    {
                        id.Value = Request.QueryString["id"];
                        GetEmployer(Convert.ToInt32(Request.QueryString["id"]));
                    }
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void GetEmployer(int id)
        {
            try
            {
                var url = string.Format("api/Employers/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int UpdateEmployer(string id, string name, string address, string city, string state, string zip, string email, string phone, string description, string active)
        {
            int ret = 0;
            var employer = new Dictionary<string, string>();
            employer.Add("id", id);
            employer.Add("name", name.Trim());
            employer.Add("address", address.Trim());
            employer.Add("city", city.Trim());
            employer.Add("state", state.Trim());
            employer.Add("zip", zip.Trim());
            employer.Add("email", email.Trim());
            employer.Add("phone", phone.Trim());
            employer.Add("description", description.Trim());
            employer.Add("active", active.Trim());
            try
            {
                var url = string.Format("api/Employers/Edit");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employer);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return ret;
        }


    }
}