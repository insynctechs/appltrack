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
                            GetCustomer(Convert.ToInt32(Request.QueryString["id"]));
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
            customer.Add("name", Request.Form["name"].Trim());
            customer.Add("address", Request.Form["address"].Trim());
            customer.Add("city", Request.Form["city"].Trim());
            customer.Add("state", Request.Form["state"].Trim());
            customer.Add("zip", Request.Form["zip"].Trim());
            customer.Add("contact", Request.Form["contact"].Trim());
            customer.Add("email", Request.Form["email"].Trim());
            customer.Add("phone", Request.Form["phone"].Trim());
            customer.Add("active", (Request.Form["active"] == "on") ? "1" : "0");
            if (Request.QueryString["id"] != null)
            {
                customer.Add("id", Request.Form["id"].Trim());
                try
                {
                    var url = string.Format("api/Customers/Edit");                   
                    int res = wHelper.PostExecuteNonQueryResFromWebApi(url, customer);
                    if (res > 0)
                        Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_UPDATE);
                    else if (res == -2)
                        Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UPDATE_NAME_EXIST);                                     
                    else if (res == -3)
                        Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UPDATE_EMAIL_EXIST);
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
                    {
                        Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_INSERT);
                    }
                    else if (res == -2)
                        Utils.setErrorLabel(lblResponseMsg, Constants.ERR_INSERT_NAME_EXIST);                                   
                    else if (res == -3)
                        Utils.setErrorLabel(lblResponseMsg, Constants.ERR_INSERT_EMAIL_EXIST);
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