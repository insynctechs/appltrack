using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.Script.Services;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class EmployerStaffUpdate : System.Web.UI.Page
    {

        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> employerList = new List<DataRow>();
        public List<DataRow> employerLocationList = new List<DataRow>();
        public List<DataRow> employerStaffList = new List<DataRow>();
        public Dictionary<string, string> locations = new Dictionary<string, string>();
        public Dictionary<string, string> user_types = new Dictionary<string, string>() { { "", "Choose Usertype*" }, { "4", "Admin" }, { "5", "Staff" } };
        public Dictionary<string, string> genders = new Dictionary<string, string>() { { "", "Choose Gender*" }, { "male", "Male" }, { "female", "Female" }, { "other", "Other" } };

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

                    if (Request.QueryString["id"] != null)
                    {
                        GetEmployerStaff(Convert.ToInt32(Request.QueryString["id"]));
                        //GetEmployerAndLocations(Convert.ToInt32(employerStaffList[0]["employer_id"]));
                    }
                    if (Request.QueryString["employer_id"] != null)
                    {
                        GetEmployerAndLocations(Convert.ToInt32(Request.QueryString["employer_id"]));
                    }
                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void GetEmployerStaff(int id)
        {
            try
            {
                var url = string.Format("api/EmployerStaffs/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerStaffList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        private void GetEmployerAndLocations(int id)
        {
            try
            {
                var url = string.Format("api/Employers/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerList = dt.AsEnumerable().ToList();
                url = string.Format("api/EmployerLocations/GetList?id=" + id);
                dt = wHelper.GetDataTableFromWebApi(url);
                employerLocationList = dt.AsEnumerable().ToList();
                locations.Add("", "Choose Location*");
                foreach (var loc in employerLocationList)
                {
                    locations.Add(loc["employer_loc_id"].ToString(), loc["employer_loc_address"].ToString());
                }
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }


        public Dictionary<string, string> PrepareStaff()
        {
            Dictionary<string, string> employerStaff = new Dictionary<string, string>();
            employerStaff.Add("employer_id", Request.Form["employer_id"]);
            employerStaff.Add("employer_location_id", Request.Form["employer_loc_id"]==null?"0": Request.Form["employer_loc_id"].ToString());
            employerStaff.Add("name", Request.Form["name"].Trim());
            employerStaff.Add("gender", Request.Form["gender"]);
            employerStaff.Add("designation", Request.Form["designation"]);
            employerStaff.Add("address", Request.Form["address"].Trim());
            employerStaff.Add("phone", Request.Form["phone"].Trim());
            employerStaff.Add("email", Request.Form["email"].Trim());
            employerStaff.Add("active", (Request.Form["active"] == null ? "1" : (Request.Form["active"] == "on") ? "1" : "0"));
            employerStaff.Add("logged_in_userid", Session["user_id"] != null ? Session["user_id"].ToString() : "1");
            employerStaff.Add("ip_address", new Utils().GetIpAddress());
            employerStaff.Add("notification", (Request.Form["notification"] == null ? "1" : (Request.Form["notification"] == "on") ? "1" : "0"));
            employerStaff.Add("user_type", Request.Form["user_type"]);
            return employerStaff;
        }

        public int InsertStaff()
        {
            int ret = 0;
            Dictionary<string, string> employerStaff = PrepareStaff();
            employerStaff.Add("user_id", "0");
            employerStaff["password"] = Utils.GeneratePassword();
            try
            {
                var url = string.Format("api/EmployerStaffs/Insert");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employerStaff);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
                return -2;
            }
            if (ret > 0)
            {
                File.AppendAllText(Server.MapPath(Constants.uploadsDir) + "EmployerStaff_Logins.txt", employerStaff["email"] + " : " + employerStaff["password"] + "\r\n");
                new DataUtils().SendEmail(employerStaff["name"], employerStaff["email"], employerStaff["password"], Constants.EmailTypes.NewUser);
            }
            return ret;
        }

        public int EditStaff()
        {
            int ret = 0;
            Dictionary<string, string> employerStaff = PrepareStaff();
            employerStaff.Add("id", Request.QueryString["id"]);
            try
            {
                var url = string.Format("api/EmployerStaffs/Edit");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, employerStaff);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
                return -2;
            }
            return ret;
        }


        protected void btn_submit_Click(object sender, EventArgs e)
        {
            int ret = 0;
            if (Request.QueryString["id"] != null)
            {
                ret = EditStaff();
                if (ret > 0)
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_UPDATE);
                else
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UPDATE);
            }
            else
            {
                ret = InsertStaff();
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