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
    public partial class CustomerStaff : System.Web.UI.Page
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) == 1)
                {
                    lblResponseMsg.Text = "";
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }

                    if (Request.Url.ToString().Contains("Delete"))
                        DeleteCustomerStaff();

                    GetAllCustomerStaffs(Convert.ToInt32(Request.QueryString["customer_id"]));
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
                GetCustomerStaffs(Convert.ToInt32(Request.QueryString["customer_id"]));
            else
                GetAllCustomerStaffs(Convert.ToInt32(Request.QueryString["customer_id"]));
        }

        private void DeleteCustomerStaff()
        {
            try
            {
                var url = string.Format("api/CustomerStaffs/Delete?id=" + Request.QueryString["id"]);
                var ret = wHelper.DeleteRecordFromWebApi(url);
                GetAllCustomerStaffs(Convert.ToInt32(Request.QueryString["customer_id"]));
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

        private void GetAllCustomerStaffs(int customer_id)
        {
            try
            {
                var url = string.Format("api/CustomerStaffs/Get?PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex + "&customer_id=" + customer_id + "&srchBy=" + srchBy.Value + "&srchVal=");
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pager1.CurrentIndex = 1; // Reset to display records starting from first page
            GetCustomerStaffs(Convert.ToInt32(Request.QueryString["customer_id"]));
        }

        private void GetCustomerStaffs(int customer_id)
        {
            try
            {
                var url = string.Format("api/CustomerStaffs/Get?srchBy=" + srchBy.Value + "&srchVal=" + srchVal.Value + "&customer_id=" + customer_id + "&PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex);
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