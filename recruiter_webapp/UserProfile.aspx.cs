using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;
using System.Configuration;


namespace recruiter_webapp
{
    public partial class UserProfile : System.Web.UI.Page
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> userList = new List<DataRow>();
        public Dictionary<string, string> genders = new Dictionary<string, string>() { { "", "Choose Gender*" }, { "male", "Male" }, { "female", "Female" }, { "other", "Other" } };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                GetUserDetails(Convert.ToInt32(Session["user_ref_id"]), Convert.ToInt32(Session["user_type"]));
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        public void GetUserDetails(int id, int user_type)
        {
            try
            {
                var url = string.Format("api/Users/GetDetails?id=" + id + "&user_type=" + user_type);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                userList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int ret = 0;
            Dictionary<string, string> user = new Dictionary<string, string>();
            user.Add("user_id", Session["user_id"].ToString());
            user.Add("ref_id", (Session["user_ref_id"]==null?"0": Session["user_ref_id"].ToString()));
            user.Add("user_type", Session["user_type"].ToString());
            user.Add("name", (Request.Form["name"] == null ? "" : Request.Form["name"].Trim()));
            user.Add("dob", (Request.Form["dob"] == null ? "" : Request.Form["dob"].Trim()));
            user.Add("gender", (Request.Form["gender"]==null?"": Request.Form["gender"].Trim()));
            user.Add("address", (Request.Form["address"] == null ? "" : Request.Form["address"].Trim()));
            user.Add("email", (Request.Form["email"] == null ? "" : Request.Form["email"].Trim()));
            user.Add("phone", (Request.Form["phone"] == null ? "" : Request.Form["phone"].Trim()));
            user.Add("designation", (Request.Form["designation"] == null ? "" : Request.Form["designation"].Trim()));
            try
            {
                var url = string.Format("api/Users/EditDetails");
                ret = wHelper.PostExecuteNonQueryResFromWebApi(url, user);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            if (ret == 1)
                Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_UPDATE);
            else
                Utils.setErrorLabel(lblResponseMsg, Constants.ERR_UPDATE);
            GetUserDetails(Convert.ToInt32(Session["user_ref_id"]), Convert.ToInt32(Session["user_type"]));
        }
    }
}