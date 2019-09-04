using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace recruiter_webapp
{
    public partial class Vacancies : System.Web.UI.Page
    {

        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public static WebApiHelper wHelper = new WebApiHelper();

        /*
        protected void Page_Init(object sender, EventArgs e)
        {
            Master.SearchButton().Click += new EventHandler(SearchButton_Click);
        }
        */

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                // To redirect to previous page
                if (Request.UrlReferrer != null)
                    Session["previous_url"] = Request.UrlReferrer.ToString();
                else
                    Session["previous_url"] = ConfigurationManager.AppSettings["WebURL"].ToString();  
            }
            if(IsPostBack)
            {
                pager1.PageSize = 3;
                pager1.CurrentIndex = 1;
            }
            GetJobs();


        }
        /*
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            File.WriteAllText("d:\\btnclicked.txt", Master.GetJobCode());
            
            GetJobs();

        }
        */
        public void GetJobs()
        {
            string job_code = "";
            if (Master.GetJobCode() != null)
            {
                if (Master.GetJobCode().Trim() != "")
                {
                    job_code = Master.GetJobCode().Trim();
                }
            }

            string customer = Master.GetCustomer() == null ? "0" : Master.GetCustomer().Trim();
            string industry = Master.GetIndustry() == null ? "0" : Master.GetIndustry().Trim();
            string category = Master.GetCategory() == null ? "0" : Master.GetCategory().Trim();
            string skill = "0";
            if (Master.GetSkill() != null)
            {
                if (Master.GetSkill().Trim() != "")
                {
                    skill = Master.GetSkill().Trim();
                }
            }

            string min_exp = Master.GetMinExp() == null ? "0" : Master.GetMinExp().Trim();
            string max_exp = Master.GetMaxExp() == null ? "0" : Master.GetMaxExp().Trim();
            string employer = Master.GetEmployer() == null ? "0" : Master.GetEmployer().Trim();
            try
            {
                var url = string.Format("api/Jobs/GetVacancies?customer=" + customer + "&industry=" + industry + "&category=" + category + "&skill=" + skill + "&job_code=" + job_code + "&employer=" + employer + "&min_exp=" + min_exp + "&max_exp=" + max_exp + "&PageSize=" + pager1.PageSize + "&CurrentPage=" + pager1.CurrentIndex);
                DataSet ds = wHelper.GetDataSetFromWebApi(url);
                jobList.DataSource = ds.Tables[0];
                jobList.DataBind();
                pager1.ItemCount = Convert.ToDouble(ds.Tables[1].Rows[0][0]);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }


        public void pager_Command(object sender, CommandEventArgs e)
        {
            int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
            pager1.CurrentIndex = currnetPageIndx;
                GetJobs();

        }

        // For fetching list of skills for ajax autocomplete
        [System.Web.Services.WebMethod]
        public static string GetSkillList(string searchValue)
        {
            string strList = "";
            try
            {
                var url = string.Format("api/Skills/Get?srchVal=" + searchValue);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                List<DataRow> tempList = dt.AsEnumerable().ToList();
                strList = JsonConvert.SerializeObject(dt, Formatting.Indented);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return strList;
        }

    }
}