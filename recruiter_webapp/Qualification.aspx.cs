using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using recruiter_webapp.Helpers;
using System.Data;
using System.Net.Mail;
using System.IO;
using System.Configuration;
using Newtonsoft.Json;

namespace recruiter_webapp
{
    public partial class Qualification : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public Boolean displayUploadResult = false;
        private int userid = 1; // For testing purpose
        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> QualificationListForDuplicates;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 6)
                {
                    lblResponseMsg.Text = "";
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }

                    if (Request.Url.ToString().Contains("Delete"))
                        DeleteQualification();
                    GetQualifications();
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        public void pager_Command(object sender, CommandEventArgs e)
        {
            int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
            pager1.CurrentIndex = currnetPageIndx;
            if (srchVal != null)
                GetQualificationsByTitle();
            else
                GetQualifications();
        }

        private void DeleteQualification()
        {
            try
            {
                var url = string.Format("api/Qualifications/Delete?id=" + Request.QueryString["id"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                GetQualifications();
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
        /*
                private void GetQualifications()
                {
                    try
                    {
                        var url = string.Format("api/Qualifications/Get?srchBy=ALL&srchVal=");
                        DataTable dt = wHelper.GetDataTableFromWebApi(url);
                        QualificationList = dt.AsEnumerable().ToList();
                    }
                    catch (Exception ex)
                    {
                        CommonLogger.Info(ex.ToString());
                    }
                }
        */
        private void GetQualifications()
        {
            try
            {
                var url = string.Format("api/Qualifications/Get?PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex + "&srchBy=" + srchBy.Value + "&srchVal=");
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                qualificationList.DataSource = ds.Tables[0];
                qualificationList.DataBind();
                pager1.ItemCount = Convert.ToDouble(ds.Tables[1].Rows[0][0]);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        // To upload, store and validate file.
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string responseMsg;

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
                        responseMsg = new DataUtils().ValidateExcelFile(file, userid, Constants.ModelTypes.Qualification);
                        if (responseMsg != "")
                        {
                            Utils.setErrorLabel(lblResponseMsg, responseMsg + " Records Inserted.");
                            try
                            {
                                var url = string.Format("api/Qualifications/Get/Duplicates?userid=" + userid);
                                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                                QualificationListForDuplicates = dt.AsEnumerable().ToList();
                                displayUploadResult = true; // Set for displaying conflicting records
                            }
                            catch (Exception ex)
                            {
                                CommonLogger.Info(ex.ToString());
                            }                          
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
            pager1.CurrentIndex = 1; // Reset to display records starting from first page
            GetQualificationsByTitle();
        }

        public void GetQualificationsByTitle()
        {
            try
            {
                var url = string.Format("api/Qualifications/Get?srchBy=" + srchBy.Value + "&srchVal=" + srchVal.Value + "&PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex);
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                qualificationList.DataSource = ds.Tables[0];
                qualificationList.DataBind();
                pager1.ItemCount = Convert.ToDouble(ds.Tables[1].Rows[0][0]);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }
    }
}