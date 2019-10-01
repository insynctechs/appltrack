using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class EmployerLocationUpdate : System.Web.UI.Page
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> employerList = new List<DataRow>();
        public List<DataRow> employerLocationList = new List<DataRow>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 4)
                {
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }
                    if (Request.QueryString["employer_id"] != null)
                    {
                        GetEmployer(Convert.ToInt32(Request.QueryString["employer_id"]));
                    }

                    if (Request.QueryString["id"] != null)
                    {
                        GetEmployerLocation(Convert.ToInt32(Request.QueryString["id"]));
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

        private void GetEmployerLocation(int id)
        {
            try
            {
                var url = string.Format("api/EmployerLocations/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerLocationList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        public Dictionary<string, string> PrepareLocation()
        {
            Dictionary<string, string> employerLoc = new Dictionary<string, string>();
            employerLoc.Add("employer_id", Request.Form["employer_id"]);
            employerLoc.Add("address", Request.Form["address"].Trim());
            employerLoc.Add("city", Request.Form["city"].Trim());
            employerLoc.Add("zip", Request.Form["zip"]);
            employerLoc.Add("email", Request.Form["email"]);
            employerLoc.Add("phone", Request.Form["phone"].Trim());
            employerLoc.Add("country", Request.Form["country"].Trim());
            employerLoc.Add("active", (Request.Form["active"] == null ? "1" : Request.Form["active"]));
            return employerLoc;
        }

        public int InsertLocation()
        {
            int ret = 0;
            Dictionary<string, string> employerLoc = PrepareLocation();
            try
            {
                var url = string.Format("api/EmployerLocations/Insert");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employerLoc);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return ret;
        }

        public int EditLocation()
        {
            int ret = 0;
            Dictionary<string, string> employerLoc = PrepareLocation();
            employerLoc.Add("id", Request.QueryString["id"]);
            try
            {
                var url = string.Format("api/EmployerLocations/Edit");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employerLoc);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return ret;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            int ret = 0;
            if (Request.QueryString["id"] != null)
            {
                ret = EditLocation();
                if (ret > 0)
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_UPDATE);
                else
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UPDATE);
            }
            else
            {
                ret = InsertLocation();
                if (ret > 0)
                {
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_INSERT);
                }
                else
                {
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_RECORD_EXIST);
                }
            }
        }





    }
}