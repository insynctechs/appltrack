using Newtonsoft.Json;
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
    public partial class QualificationUpdate : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }

        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> QualificationList;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            InitializeVars();
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                if(Request.QueryString["id"] != null)
            {
                    GetQualification(Convert.ToInt32(Request.QueryString["id"]));
                    if (QualificationList.Count > 0)
                    {
                        id.Value = QualificationList[0]["id"].ToString();
                        title.Value = QualificationList[0]["title"].ToString();
                        btnSubmit.Text = "Edit";
                    }
                }
            }

            lblResponseMsg.Text = "";
        }

        private void InitializeVars()
        {
            QualificationList = new List<DataRow>();
        }

        private void GetQualification(int id)
        {
            try
            {
                var url = string.Format("api/Qualifications/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                QualificationList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void EditQualification()
        {
            try
            {
                var url = string.Format("api/Qualifications/Edit?id=" + Request.QueryString["id"]);
                int res = wHelper.GetExecuteNonQueryResFromWebApi(url);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                btnSubmit.Text = "Update";
                try
                {
                    var url = string.Format("api/Qualifications/Edit");
                    var qualification = new Dictionary<string, string>();
                    qualification.Add("id", id.Value.ToString());
                    qualification.Add("title", title.Value.ToString());
                    int res = wHelper.PostExecuteNonQueryResFromWebApi(url, qualification);
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
                    var url = string.Format("api/Qualifications/Insert");
                    var qualification = new Dictionary<string, string>();
                    qualification.Add("title", title.Value);
                    int res = wHelper.PostExecuteNonQueryResFromWebApi(url, qualification);
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