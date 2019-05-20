﻿using System;
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
    public partial class Skill : System.Web.UI.Page
    {

        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        private string modelType;

        // Should to be assigned from an external constant.
        public int maxFileSize { get; set; }

        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> SkillList;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            modelType = "Skill";
            maxFileSize = 1048576;
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
            }

            InitializeVars();
            if (Request.Url.ToString().Contains("Delete"))
                DeleteSkill();

            if (Request.Url.ToString().Contains("Edit"))
                EditSkill();

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
                var urlGetId1 = string.Format("api/Skills/Delete?id=" + Request.QueryString["id"]);
                //rfqmessage.InnerText += urlGetId1;
                wHelper.DeleteRecordFromWebApi(urlGetId1);
                GetSkills();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }


        }

        private void EditSkill()
        {

            try
            {
                var urlGetId1 = string.Format("api/Skills/Edit?id=" + Request.QueryString["id"]);
                int res1 = wHelper.GetExecuteNonQueryResFromWebApi(urlGetId1);

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
                //if(dt.Rows.Count > 0)
                //{
                SkillList = dt.AsEnumerable().ToList();
                //}
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }
        /*
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                var urlGetId1 = string.Format("api/Skills/Insert?title=" + txtTitle.Value.ToString());
                //rfqmessage.InnerText += urlGetId1;
                int res1 = wHelper.GetExecuteNonQueryResFromWebApi(urlGetId1);
                GetSkills();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }
        */

        // To upload, store and validate file.
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            var successColor = System.Drawing.Color.MediumSpringGreen;
            var failureColor = System.Drawing.Color.IndianRed;
            string responseMsg = "";

            if (fileUpload.HasFile)
            {
                string fileExtension = System.IO.Path.GetExtension(fileUpload.FileName);
                if (fileExtension.ToLower() != ".xls" && fileExtension.ToLower() != ".xlsx" && fileExtension.ToLower() != ".csv")
                    setUploadMsgLabel("Only .xls, .xlsx, .csv files supported.", failureColor);
                else
                {
                    int fileSize = fileUpload.PostedFile.ContentLength;
                    if (fileSize >= maxFileSize)
                    {
                        setUploadMsgLabel("Filesize exceeds maximum limit 1MB.", failureColor);
                    }
                    else
                    {
                        string file = Server.MapPath("~/Uploads/" + fileUpload.FileName).ToString();
                        fileUpload.SaveAs(file);
                        responseMsg = new DataUtils().ValidateExcelFile(file, modelType);
                        if (responseMsg != "")
                        {
                            setUploadMsgLabel(responseMsg, failureColor);
                        }
                        else
                        {
                            setUploadMsgLabel("blank responseMsg means ok", successColor);
                        }
                    }
                }
            }
            else
                setUploadMsgLabel("Please select a file.", failureColor);

        }

        // To display response messages for file upload.
        public void setUploadMsgLabel(string msg, System.Drawing.Color color)
        {
            lblUploadMsg.Text = msg;
            lblUploadMsg.ForeColor = color;
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