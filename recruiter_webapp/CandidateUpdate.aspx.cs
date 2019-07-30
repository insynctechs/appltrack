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
    public partial class CandidateUpdate : System.Web.UI.Page
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
                    GetCandidate(Convert.ToInt32(Request.QueryString["id"]));
                    //GetEmployerLocations(Convert.ToInt32(jobList[0]["employer_id"]));
                }
                if (Request.QueryString["employer_id"] != null)
                {
                    //GetEmployerLocations(Convert.ToInt32(Request.QueryString["employer_id"]));
                }
                GetDocumentList();
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
                var url = string.Format("api/Candidates/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                candidateList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetDocumentList()
        {
            try
            {
                var url = string.Format("api/Documents/GetList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                documentList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
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

        public int InsertCandidate()
        {
            int ret = 0;
            var candidate = new Dictionary<string, string>();
            candidate.Add("user_id", "0");
            candidate.Add("name", Request.Form["name"]);
            candidate.Add("dob", Request.Form["dob"]);
            candidate.Add("gender", Request.Form["gender"]);
            candidate.Add("address", Request.Form["address"]);
            candidate.Add("email", Request.Form["email"]);
            candidate.Add("phone", Request.Form["phone"]);
            candidate.Add("others", Request.Form["others"]);
          
            candidate.Add("status", (Request.Form["status"]==null? "0": Request.Form["status"]));
            candidate.Add("rating", (Request.Form["rating"] == null ? "0" : Request.Form["rating"]));
            candidate.Add("employer_comments", (Request.Form["employer_comments"] == null ? "" : Request.Form["employer_comments"]));
            candidate.Add("active", (Request.Form["active"] == "on") ? "1" : "0");
            candidate.Add("ip_address", new Utils().GetIpAddress());
            candidate.Add("notification", (Request.Form["notitfication"] == "on") ? "1" : "0");
            candidate.Add("user_type", "6");

            candidate.Add("skills", Request.Form["skills"]);
            candidate.Add("qualifications", JsonConvert.SerializeObject(dict_qualifications));
            candidate.Add("experiences", JsonConvert.SerializeObject(dict_experiences));
            try
            {
                var url = string.Format("api/Candidates/Insert");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, candidate);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
                return -2;
            }
            return ret;
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod]
        public static int SetFields(Dictionary<string, Dictionary<string, string>> qualifications, Dictionary<string, Dictionary<string, string>> experiences, List<int> documents)
        {
            dict_qualifications = qualifications;
            dict_experiences = experiences;
            uploadedDocuments = documents;
            return 1;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            int candidate_id = InsertCandidate();

            /*
            for (var i = 0; i < Request.Files.Count; i++)
            {
                File.AppendAllText("d:\\allfiles.txt", i+" -> "+Request.Files[i].FileName);
}

            candidate_id = 100;
            Directory.CreateDirectory(Server.MapPath("~/Uploads/" + candidate_id+"/"));
            HttpPostedFile cv_file = Request.Files["cv"];
            HttpPostedFile photo_file = Request.Files["photo"];
            HttpPostedFile new_file = Request.Files["1"];

            if (cv_file != null && cv_file.ContentLength > 0)
            {
                string filePath = Server.MapPath("~/Uploads/") + candidate_id + "/" + Path.GetFileName(cv_file.FileName);
                cv_file.SaveAs(filePath);
            }
            if (photo_file != null && photo_file.ContentLength > 0)
            {
                string filePath = Server.MapPath("~/Uploads/") + candidate_id + "/" + Path.GetFileName(photo_file.FileName);
                photo_file.SaveAs(filePath);
            }
            if (new_file != null && new_file.ContentLength > 0)
            {
                string filePath = Server.MapPath("~/Uploads/") + candidate_id + "/" + Path.GetFileName(new_file.FileName);
                new_file.SaveAs(filePath);
            }

            foreach (int i in uploadedDocuments)
            {
                HttpPostedFile uploaded_file = Request.Files["doc"+i.ToString()];
                if (uploaded_file != null && uploaded_file.ContentLength > 0)
                {
                    string filePath = Server.MapPath("~/Uploads/") + candidate_id + "/" + Path.GetFileName(uploaded_file.FileName);
                    uploaded_file.SaveAs(filePath);
                    /*lbl_cv_message.Visible = true;
                    lbl_cv_message.Text = "";
                }
            }
            */
            
        }

    }
}