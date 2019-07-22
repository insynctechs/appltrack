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
    public partial class Job : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public int stage;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 4)
                {
                    lblResponseMsg.Text = "";
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }

                    if (Request.Url.ToString().Contains("Delete"))
                        DeleteJob();

                    GetJobs();
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
                GetEmployersByField();
            else
                GetJobs();
        }

        private void DeleteJob()
        {
            try
            {
                var url = string.Format("api/Employers/Delete?id=" + Request.QueryString["id"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                GetJobs();
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

        private void GetJobs()
        {
            try
            {
                var url = string.Format("api/Jobs/Get?employer_id="+employer_id.Value+"&location_id="+location_id.Value+"&PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex + "&srchBy=" + srchBy.Value + "&srchVal=");
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                jobList.DataSource = ds.Tables[0];
                jobList.DataBind();
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
                jobList.DataSource = ds.Tables[0];
                jobList.DataBind();
                pager1.ItemCount = Convert.ToDouble(ds.Tables[1].Rows[0][0]);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }
    }

    
}
