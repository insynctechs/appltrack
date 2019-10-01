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
using System.IO;

namespace recruiter_webapp
{
    public partial class Vacancies : System.Web.UI.Page
    {

        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> industryList = new List<DataRow>();
        public List<DataRow> industryListWithJobCount = new List<DataRow>();
        public List<DataRow> categoryList = new List<DataRow>();
        public List<DataRow> employerList = new List<DataRow>();
        public List<DataRow> employerListWithJobCount = new List<DataRow>();
        public List<DataRow> jobDetailList = new List<DataRow>();
        public Boolean isApplied = false;
        public Boolean isCandidate = true;
        public Boolean isExpired = false;

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
                if (Request.QueryString["customer"] != null)
                {
                    GetJobs(Request.QueryString["customer"], job_code.Value, industry.Value, category.Value, skill_id.Value, min_exp.Value, max_exp.Value, employer.Value);
                }
            }
            GetIndustryList();
            GetIndustryListWithJobCount();
            GetCategoryList();
            if(hdn_employer.Value !="") {
                GetEmployerDetails(Convert.ToInt32(hdn_employer.Value));
            }

            if (Request.QueryString["customer"] != null)
            {
                GetEmployersWithJobCount(Convert.ToInt32(Request.QueryString["customer"].ToString()));
            }

