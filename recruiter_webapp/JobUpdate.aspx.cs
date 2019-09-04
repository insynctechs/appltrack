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
    public partial class JobUpdate : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> jobList = new List<DataRow>();
        public List<DataRow> employerList = new List<DataRow>();
        public List<DataRow> employerLocationList = new List<DataRow>();
        public List<DataRow> currencyList = new List<DataRow>();
        public List<DataRow> industryList = new List<DataRow>();
        public List<DataRow> categoryList = new List<DataRow>();
        public List<DataRow> jobSkillsList = new List<DataRow>();
        public List<DataRow> jobQualificationsList = new List<DataRow>();
        public CultureInfo dateFormat = CultureInfo.InvariantCulture;
        
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["user_id"] != null) && (Convert.ToInt32(Session["user_id"]) < 4))
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
                    if (Request.QueryString["employer_id"] != null)
                    {
                        GetEmployerLocations(Convert.ToInt32(Request.QueryString["employer_id"]));
                    }
                if (Request.QueryString["id"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    GetJob(id);                
                    GetEmployerLocations(Convert.ToInt32(jobList[0]["employer_id"]));
                    GetJobSkills(id);
                    GetJobQualifications(id);
                }
                GetCurrencyList();
                GetIndustryList();
                GetCategoryList();
                GetEmployers();
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        public void InitVars()
        {
            
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

        private void GetEmployers()
        {
            try
            {
                var url = string.Format("api/Employers/GetList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetJobSkills(int id)
        {
            try
            {
                var url = string.Format("api/Jobs/GetSkills?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                jobSkillsList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        private void GetJobQualifications(int id)
        {
            try
            {
                var url = string.Format("api/Jobs/GetQualifications?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                jobQualificationsList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int InsertSkill(string title)
        {
            int ret = 0;
            var skill = new Dictionary<string, string>();
            skill.Add("title", title.Trim());
            try
            {
                var url = string.Format("api/Skills/Insert");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, skill);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return ret;
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int InsertQualification(string title)
        {
            int ret = 0;
            var qualification = new Dictionary<string, string>();
            qualification.Add("title", title.Trim());
            try
            {
                var url = string.Format("api/Qualifications/Insert");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, qualification);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return ret;
        }



        public Dictionary<string, string> prepareJob()
        {
            Dictionary<string, string> job = new Dictionary<string, string>();
            job.Add("employer_id", Request.Form["employer_id"].Trim());
            job.Add("location_id", Request.Form["location_id"]!=null? Request.Form["location_id"] : "0");
            job.Add("job_code", Request.Form["job_code"].Trim());
            job.Add("industry", Request.Form["industry"].Trim());
            job.Add("category", Request.Form["category"].Trim());
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
                ret = EditJob(Convert.ToInt32(Request.QueryString["id"]));
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

            if (Request.QueryString["id"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                GetJob(id);
                GetEmployerLocations(Convert.ToInt32(jobList[0]["employer_id"]));
                GetJobSkills(id);
                GetJobQualifications(id);
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