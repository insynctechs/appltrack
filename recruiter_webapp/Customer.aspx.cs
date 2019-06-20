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
    public partial class Customer : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        private int userid = 1; // For testing purpose
        WebApiHelper wHelper = new WebApiHelper();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            lblResponseMsg.Text = "";
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
            }

            if (Request.Url.ToString().Contains("Delete"))
                DeleteCustomer();

            GetAllCustomers();
        }


        public void pager_Command(object sender, CommandEventArgs e)
        {
            int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
            pager1.CurrentIndex = currnetPageIndx;
            if (srchVal != null)
                GetCustomers();
            else
                GetAllCustomers();
        }

        private void DeleteCustomer()
        {
            try
            {
                var url = string.Format("api/Customers/Delete?id=" + Request.QueryString["id"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                GetAllCustomers();
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

        private void GetAllCustomers()
        {
            try
            {
                var url = string.Format("api/Customers/Get?PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex + "&srchBy=" + srchBy.Value + "&srchVal=");
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                customerList.DataSource = ds.Tables[0];
                customerList.DataBind();
                pager1.ItemCount = Convert.ToDouble(ds.Tables[1].Rows[0][0]);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }
        /*
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
                        responseMsg = new DataUtils().ValidateExcelFile(file, userid, Constants.ModelTypes.Skill);
                        if (responseMsg != "")
                        {
                            Utils.setErrorLabel(lblResponseMsg, responseMsg + " Records Inserted.");
                            try
                            {
                                var url = string.Format("api/Skills/Get/Duplicates?userid=" + userid);
                                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                                SkillListForDuplicates = dt.AsEnumerable().ToList();
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
        */
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pager1.CurrentIndex = 1; // Reset to display records starting from first page
            GetCustomers();
        }

        private void GetCustomers()
        {
            try
            {
                var url = string.Format("api/Customers/Get?srchBy=" + srchBy.Value + "&srchVal=" + srchVal.Value + "&PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex);
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                customerList.DataSource = ds.Tables[0];
                customerList.DataBind();
                pager1.ItemCount = Convert.ToDouble(ds.Tables[1].Rows[0][0]);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }
    }
}