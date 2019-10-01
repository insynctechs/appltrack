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
    public partial class JobDetails : System.Web.UI.Page
    {

        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> jobDetailList = new List<DataRow>();
        public Boolean isApplied = false;
        public Boolean isCandidate = true;

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
            if (Request.QueryString["customer"] != null && Request.QueryString["job_id"] != null)
            {
                GetJob(Convert.ToInt32(Request.QueryString["job_id"].ToString()));
            }

            CheckCandidateApplied();
         
        }

        private void CheckCandidateApplied()
        {
            if (Session["user_type"] != null)
            {
                if (Session["user_type"].ToString() == "6")
                {
                    if (IsAppliedForJob(Convert.ToInt32(Request.QueryString["job_id"].ToString()), Convert.ToInt32(Session["user_ref_id"].ToString())) == 1)
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
            if(Session["user_type"] != null)
            {
                if (Session["user_type"].ToString() == "6")
                {
                    try
                    {
                        var url = string.Format("api/Jobs/InsertApplied");
                        var job_candidate = new Dictionary<string, string>();
                        job_candidate.Add("job_id", Request.QueryString["job_id"].ToString().Trim());
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
    }
}