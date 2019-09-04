using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
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
        public List<DataRow> candidateSkillsList = new List<DataRow>();
        public List<DataRow> candidateQualificationsList = new List<DataRow>();
        public List<DataRow> candidateExperiencesList = new List<DataRow>();
        public List<DataRow> employerLocationList = new List<DataRow>();
        public List<DataRow> currencyList = new List<DataRow>();
        public List<DataRow> documentList = new List<DataRow>();
        public static Dictionary<string, Dictionary<string, string>> dict_qualifications;
        public static Dictionary<string, Dictionary<string, string>> dict_experiences;
        public static List<int> uploadedDocuments;
        public Dictionary<string, string> genders = new Dictionary<string, string>() { { "", "Choose Gender*" }, { "male", "Male" }, { "female", "Female" }, { "other", "Other" } };
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
                if (!IsPostBack)
                {
                    ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                    WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    // To redirect to previous page
                    if (Request.UrlReferrer.ToString() != null)
                        Session["previous_url"] = Request.UrlReferrer.ToString();
                    if (Request.QueryString["id"] != null)
                    {
                        int id = Convert.ToInt32(Request.QueryString["id"]);
                        GetCandidate(id);
                        GetCandidateSkills(id);
                        GetCandidateQualifications(id);
                        GetCandidateExperiences(id);
                    }
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

        private void GetCandidateSkills(int id)
        {
            try
            {
                var url = string.Format("api/Candidates/GetSkills?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                candidateSkillsList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        private void GetCandidateQualifications(int id)
        {
            try
            {
                var url = string.Format("api/Candidates/GetQualifications?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                candidateQualificationsList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        private void GetCandidateExperiences(int id)
        {
            try
            {
                var url = string.Format("api/Candidates/GetExperiences?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                candidateExperiencesList = dt.AsEnumerable().ToList();
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

        public Dictionary<string, string> PrepareCandidate()
        {
            var candidate = new Dictionary<string, string>();
            candidate.Add("user_id", Request.Form["user_id"]);
            candidate.Add("name", Request.Form["name"].Trim());
            candidate.Add("dob", Request.Form["dob"]);
            candidate.Add("gender", Request.Form["gender"]);
            candidate.Add("address", Request.Form["address"].Trim());
            candidate.Add("email", Request.Form["email"].Trim());
            candidate.Add("phone", Request.Form["phone"]);
            candidate.Add("others", Request.Form["others"].Trim());

            candidate.Add("status", (Request.Form["status"] == null ? "0" : Request.Form["status"]));
            candidate.Add("rating", (Request.Form["rating"] == null ? "0" : Request.Form["rating"]));
            candidate.Add("employer_comments", (Request.Form["employer_comments"] == null ? "" : Request.Form["employer_comments"]));
            candidate.Add("active", (Request.Form["active"] == null ? "1" : (Request.Form["active"] == "on") ? "1" : "0"));
            candidate.Add("ip_address", new Utils().GetIpAddress());
            candidate.Add("notification", (Request.Form["notitfication"] == "on") ? "1" : "0");
            candidate.Add("user_type", "6");

            candidate.Add("skills", Request.Form["skills"]);
            candidate.Add("qualifications", JsonConvert.SerializeObject(dict_qualifications));
            candidate.Add("experiences", JsonConvert.SerializeObject(dict_experiences));
            return candidate;
        }

        public int InsertCandidate()
        {
            int ret = 0;
            Dictionary<string, string> candidate = PrepareCandidate();
            candidate["password"] = Utils.GeneratePassword();
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
            if (ret > 0)
            {
                File.AppendAllText(Server.MapPath(Constants.uploadsDir) + "Candidate_Logins.txt", candidate["email"] + " : " + candidate["password"] + "\r\n");
                new DataUtils().SendEmail(candidate["name"], candidate["email"], candidate["password"], Constants.EmailTypes.NewUser);
            }
            return ret;
        }

        public int EditCandidate()
        {
            int ret = 0;
            Dictionary<string, string> candidate = PrepareCandidate();
            candidate.Add("id", Request.QueryString["id"]);
            try
            {
                var url = string.Format("api/Candidates/Edit");
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
            int ret = 0;
            if(Request.QueryString["id"]!=null)
            {
                ret = EditCandidate();
                if(ret > 0)
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_UPDATE);
                else
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UPDATE);
            }
            else
            {
                ret = InsertCandidate();
                if (ret > 0)
                {
                    Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString() + "CandidateDocUpdate.aspx?id=" + ret);
                }
                else
                {
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_RECORD_EXIST);
                }
            }           
        }

    }
}