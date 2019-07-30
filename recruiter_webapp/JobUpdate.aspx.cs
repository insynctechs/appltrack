using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class JobUpdate : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> jobList = new List<DataRow>();
        public List<DataRow> employerLocationList = new List<DataRow>();
        public List<DataRow> currencyList = new List<DataRow>();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["user_id"] != null) && (Convert.ToInt32(Session["user_id"]) < 4))
            {
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }

                    if (Request.QueryString["id"] != null)
                    {
                        GetJob(Convert.ToInt32(Request.QueryString["id"]));
                        GetEmployerLocations(Convert.ToInt32(jobList[0]["employer_id"]));
                    }
                    if (Request.QueryString["employer_id"] != null)
                    {
                        GetEmployerLocations(Convert.ToInt32(Request.QueryString["employer_id"]));
                    }
                GetCurrencyList();
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void GetJob(int id)
        {
            try
            {
                var url = string.Format("api/Jobs/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                jobList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetCurrencyList()
        {
            try
            {
                var url = string.Format("api/Utils/GetCurrencyList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                currencyList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }
        

        private void GetEmployerLocations(int id)
        {
            try
            {
                var url = string.Format("api/EmployerLocations/GetList?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerLocationList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public Dictionary<string, string> prepareJob()
        {
            Dictionary<string, string> job = new Dictionary<string, string>();
            job.Add("employer_id", Request.Form["employer_id"].Trim());
            job.Add("location_id", Request.Form["location_id"].Trim());
            job.Add("job_code", Request.Form["job_code"].Trim());
            job.Add("description", Request.Form["description"].Trim());
            job.Add("vacancy_count", Request.Form["vacancy_count"].Trim());
            job.Add("currency", Request.Form["currency"].Trim());
            job.Add("min_sal", Request.Form["min_salary"].Trim());
            job.Add("max_sal", Request.Form["max_salary"].Trim());
            job.Add("other_notes", Request.Form["other_notes"].Trim());
            job.Add("min_exp", Request.Form["min_experience"].Trim());
            job.Add("max_exp", Request.Form["max_experience"].Trim());
            job.Add("job_skills", Request.Form["skills"].Trim());
            job.Add("job_qualifications", Request.Form["qualifications"].Trim());
            job.Add("join_date", Request.Form["join_date"].Trim());
            job.Add("active", (Request.Form["active"] == "on") ? "1" : "0");
            job.Add("logged_in_userid", Session["user_id"] != null ? Session["user_id"].ToString() : "1");

            return job;
        }

        public int InsertJob()
        {
            int ret = 0;
            Dictionary<string, string> job = prepareJob();                              
                try
                {
                    var url = string.Format("api/Jobs/Insert");
                    ret = wHelper.PostExecuteNonQueryResFromWebApi(url, job);
                }
                catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString());
                    return -2;
                }
            return ret;
        }

        public int EditJob(int id)
        {
            int ret = 0;
            Dictionary<string, string> job = prepareJob();
            job.Add("job_id", id.ToString());
           
            try
            {
                var url = string.Format("api/Jobs/Edit");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, job);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
                return -2;
            }
            return ret;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            int ret = 0;
            if (Request.QueryString["id"] != null) {
                EditJob(Convert.ToInt32(Request.QueryString["id"]));
                if (ret > 0)
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_UPDATE);
                else
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UPDATE);
            }
            else
            {
                ret = InsertJob();
                if (ret > 0)
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_INSERT);
                else
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_RECORD_EXIST);
            }
                
        }

        // For fetching list of skills for ajax autocomplete
        [WebMethod]
        public static string GetSkillList(string searchValue)
        {
            string strList = "";           
            try
            {
                var url = string.Format("api/Skills/Get?srchVal="+searchValue);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                List<DataRow>tempList = dt.AsEnumerable().ToList();
                strList = JsonConvert.SerializeObject(dt, Formatting.Indented);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return strList;
        }

        // For fetching list of qualifications for ajax autocomplete
        [WebMethod]
        public static string GetQualificationList(string searchValue)
        {
            string strList = "";
            try
            {
                var url = string.Format("api/Qualifications/Get?srchVal=" + searchValue);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                List<DataRow> tempList = dt.AsEnumerable().ToList();
                strList = JsonConvert.SerializeObject(dt, Formatting.Indented);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return strList;
        }
    }
}