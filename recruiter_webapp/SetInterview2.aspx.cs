using Newtonsoft.Json;
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
    public partial class SetInterview2 : System.Web.UI.Page
    {

        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> jobList = new List<DataRow>();
        public List<DataRow> interviewList = new List<DataRow>();
        public List<DataRow> candidateList = new List<DataRow>();
        public List<DataRow> selectedCandidateList = new List<DataRow>();
        public List<DataRow> candidateStatusList = new List<DataRow>();
        public Dictionary<string, string> leftPanelStatusList = Constants.shortlistedCandidateStatus;
        public Dictionary<string, string> rightPanelStatusList = Constants.scheduledCandidateStatus;
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
                    if (Request.QueryString["job_id"] != null)
                    {
                        GetInterview(Convert.ToInt32(Request.QueryString["id"]));
                        GetJob(Convert.ToInt32(Request.QueryString["job_id"]));
                        GetQualifiedCandidates(Convert.ToInt32(Request.QueryString["job_id"]));
                        GetSelectedCandidates(Convert.ToInt32(Request.QueryString["id"]));
                    }
                }
                GetCandidateStatusList();
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void GetInterview(int id)
        {
            try
            {
                var url = string.Format("api/Interviews/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                interviewList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }


        private void GetCandidateStatusList()
        {
            try
            {
                var url = string.Format("api/Utils/GetCandidateStatusList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                candidateStatusList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
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

        private void GetQualifiedCandidates(int job_id)
        {
            try
            {
                var url = string.Format("api/Jobs/GetQualifiedsList2?job_id=" + job_id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                candidateList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetSelectedCandidates(int interview_id)
        {
            try
            {
                var url = string.Format("api/Jobs/GetSelectedsList?interview_id=" + interview_id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                selectedCandidateList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int UpdateCandidates(Dictionary<string, Dictionary<string, string>> candidatesDetails, string interview_id, string status)
        {
            int ret = 0;
            Dictionary<string, string> interviewCandidates = new Dictionary<string, string>();
            interviewCandidates.Add("interview_id", interview_id);
            interviewCandidates.Add("status", status);
            interviewCandidates.Add("candidatesDetails", JsonConvert.SerializeObject(candidatesDetails));

            try
            {
                var url = string.Format("api/Interviews/UpdateCandidates");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, interviewCandidates);

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return ret;
        }


        public int SetinterviewForCandidates()
        {
            int ret = 0;
            Dictionary<string, string> interview_candidates = new Dictionary<string, string>();
            interview_candidates.Add("interview_id", Request.Form["interview_id"]);
            interview_candidates.Add("selected_candidates", Request.Form["selected_eligible_candidates"]);
            interview_candidates.Add("status", Request.Form["left_panel_status"]);
            interview_candidates.Add("logged_in_user_id", Session["user_id"] != null ? Session["user_id"].ToString() : "1");
            try
            {
                var url = string.Format("api/Interviews/SetInterview");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, interview_candidates);
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
            SetinterviewForCandidates();
            GetQualifiedCandidates(Convert.ToInt32(Request.QueryString["job_id"]));
            GetSelectedCandidates(Convert.ToInt32(Request.QueryString["id"]));
        }
    }
}