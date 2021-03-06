﻿using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class InterviewUpdate : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> jobList = new List<DataRow>();
        public List<DataRow> interviewList = new List<DataRow>();
        public List<DataRow> interviewListForJob = new List<DataRow>();
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
                    GetInterview(Convert.ToInt32(Request.QueryString["id"]));
                }
                if (Request.QueryString["job_id"] != null)
                {
                    int job_id = Convert.ToInt32(Request.QueryString["job_id"]);
                    GetInterviewsForJob(job_id);
                    GetJob(job_id);
                }
                if (Request.Url.ToString().Contains("Delete"))
                    DeleteInterview();
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

        private void GetInterviewsForJob(int id)
        {
            try
            {
                var url = string.Format("api/Interviews/GetList?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                interviewListForJob = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void DeleteInterview()
        {
            try
            {
                var url = string.Format("api/Interviews/Delete?id=" + Request.QueryString["id"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                Response.Redirect(WebURL+"InterviewUpdate?job_id="+ Request.QueryString["job_id"]);
                if (ret > 0)
                {
                    lblResponseMsg.Text = Constants.SUCCESS_DELETE;
                    lblResponseMsg.ForeColor = Constants.successColor;
                }
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        public Dictionary<string, string> PrepareInterview()
        {
            Dictionary<string, string> interview = new Dictionary<string, string>();
            interview.Add("job_id", Request.QueryString["job_id"].ToString());
            interview.Add("title", Request.Form["title"].Trim());
            interview.Add("description", Request.Form["description"].Trim());
            interview.Add("round", Request.Form["round"].Trim());
            interview.Add("venue", Request.Form["venue"].Trim());
            interview.Add("date_of_interview", Request.Form["date_of_interview"]);
            interview.Add("active", (Request.Form["active"] == "on") ? "1" : "0");
            interview.Add("logged_in_userid", Session["user_id"] != null ? Session["user_id"].ToString() : "1");
            return interview;
        }


        public int InsertInterview()
        {
            Dictionary<string, string> interview = PrepareInterview();
            int ret = 0;
            try
            {
                var url = string.Format("api/Interviews/Insert");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, interview);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
                return -2;
            }
            return ret;
        }

        public int EditInterview(int id)
        {
            Dictionary<string, string> interview = PrepareInterview();
            interview.Add("id", id.ToString());
            int ret = 0;
            try
            {
                var url = string.Format("api/Interviews/Edit");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, interview);
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
                ret = EditInterview(Convert.ToInt32(Request.QueryString["id"]));
                if (ret > 0)
                {
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_UPDATE);
                    GetInterviewsForJob(Convert.ToInt32(Request.QueryString["job_id"]));
                    GetInterview(Convert.ToInt32(Request.QueryString["id"]));
                }
                    
                else if (ret == -3)
                    Utils.setErrorLabel(lblResponseMsg, "Another record already exists for this round.");
                else if (ret == -4)
                    Utils.setErrorLabel(lblResponseMsg, "Interview Date must be before Joining Date.");
                else
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_RECORD_EXIST);

            } 
            else
            {
                ret = InsertInterview();
                if (ret > 0)
                {
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_INSERT);
                    GetInterviewsForJob(Convert.ToInt32(Request.QueryString["job_id"]));
                }
                    
                else if(ret == -3)
                    Utils.setErrorLabel(lblResponseMsg, "Another record already exists for this round.");
                else if (ret == -4)
                    Utils.setErrorLabel(lblResponseMsg, "Interview Date must be before Joining Date.");
                else
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_RECORD_EXIST);

            }

        }
    }
}