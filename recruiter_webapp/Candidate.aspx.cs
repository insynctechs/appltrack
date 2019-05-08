using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Newtonsoft.Json;
using System.Text.RegularExpressions;
using recruiter_webapp.Helpers;

namespace recruiter_webapp
{
    public partial class About : Page
    {
        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> CandidateList;


        protected void Page_Load(object sender, EventArgs e)
        {
            InitializeVars();
            GetCandidates();
        }

        private void InitializeVars()
        {
            CandidateList = new List<DataRow>();
        }

        private void GetCandidates()
        {
            try
            {
                var url = string.Format("api/Candidate/GetCandidate?srchBy=candidate_name&srchVal=sumi");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                //if(dt.Rows.Count > 0)
                //{
                CandidateList = dt.AsEnumerable().ToList();
                //}
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());

            }
        }

    }
}