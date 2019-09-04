using Newtonsoft.Json.Linq;
using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class EmployerUpdate : System.Web.UI.Page
    {
        private static WebApiHelper wHelper = new WebApiHelper();
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public List<DataRow> formDataList;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 4)
                {
                    if (Request.QueryString["employer_id"] != null)
                    {
                        PopulateFormData(Convert.ToInt32(Request.QueryString["employer_id"]));
                    }
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void PopulateFormData(int id)
        {
            try
            {
                var url = string.Format("api/Employers/GetFormData?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                formDataList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static void InsertEmployer0(string obj)
        {
            File.WriteAllText("d:\\obj.txt", obj.ToString());
        }


        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int InsertEmployer(string name, string address, string city, string state, string zip, string email, string phone, string active)
        {
            int ret = 0;
            var employer = new Dictionary<string, string>();
            //employer.Add("id", id);
            employer.Add("customer_id", "58");
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
                    var url = string.Format("api/Employers/Insert");
                    ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employer);
                }
                catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString());
                }
            return ret;
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int InsertEmployerLocation(string employer_id, string address, string city, string zip, string email, string phone, string country, string active)
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
            try
            {
                var url = string.Format("api/EmployerLocations/Insert");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employer);
                if(ret>0)
                {
                    var emp = new Dictionary<string, string>();
                    emp.Add("id", employer_id);
                    emp.Add("progress", "2");
                    wHelper.PostExecuteNonQueryResFromWebApi("api/Employer/UpdateProgress", emp);
                }
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return ret;
        }


        [System.Web.Services.WebMethod(EnableSession = true)]
        [ScriptMethod]
        public static int InsertEmployerAdmin(string employer_id, string employer_location_id, string name, string gender, string designation, string address, string phone, string email, string active, string notification, string user_type)
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
            //employer.Add("logged_in_userid", Session["user_id"] != null ? Session["user_id"].ToString() : "1");
            employer.Add("logged_in_userid", "1");
            employer.Add("ip_address", new Utils().GetIpAddress());
            employer.Add("notification",notification);
            employer.Add("user_type",user_type);
            try
            {               
                var url = string.Format("api/EmployerStaffs/Insert");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employer);
                if(ret>0)
                {
                    var emp = new Dictionary<string, string>();
                    emp.Add("id", employer_id);
                    emp.Add("progress", "3");
                    wHelper.PostExecuteNonQueryResFromWebApi("api/Employer/UpdateProgress", emp);
                }
            }
            catch (Exception ex)
            {     
                CommonLogger.Info(ex.ToString());
                return -2;
            }
            return ret;
        }
    }
}