using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class CustomerUpdate : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }

        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> customerList = new List<DataRow>();
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
                GetCustomer(Convert.ToInt32(Request.QueryString["id"]));
                if (customerList.Count > 0)
                {
                    id.Value = customerList[0]["id"].ToString();
                    //title.Value = SkillList[0]["title"].ToString();
                    btnSubmit.Text = "Edit";
                }
            }
            lblResponseMsg.Text = "";
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

        private void EditCustomer()
        {
            try
            {
                var url = string.Format("api/Customers/Edit?id=" + Request.QueryString["id"]);
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
            customer.Add("name", name.Value.ToString());
            customer.Add("address", address.Value.ToString());
            customer.Add("city", city.Value.ToString());
            customer.Add("state", state.Value.ToString());
            customer.Add("zip", zip.Value.ToString());
            customer.Add("contact", contact.Value.ToString());
            customer.Add("email", email.Value.ToString());
            customer.Add("phone", phone.Value.ToString());
            customer.Add("active", active.Value.ToString());
            customer.Add("license", license.Value.ToString());
            customer.Add("license_expiry", license_expiry.Value.ToString());
            customer.Add("license_year", license_year.Value.ToString());
            customer.Add("added_date", added_date.Value.ToString());
            customer.Add("updated_date", updated_date.Value.ToString());
            if (Request.QueryString["id"] != null)
            {
                btnSubmit.Text = "Update";
                try
                {
                    var url = string.Format("api/Customers/Edit");                   
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
                    var url = string.Format("api/Customers/Insert");
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