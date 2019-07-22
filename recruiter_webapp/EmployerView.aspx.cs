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
    public partial class EmployerView : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }

        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> employerList = new List<DataRow>();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 4)
                {
                    GetEmployer(Convert.ToInt32(Request.QueryString["id"]));
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void GetEmployer(int id)
        {
            try
            {
                var url = string.Format("api/Employers/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployerStaffAdd.aspx?employer_id=" + Request.QueryString["id"]);
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployerStaff.aspx?employer_id=" + Request.QueryString["id"]);
        }
    }
}