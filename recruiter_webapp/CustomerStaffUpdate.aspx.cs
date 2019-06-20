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
    public partial class CustomerStaffUpdate : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }

        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> customerStaffList = new List<DataRow>();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
            }

            if (Request.QueryString["id"] != null)
            {
                GetCustomerStaff(Convert.ToInt32(Request.QueryString["id"]));
                if (customerStaffList.Count > 0)
                {
                    id.Value = customerStaffList[0]["id"].ToString();
                    btnSubmit.Text = "Edit";
                }
            }
            lblResponseMsg.Text = "";
        }

        private void GetCustomerStaff(int id)
        {
            try
            {
                var url = string.Format("api/CustomerStaffs/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                customerStaffList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void EditCustomerStaff()
        {
            try
            {
                var url = string.Format("api/CustomerStaff/Edit?id=" + Request.QueryString["id"]);
                int res = wHelper.GetExecuteNonQueryResFromWebApi(url);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var customer = new Dictionary<string, string>();
            customer.Add("id", id.Value.ToString());
            customer.Add("user_id", id.Value.ToString());
            customer.Add("customer_id", id.Value.ToString());
            customer.Add("name", name.Value.ToString());
            customer.Add("gender", address.Value.ToString());
            customer.Add("designation", designation.Value.ToString());
            customer.Add("address", address.Value.ToString());
            customer.Add("phone", phone.Value.ToString());
            customer.Add("email", email.Value.ToString());
            customer.Add("active", active.Value.ToString());
            customer.Add("added_date", added_date.Value.ToString());
            customer.Add("updated_date", updated_date.Value.ToString());
            customer.Add("logged_in_user_id", logged_in_user_id.Value.ToString());
            if (Request.QueryString["id"] != null)
            {
                btnSubmit.Text = "Update";
                try
                {
                    var url = string.Format("api/CustomerStaffs/Edit");
                    int res = wHelper.PostExecuteNonQueryResFromWebApi(url, customer);
                    if (res > 0)
                        Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_UPDATE);
                    else
                        Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UPDATE);
                }
                catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString());
                }
            }
            else
            {
                try
                {
                    var url = string.Format("api/CustomerStaffs/Insert");
                    int res = wHelper.PostExecuteNonQueryResFromWebApi(url, customer);
                    if (res > 0)
                        Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_INSERT);
                    else if (res == -2)
                        Utils.setErrorLabel(lblResponseMsg, Constants.ERR_RECORD_EXIST);
                    else
                        Utils.setErrorLabel(lblResponseMsg, Constants.ERR_DB_OPERATION);
                }
                catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString());
                }

            }

        }
    }
}