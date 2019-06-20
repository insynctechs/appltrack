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
    public partial class CustomerView : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }

        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> customerList = new List<DataRow>();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            GetCustomer(Convert.ToInt32(Request.QueryString["id"]));
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
            }
        }

        private void GetCustomer(int id)
        {
            try
            {
                var url = string.Format("api/Customers/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                customerList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerStaffUpdate.aspx?customer_id="+ Request.QueryString["id"]);
        }

        protected void btnView_Click(object sender, EventArgs e)
        {

        }
    }
}