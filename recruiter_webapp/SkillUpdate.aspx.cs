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
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
            }

            InitializeVars();
            if (Request.QueryString["id"] != null)
            {
                GetSkill(Convert.ToInt32(Request.QueryString["id"]));
                if (SkillList.Count > 0)
                {
                    title.Value = SkillList[0]["title"].ToString();
                    btnSubmit.Text = "Edit";
                }
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
                    var url = string.Format("api/Skills/Edit?id=" + Request.QueryString["id"]);
                    int res = wHelper.GetExecuteNonQueryResFromWebApi(url);
                }
                catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString());
                }
            }
            else
            {
                var url = string.Format("api/Skills/Insert");
                var skills = new List<KeyValuePair<string, string>>();
                { new KeyValuePair<string, string>("title", title.Value); };

                int res = wHelper.PostExecuteNonQueryResFromWebApi(url, skills);
                /*
                try
                {
                    var url = string.Format("api/Skills/Insert?title=" + title.Value.ToString());
                    int res = wHelper.GetExecuteNonQueryResFromWebApi(url);
                }
                catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString());
                }
                */
            }

        }
    }
}