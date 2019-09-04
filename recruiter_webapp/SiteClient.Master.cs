using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class SiteClient : System.Web.UI.MasterPage
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> industryList = new List<DataRow>();
        public List<DataRow> categoryList = new List<DataRow>();
        public List<DataRow> employerList = new List<DataRow>();
        public DataSet ds { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                // To redirect to previous page
                if (Request.UrlReferrer != null)
                    Session["previous_url"] = Request.UrlReferrer.ToString();
                else
                    Session["previous_url"] = ConfigurationManager.AppSettings["WebURL"].ToString();

            }
            GetIndustryList();
            GetCategoryList();
            if (Request.QueryString["customer"] != null)
            {
                GetEmployers(Convert.ToInt32(Request.QueryString["customer"].ToString()));
            }
        }

        private void GetIndustryList()
        {
            try
            {
                var url = string.Format("api/Utils/GetIndustryList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                industryList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetCategoryList()
        {
            try
            {
                var url = string.Format("api/Utils/GetCategoryList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                categoryList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetEmployers(int customer_id)
        {
            try
            {
                var url = string.Format("api/Employers/GetList?customer_id=" + customer_id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public string GetCustomer()
        {
            return Request.QueryString["customer"];
        }

        public string GetJobCode()
        {
            return Request.Form["job_code"];
        }

        public string GetIndustry()
        {
            return Request.Form["industry"];
        }

        public string GetCategory()
        {
            return Request.Form["category"];
        }

        public string GetSkill()
        {
            return Request.Form["skill_id"];
        }

        public string GetMinExp()
        {
            return Request.Form["min_exp"];
        }

        public string GetMaxExp()
        {
            return Request.Form["max_exp"];
        }

        public string GetEmployer()
        {
            return Request.Form["employer"];
        }
    }
}