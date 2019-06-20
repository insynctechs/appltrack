using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Script.Services;
using System.Data;
using recruiter_webapp.Helpers;

namespace recruiter_webapp
{
    public partial class SiteMaster : MasterPage
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        public string currentTime { get; set; }
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                currentTime = DateTime.Now.ToString("yyyyMMddhhmmss");
            }
            
        }

        
    }
}