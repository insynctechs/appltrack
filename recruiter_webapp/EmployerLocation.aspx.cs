using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class EmployerLocation : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> listEmployers;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 4)
                {
                    lblResponseMsg.Text = "";
                    if (!IsPostBack)
                    {

                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                        if (Request.QueryString["employer_id"] != null)
                        {
                            employer_id.Value = Request.QueryString["employer_id"];
                        }
                        if (Request.QueryString["employer_id"] == null)
                        {
                            employer_id.Value = "0";
                        }
                    }
                    GetEmployerList();

                    if (Request.Url.ToString().Contains("Delete"))
                        DeleteEmployerLocation();

                    GetEmployerLocations();
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
            GetEmployerLocations();
        }

        private void GetEmployerList()
        {
            try
            {
                var url = string.Format("api/Employers/GetList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                listEmployers = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void DeleteEmployerLocation()
        {
            try
            {
                var url = string.Format("api/EmployerLocations/Delete?id=" + Request.QueryString["id"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                GetEmployerLocations();
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

        private void GetEmployerLocations()
        {
            try
            {               
                var url = string.Format("api/EmployerLocations/Get?PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex + "&employer_id=" + employer_id.Value + "&srchBy=" + srchBy.Value + "&srchVal=" + srchVal.Value);
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
        }
    }
}