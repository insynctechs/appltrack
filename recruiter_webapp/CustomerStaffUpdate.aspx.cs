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
        public Dictionary<string, string> user_types = new Dictionary<string, string>() { { "", "Choose Usertype*"}, { "2", "Admin" }, { "3", "Staff"} };
        public Dictionary<string, string> genders = new Dictionary<string, string>() { { "", "Choose Gender*" }, { "male", "Male" }, { "female", "Female" }, { "other", "Other" } };
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) == 1)
                {
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                        // To redirect to previous page
                        if (Request.UrlReferrer.ToString() != null)
                            Session["previous_url"] = Request.UrlReferrer.ToString();
                        if (Request.QueryString["id"] != null)
                        {
                            GetCustomerStaff(Convert.ToInt32(Request.QueryString["id"]));
                            if (customerStaffList.Count > 0)
                            {
                                btnSubmit.Text = "Edit";
                            }
                        }
                    }
                    


                    lblResponseMsg.Text = "";
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
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
            customer.Add("user_id", "0");
            customer.Add("customer_id", Request.Form["customer_id"].Trim());
            customer.Add("name", Request.Form["name"].Trim());
            customer.Add("gender", Request.Form["gender"].Trim());
            customer.Add("designation", Request.Form["designation"].Trim());
            customer.Add("address", Request.Form["address"].Trim());
            customer.Add("phone", Request.Form["phone"].Trim());
            customer.Add("email", Request.Form["email"].Trim());
            customer.Add("active", (Request.Form["active"] == "on") ? "1" : "0");
            customer.Add("logged_in_user_id", Session["user_id"] != null ? Session["user_id"].ToString() : "1");
            customer.Add("ip_address", new Utils().GetIpAddress());
            customer.Add("notification", (Request.Form["notitfication"] == "on") ? "1" : "0");
            customer.Add("user_type", Request.Form["user_type"].Trim());

            if (Request.QueryString["id"] != null)
            {
                customer.Add("id", Request.QueryString["id"].Trim());
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