            if(job_id.Value != "0")
            {
                if (Request.QueryString["customer"] != null)
                {
                    GetJob(Convert.ToInt32(job_id.Value));
                    if (Convert.ToDateTime(jobDetailList[0]["join_date"])<DateTime.Now)
                    {
                        isExpired = true;
                    }
                }
                CheckCandidateApplied();
            }
            else
            {
               /* if(!IsPostBack)
                {
                    if (Request.QueryString["customer"] != null)
                    {
                        GetJobs(Request.QueryString["customer"], job_code.Value, industry.Value, category.Value, skill_id.Value, min_exp.Value, max_exp.Value, employer.Value);
                    }
                }*/
            }
            

        }

        private void GetEmployerDetails(int employer_id)
        {
            try
            {
                var url = string.Format("api/Employers/Get?id=" + employer_id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerList = dt.AsEnumerable().ToList();
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

        private void GetIndustryListWithJobCount()
        {
            try
            {
                var url = string.Format("api/Utils/GetIndustryListWithJobCount");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                industryListWithJobCount = dt.AsEnumerable().ToList();
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


        private void GetEmployersWithJobCount(int customer_id)
        {
            try
            {
                var url = string.Format("api/Employers/GetListWithJobCount?customer_id=" + customer_id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerListWithJobCount = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public void GetJobs(string customer, string job_code, string industry, string category, string skill, string min_exp, string max_exp, string employer)
        {
            
            if (job_code != null)
            {
                if (job_code.Trim() != "")
                {
                    job_code = job_code.Trim();
                }
            }
            else
                job_code = "";
            
            customer = customer == null ? "0" : customer.Trim();

            if (hdn_industry.Value != "")
            {
                industry = hdn_industry.Value;
            }   
            else
                industry = industry == null ? "0" : industry.Trim();
            category = category == null ? "0" : category.Trim();

            if (skill != null)
            {
                if (skill.Trim() != "")
                {
                    skill = skill.Trim();
                }
                else
                    skill = "0";
            }
            else
                skill = "0";

            min_exp = min_exp == null ? "0" : min_exp.Trim();
            max_exp = max_exp == null ? "0" : max_exp.Trim();

            if (hdn_employer.Value != "")
            {
                employer = hdn_employer.Value;
            }
            else
                employer = employer == null ? "0" : employer.Trim();

            try
            {
                var url = string.Format("api/Jobs/GetVacancies?customer=" + customer + "&industry=" + industry + "&category=" + category + "&skill=" + skill + "&job_code=" + job_code + "&employer=" + employer + "&min_exp=" + min_exp + "&max_exp=" + max_exp + "&PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex);
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                jobList.DataSource = ds.Tables[0];
                jobList.DataBind();
                pager1.ItemCount = Convert.ToDouble(ds.Tables[1].Rows[0][0]);
                hdn_itemCount.Value = ds.Tables[1].Rows[0][0].ToString();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public void pager_Command(object sender, CommandEventArgs e)
        {
            int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
            pager1.CurrentIndex = currnetPageIndx;
            GetJobs(Request.QueryString["customer"], job_code.Value, industry.Value, category.Value, skill_id.Value, min_exp.Value, max_exp.Value, employer.Value);
        }

        // For fetching list of skills for ajax autocomplete
        [System.Web.Services.WebMethod]
        public static string GetSkillList(string searchValue)
        {
            string strList = "";
            try
            {
                var url = string.Format("api/Skills/Get?srchVal=" + searchValue);
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



        private void CheckCandidateApplied()
        {
            if (Session["user_type"] != null)
            {
                if (Session["user_type"].ToString() == "6")
                {
                    if (IsAppliedForJob(Convert.ToInt32(job_id.Value), Convert.ToInt32(Session["user_ref_id"].ToString())) == 1)
                        isApplied = true;
                    else
                        isApplied = false;
                }
                else
                    isCandidate = false;

            }
        }


        private void GetJob(int job_id)
        {
            try
            {
                var url = string.Format("api/Jobs/GetDetails?job_id=" + job_id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                jobDetailList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private int IsAppliedForJob(int job_id, int candidate_id)
        {
            int ret = 0;
            try
            {
                var url = string.Format("api/Jobs/IsApplied?job_id=" + job_id + "&candidate_id=" + candidate_id);
                ret = wHelper.GetExecuteNonQueryResFromWebApi(url);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return ret;
        }


        protected void btnApply_Click(object sender, EventArgs e)
        {
            if (Session["user_type"] != null)
            {
                if (Session["user_type"].ToString() == "6")
                {
                    try
                    {
                        var url = string.Format("api/Jobs/InsertApplied");
                        var job_candidate = new Dictionary<string, string>();
                        job_candidate.Add("job_id", job_id.Value);
                        job_candidate.Add("logged_in_userid", Session["user_id"].ToString());
                        job_candidate.Add("candidate_id", Session["user_ref_id"].ToString());
                        int res = wHelper.PostExecuteNonQueryResFromWebApi(url, job_candidate);
                    }
                    catch (Exception ex)
                    {
                        CommonLogger.Info(ex.ToString());
                    }
                    CheckCandidateApplied();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            job_id.Value = "0";
            pager1.CurrentIndex = 1; // Reset to display records starting from first page
            hdn_industry.Value = "";
            hdn_employer.Value = "";
            industry.Value = Request.Form["cmb_industry"] != null ? Request.Form["cmb_industry"] : "0";
            category.Value = Request.Form["cmb_category"] != null ? Request.Form["cmb_category"] : "0";
            //skill_id sets at page
            min_exp.Value = Request.Form["cmb_min_exp"] != null ? Request.Form["cmb_min_exp"] : "0";
            max_exp.Value = Request.Form["cmb_max_exp"] != null ? Request.Form["cmb_max_exp"] : "0";
            employer.Value = "0";
            GetJobs(Request.QueryString["customer"], job_code.Value, industry.Value, category.Value, skill_id.Value, min_exp.Value, max_exp.Value, employer.Value);
        }

        protected void btnLink_Click(object sender, EventArgs e)
        {
            job_id.Value = "0";
            pager1.CurrentIndex = 1; // Reset to display records starting from first page
            job_code.Value = "";
            industry.Value = hdn_industry.Value;
            category.Value = "0";
            skill_id.Value = "0";
            min_exp.Value = "0";
            max_exp.Value = "0";
            employer.Value = hdn_employer.Value;
            GetJobs(Request.QueryString["customer"], job_code.Value, industry.Value, category.Value, skill_id.Value, min_exp.Value, max_exp.Value, employer.Value);
        }

        protected void JobLink_Click(object sender, EventArgs e)
        {
            // This is not a dummy method.
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            job_id.Value = "0";
            pager1.ItemCount = Convert.ToDouble(hdn_itemCount.Value);
        }

    }
}