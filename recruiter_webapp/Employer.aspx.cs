﻿using recruiter_webapp.Helpers;
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
    public partial class Employer : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        private int userid = 1; // For testing purpose
        WebApiHelper wHelper = new WebApiHelper();
        public int stage;
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
                DeleteEmployer();

            GetEmployers();
        }

        public void pager_Command(object sender, CommandEventArgs e)
        {
            int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
            pager1.CurrentIndex = currnetPageIndx;
            if (srchVal != null)
                GetEmployersByField();
            else
                GetEmployers();
        }

        private void DeleteEmployer()
        {
            try
            {
                var url = string.Format("api/Employers/Delete?id=" + Request.QueryString["id"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                GetEmployers();
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

        private void GetEmployers()
        {
            try
            {
                var url = string.Format("api/Employers/Get?PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex + "&srchBy=" + srchBy.Value + "&srchVal=");
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                employerList.DataSource = ds.Tables[0];
                employerList.DataBind();
                pager1.ItemCount = Convert.ToDouble(ds.Tables[1].Rows[0][0]);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pager1.CurrentIndex = 1; // Reset to display records starting from first page
            GetEmployersByField();
        }

        private void GetEmployersByField()
        {
            try
            {
                var url = string.Format("api/Employers/Get?srchBy=" + srchBy.Value + "&srchVal=" + srchVal.Value + "&PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex);
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                employerList.DataSource = ds.Tables[0];
                employerList.DataBind();
                pager1.ItemCount = Convert.ToDouble(ds.Tables[1].Rows[0][0]);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public Boolean IsActive(int active) {
            if(active==1)
            {
                return true;
            }
            return false;
        }

        public int resolveProgress(string progress) {
            return Convert.ToInt32(progress);
        }
    }
}
