using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace recruiter_webapp
{
    public partial class Logout : System.Web.UI.UserControl
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
            WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
        }

        
    }
}