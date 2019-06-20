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
        public static int UpdateEmployer(string id, string name, string address, string city, string state, string zip, string email, string phone, string active)
        {
            int ret = 0;
            var employer = new Dictionary<string, string>();
            employer.Add("id", id);
            employer.Add("name", name);
            employer.Add("address", address);
            employer.Add("city", city);
            employer.Add("state", state);
            employer.Add("zip", zip);
            employer.Add("email", email);
            employer.Add("phone", phone);            
            employer.Add("active", active);
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