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
    public partial class Report2 : System.Web.UI.Page
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> resultList = new List<DataRow>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_type"]) < 4)
                {
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                        GetReport();
                    }
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void GetReport()
        {
            try
            {
                string url = "";
                if (Request.QueryString["employer_id"] != null && Request.QueryString["job_id"] != null && Request.QueryString["interview_id"] != null)
                {
                    url = string.Format("api/Interviews/GetResults?employer_id=" + Request.QueryString["employer_id"] + "&job_id=" + Request.QueryString["job_id"] + "&interview_id=" + Request.QueryString["interview_id"]);
                }

                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                resultList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }
    }
}