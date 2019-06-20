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
    public partial class EmployerStaffAdd : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }

        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> employerList = new List<DataRow>();
        public List<DataRow> employerLocationList = new List<DataRow>();
        public List<DataRow> employerStaffList = new List<DataRow>();
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
                GetEmployerStaff(Convert.ToInt32(Request.QueryString["id"]));
                GetEmployerAndLocations(Convert.ToInt32(employerStaffList[0]["employer_id"]));
            }
            if (Request.QueryString["employer_id"] != null)
            {
                GetEmployerAndLocations(Convert.ToInt32(Request.QueryString["employer_id"]));
            }
        }

        private void GetEmployerAndLocations(int id)
        {
            try
            {
                var url = string.Format("api/Employers/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerList = dt.AsEnumerable().ToList();
                url = string.Format("api/EmployerLocations/GetList?id=" + id);
                dt = wHelper.GetDataTableFromWebApi(url);
                employerLocationList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        private void GetEmployerStaff(int id)
        {
            try
            {
                var url = string.Format("api/EmployerStaffs/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerStaffList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int InsertEmployerStaff(string employer_staff_id, string employer_id, string employer_location_id, string name, string gender, string designation, string address, string phone, string email, string active, string notification, string user_type)
        {
            int ret = 0;

            var employer = new Dictionary<string, string>();
            employer.Add("user_id", "0");
            employer.Add("employer_id", employer_id);
            employer.Add("employer_location_id", employer_location_id);
            employer.Add("name", name);
            employer.Add("gender", gender);
            employer.Add("designation", designation);
            employer.Add("address", address);
            employer.Add("phone", phone);
            employer.Add("email", email);
            employer.Add("active", active);
            //employer.Add("logged_in_userid", session["user_id"] != null ? session["user_id"].ToString() : "1");
            employer.Add("logged_in_userid", "1");
            string ip_address = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            employer.Add("ip_address", "");
            employer.Add("notification", notification);
            employer.Add("user_type", user_type);

            if (employer_staff_id != "")
            {
                employer.Add("id", employer_staff_id);
                try
                {
                    var url = string.Format("api/EmployerStaffs/Edit");
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
                    var url = string.Format("api/EmployerStaffs/Insert");
                    ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employer);
                }
                catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString());
                    return -2;
                }
            }
            return ret;
        }
    }
}