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
    public partial class EmployerLocationAdd : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }

        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> employerList = new List<DataRow>();
        public List<DataRow> employerLocationList = new List<DataRow>();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
            }
            if(Request.QueryString["employer_id"] != null)
            {
                GetEmployer(Convert.ToInt32(Request.QueryString["employer_id"]));
            }
            
            if (Request.QueryString["id"] != null) {
                GetEmployerLocation(Convert.ToInt32(Request.QueryString["id"]));
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

        private void GetEmployerLocation(int id)
        {
            try
            {
                var url = string.Format("api/EmployerLocations/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerLocationList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int InsertEmployerLocation(string employer_loc_id, string employer_id, string address, string city, string zip, string email, string phone, string country, string active)
        {
            int ret = 0;
            var employer = new Dictionary<string, string>();
            employer.Add("employer_id", employer_id);
            employer.Add("address", address);
            employer.Add("city", city);
            employer.Add("zip", zip);
            employer.Add("email", email);
            employer.Add("phone", phone);
            employer.Add("country", country);
            employer.Add("active", active);

            if(employer_loc_id != "")
            {
                employer.Add("id", employer_loc_id);
                try
            {
                    var url = string.Format("api/EmployerLocations/Edit");
                    ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employer);
                }
            catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString());
                }
            }
            else
            {
                try
                {
                    var url = string.Format("api/EmployerLocations/Insert");
                    ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employer);
                }
                catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString());
                }
            }            
            return ret;
        }
    }
}