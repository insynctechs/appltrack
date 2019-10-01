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
        public List<DataRow> customerList;

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
                    GetCustomers();
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void GetCustomers()
        {
            try
            {
                var url = string.Format("api/Customers/GetList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                customerList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
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
           // File.WriteAllText("d:\\obj.txt", obj.ToString());
        }


        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int InsertEmployer(string customer, string name, string address, string city, string state, string zip, string email, string phone, string description, string active)
        {
            int ret = 0;
            var employer = new Dictionary<string, string>();
            //employer.Add("id", id);
            employer.Add("customer_id", customer);
            employer.Add("name", name.Trim());
            employer.Add("address", address.Trim());
            employer.Add("city", city.Trim());
            employer.Add("state", state.Trim());
            employer.Add("zip", zip.Trim());
            employer.Add("email", email.Trim());
            employer.Add("phone", phone.Trim());
            employer.Add("description", description.Trim());
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
            employer.Add("address", address.Trim());
            employer.Add("city", city.Trim());
            employer.Add("zip", zip.Trim());
            employer.Add("email", email.Trim());
            employer.Add("phone", phone.Trim());
            employer.Add("country", country.Trim());
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
            employer.Add("name", name.Trim());
            employer.Add("gender", gender.Trim());
            employer.Add("designation", designation.Trim());
            employer.Add("address", address.Trim());
            employer.Add("phone", phone.Trim());
            employer.Add("email", email.Trim());
            employer.Add("active", active);
            employer.Add("logged_in_userid", HttpContext.Current.Session["user_id"] != null ? HttpContext.Current.Session["user_id"].ToString() : "1");
            employer.Add("ip_address", new Utils().GetIpAddress());
            employer.Add("notification",notification);
            employer.Add("user_type",user_type);
            employer.Add("password", Utils.GeneratePassword());
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