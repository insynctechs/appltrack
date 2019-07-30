using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class CandidateDocUpdate : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> candidateList = new List<DataRow>();
        public List<DataRow> employerLocationList = new List<DataRow>();
        public List<DataRow> currencyList = new List<DataRow>();
        public List<DataRow> documentList = new List<DataRow>();
        public static Dictionary<string, Dictionary<string, string>> dict_qualifications;
        public static Dictionary<string, Dictionary<string, string>> dict_experiences;
        public static List<int> uploadedDocuments;
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
                    //GetCandidate(Convert.ToInt32(Request.QueryString["id"]));
                    //GetEmployerLocations(Convert.ToInt32(jobList[0]["employer_id"]));
                }
                if (Request.QueryString["employer_id"] != null)
                {
                    //GetEmployerLocations(Convert.ToInt32(Request.QueryString["employer_id"]));
                }
                //GetDocumentList();
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
        }
    }
}