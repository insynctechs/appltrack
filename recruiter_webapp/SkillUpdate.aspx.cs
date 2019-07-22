using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class SkillUpdate : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }

        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> SkillList;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 6)
                {
                    InitializeVars();

                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                        if (Request.QueryString["id"] != null)
                        {
                            GetSkill(Convert.ToInt32(Request.QueryString["id"]));
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

        private void InitializeVars()
        {
            SkillList = new List<DataRow>();
        }

        private void GetSkill(int id)
        {
            try
            {
                var url = string.Format("api/Skills/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                SkillList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void EditSkill()
        {
            try
            {
                var url = string.Format("api/Skills/Edit?id=" + Request.QueryString["id"]);
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
                try
                {
                    var url = string.Format("api/Skills/Edit");
                    var skill = new Dictionary<string, string>();
                    skill.Add("id", Request.Form["id"]);
                    skill.Add("title", Request.Form["title"].Trim());
                    int res = wHelper.PostExecuteNonQueryResFromWebApi(url, skill);
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
                    var url = string.Format("api/Skills/Insert");
                    var skill = new Dictionary<string, string>();
                    skill.Add("title", Request.Form["title"].Trim());
                    int res = wHelper.PostExecuteNonQueryResFromWebApi(url, skill);
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