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
    public partial class CandidateUpdate : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> candidateList = new List<DataRow>();
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
                    GetCandidate(Convert.ToInt32(Request.QueryString["id"]));
                    //GetEmployerLocations(Convert.ToInt32(jobList[0]["employer_id"]));
                }
                if (Request.QueryString["employer_id"] != null)
                {
                    //GetEmployerLocations(Convert.ToInt32(Request.QueryString["employer_id"]));
                }                
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void GetCandidate(int id)
        {
            try
            {
                var url = string.Format("api/Jobs/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                candidateList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {   /*
            int ret = 0;
            if (Request.QueryString["id"] != null) { }
            //EditJob(Convert.ToInt32(Request.QueryString["id"]));
            else
            {
                ret = InsertJob();
                var ret1 = ret;
                if (ret > 0)
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_INSERT);
                else
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_RECORD_EXIST);
            }
            */
        }

        // For fetching list of skills for ajax autocomplete
        [WebMethod]
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