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
        public List<DataRow> documentList = new List<DataRow>();
        public List<DataRow> candidateDocumentList = new List<DataRow>();
        public static List<int> uploadedDocuments;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
                if (!IsPostBack)
                {
                    ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                    WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                }
                if (Request.QueryString["id"] != null)
                {
                    GetCandidateDocuments(Convert.ToInt32(Request.QueryString["id"]));
                    //GetCandidate(Convert.ToInt32(Request.QueryString["id"]));
                    //GetEmployerLocations(Convert.ToInt32(jobList[0]["employer_id"]));
                }
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();

                if (Request.Url.ToString().Contains("Delete"))
                    DeleteDocument();

                GetDocumentTypeList();
        }

        private void GetCandidateDocuments(int id)
        {
            try
            {
                var url = string.Format("api/Candidates/GetCandidateDocuments?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                candidateDocumentList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }


        private void GetDocumentTypeList()
        {
            try
            {
                var url = string.Format("api/Utils/GetDocumentTypeList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                documentList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public int DeleteFile(string filename)
        {
            int ret = 0;
            if ((System.IO.File.Exists(filename)))
            {
                System.IO.File.Delete(filename);
                ret = 1;
            }
            return ret;
        }




        public int InsertDocument(Dictionary<string, string> doc)
        {
            int ret = 0;
            try
            {
                var url = string.Format("api/Documents/Insert");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, doc);
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
            HttpPostedFile postedFile = Request.Files["FileUpload"];
            string fileExtension = System.IO.Path.GetExtension(postedFile.FileName);
            if (fileExtension.ToLower() != ".pdf" && fileExtension.ToLower() != ".jpg" && fileExtension.ToLower() != ".doc" && fileExtension.ToLower() != ".docx")
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UNSUPPORTED_DOCFILE);
            else
            {
                int fileSize = postedFile.ContentLength;
                if (fileSize >= Constants.MAX_UPLOAD_SIZE)
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_FILE_SIZE);
                else
                {
                    var candidate_id = Request.QueryString["id"];
                    string doc_type = Request.Form["document_type"];
                    string doc_type_id = Request.Form["document_type_id"];
                    string filename = candidate_id + "_" + Utils.GetTimestamp(DateTime.Now) + "_" + doc_type + fileExtension;

                    Dictionary<string, string> doc = new Dictionary<string, string>();
                    doc.Add("candidate_id", candidate_id);
                    doc.Add("document_type_id", doc_type_id);
                    doc.Add("filename", filename);

                    int ret = InsertDocument(doc);
                    if (ret > 0)
                    {
                        Directory.CreateDirectory(Server.MapPath(Constants.uploadsDir));
                        //Check if File is available.
                        if (postedFile != null && postedFile.ContentLength > 0)
                        {
                            //Save the File.
                            string filePath = Server.MapPath(Constants.uploadsDir) + filename;
                            postedFile.SaveAs(filePath);
                            Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_INSERT);
                        }
                    }
                    else
                    {
                        Utils.setErrorLabel(lblResponseMsg, Constants.ERR_RECORD_EXIST);
                    }
                    GetCandidateDocuments(Convert.ToInt32(Request.QueryString["id"]));
                }
            }


            

            
        }

        private void DeleteDocument()
        {
            try
            {
                var url = string.Format("api/Candidates/DeleteDocument?file=" + Request.QueryString["file"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                if (ret > 0)
                {
                    string fileToDelete = Server.MapPath(Constants.uploadsDir) + Request.QueryString["file"];
                    if(File.Exists(fileToDelete))
                    {
                        File.Delete(@fileToDelete);
                        lblResponseMsg.Text = Constants.SUCCESS_DELETE;
                        lblResponseMsg.ForeColor = Constants.successColor;
                    }
                    
                }
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
            GetCandidateDocuments(Convert.ToInt32(Request.QueryString["id"]));
            Response.Redirect(WebURL+"CandidateDocUpdate.aspx?id="+ Request.QueryString["id"]);
            
        }
    }
}