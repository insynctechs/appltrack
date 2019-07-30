using recruiter_webapp.Helpers;
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
                    GetInterview(Convert.ToInt32(Request.QueryString["id"]));
                    //GetEmployerLocations(Convert.ToInt32(jobList[0]["employer_id"]));
                }
                if (Request.QueryString["employer_id"] != null)
                {
                    GetEmployerLocations(Convert.ToInt32(Request.QueryString["employer_id"]));
                }
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
                jobList = dt.AsEnumerable().ToList();
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

        public int InsertInterview()
        {
            int ret = 0;
            var interview = new Dictionary<string, string>();
            interview.Add("job_id", Request.Form["job_id"].Trim());
            interview.Add("title", Request.Form["title"].Trim());
            interview.Add("description", Request.Form["description"].Trim());
            interview.Add("round", Request.Form["round"].Trim());
            interview.Add("venue", Request.Form["venue"].Trim());
            interview.Add("date_of_interview", Request.Form["date_of_interview"]);
            interview.Add("active", (Request.Form["active"] == "on") ? "1" : "0");
            interview.Add("logged_in_userid", Session["user_id"] != null ? Session["user_id"].ToString() : "1");
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            int ret = 0;
            if (Request.QueryString["id"] != null) { }
            //EditJob(Convert.ToInt32(Request.QueryString["id"]));
            else
            {
                ret = InsertInterview();
                var ret1 = ret;
                if (ret > 0)
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_INSERT);
                else
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_RECORD_EXIST);
            }

        }
    }
}