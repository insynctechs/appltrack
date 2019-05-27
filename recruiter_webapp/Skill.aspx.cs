using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using recruiter_webapp.Helpers;
using System.Data;
using System.IO;
using System.Configuration;


namespace recruiter_webapp
{
    public partial class Skill : System.Web.UI.Page
    {

        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public Boolean displayResult = false;
        private int userid = 1; // For testing purpose

        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> SkillList;
        public List<DataRow> SkillListForDuplicates;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            lblResponseMsg.Text = "";
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
            }

            InitializeVars();
            if (Request.Url.ToString().Contains("Delete"))
                DeleteSkill();

           /* if (Request.Url.ToString().Contains("Edit"))
                EditSkill(); */

            GetSkills();
        }

        private void InitializeVars()
        {
            SkillList = new List<DataRow>();
        }

        private void DeleteSkill()
        {
            try
            {
                var url = string.Format("api/Skills/Delete?id=" + Request.QueryString["id"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                GetSkills();
                if (ret > 0) {
                    lblResponseMsg.Text = Constants.SUCCESS_DELETE;
                    lblResponseMsg.ForeColor = Constants.successColor;
                }
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        private void GetSkills()
        {
            try
            {
                var url = string.Format("api/Skills/Get?srchBy=ALL&srchVal=");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                SkillList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        // To upload, store and validate file.
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            
            string responseMsg = "";

            if (fileUpload.HasFile)
            {
                string fileExtension = System.IO.Path.GetExtension(fileUpload.FileName);
                if (fileExtension.ToLower() != ".xls" && fileExtension.ToLower() != ".xlsx" && fileExtension.ToLower() != ".csv")
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UNSUPPORTED_DATAFILE);
                else
                {
                    int fileSize = fileUpload.PostedFile.ContentLength;
                    if (fileSize >= Constants.MAX_UPLOAD_SIZE)
                        Utils.setErrorLabel(lblResponseMsg, Constants.ERR_FILE_SIZE);
                    else
                    {
                        string file = Constants.uploadsDir + fileUpload.FileName.ToString();
                        fileUpload.SaveAs(file);
                        responseMsg = new DataUtils().ValidateExcelFile(file, userid, Constants.ModelTypes.Skill);
                        if (responseMsg != "")
                        {
                            Utils.setErrorLabel(lblResponseMsg, responseMsg);
                            try
                            {
                                var url = string.Format("api/Skills/Get/Duplicates?userid=" + userid);
                                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                                SkillListForDuplicates = dt.AsEnumerable().ToList();
                            }
                            catch (Exception ex)
                            {
                                CommonLogger.Info(ex.ToString());
                            }
                            //displayResult = true;
                        }
                        else
                            Utils.setErrorLabel(lblResponseMsg, Constants.ERR_DB_OPERATION);
                    }
                }
            }
            else
                Utils.setErrorLabel(lblResponseMsg, Constants.ERR_NO_FILE);

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                var url = string.Format("api/Skills/Get?srchBy=" + srchBy.Value.ToString() + "&srchVal=" + srchVal.Value.ToString());
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                SkillList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }
    }
}