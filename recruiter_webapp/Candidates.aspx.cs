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
    public partial class Candidates : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> candidateDocumentList = new List<DataRow>();

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 4)
                {
                    //lblResponseMsg.Text = "";
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }
                    //GetCandidateList();

                    if (Request.Url.ToString().Contains("Delete"))
                        DeleteCandidate();

                    GetCandidateList();
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
            GetCandidateList();
        }


        private void DeleteCandidate()
        {

            GetCandidateDocuments(Convert.ToInt32(Request.QueryString["id"]));
            foreach(var document in candidateDocumentList)
            {
                File.Delete(Server.MapPath(Constants.uploadsDir) + document["filename"]);
            }
            try
            {
                var url = string.Format("api/Candidates/Delete?id=" + Request.QueryString["id"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                GetCandidateList();
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

        private void GetCandidateList()
        {
            try
            {
                var url = string.Format("api/Candidates/GetCandidates?PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex + "&srchBy=" + srchBy.Value + "&srchVal=" + srchVal.Value);
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                candidateList.DataSource = ds.Tables[0];
                candidateList.DataBind();
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
            //GetEmployerStaffs();
            //Response.Redirect(WebURL + "EmployerStaff?employer_id=" + employer_id.Value);
        }

    }
}