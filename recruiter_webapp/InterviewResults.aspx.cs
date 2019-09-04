using recruiter_webapp.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using OfficeOpenXml.Table;
using OfficeOpenXml.Drawing.Chart;
using System.IO;
using OfficeOpenXml.Style;
using System.Diagnostics;

namespace recruiter_webapp
{
    public partial class InterviewResults : System.Web.UI.Page
    {
        #region declaration
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> jobList = new List<DataRow>();
        public List<DataRow> interviewList = new List<DataRow>();
        public DataSet ds;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 4)
                {
                    lblResponseMsg.Text = "";
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }
                    if (Request.QueryString["job_id"] != null)
                    {
                        GetJobDetails(Convert.ToInt32(Request.QueryString["job_id"]));
                        GetInterviewListForJob(Convert.ToInt32(Request.QueryString["job_id"]));
                        GetInterviewResults(Convert.ToInt32(Request.QueryString["job_id"]));
                    }
                }

            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }

        }

        private void GetJobDetails(int id)
        {
            try
            {
                var url = string.Format("api/Jobs/Get?id=" + id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                jobList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetInterviewListForJob(int job_id)
        {
            try
            {
                var url = string.Format("api/Jobs/GetInterviewList?job_id=" + job_id);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                interviewList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public void GetInterviewResults(int job_id)
        {
            int interview_id = Convert.ToInt32(Request.QueryString["interview_id"]);
            try
            {
                var url = string.Format("api/Jobs/GetInterviewResults?job_id=" + job_id+"&interview_id="+interview_id);
                ds = wHelper.GetDataSetFromWebApi(url);
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public void WriteToSpreadsheet()
        {
            //Using SaveAs
            using (ExcelPackage excelPackage = new ExcelPackage())
            {
                //Set some properties of the Excel document
                excelPackage.Workbook.Properties.Author = "InsyncTech Solutions";
                excelPackage.Workbook.Properties.Title = "Interview Results";
                excelPackage.Workbook.Properties.Subject = "Interview Results";
                excelPackage.Workbook.Properties.Created = DateTime.Now;


                ExcelWorksheet worksheet = excelPackage.Workbook.Worksheets.Add("Results");
                worksheet.Row(1).Height = 20;
                worksheet.Row(1).Style.Font.Bold = true;
                worksheet.Cells[1, 1, 1, 7].Merge = true;
                worksheet.Row(1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = ("Interview Results for "+ jobList[0]["job_code"].ToString()).ToUpper() + " Generated On: " + DateTime.Now.ToShortDateString();
                worksheet.Cells[1,1].Style.Fill.PatternType = ExcelFillStyle.Solid;
                worksheet.Cells[1,1].Style.Fill.BackgroundColor.SetColor(Constants.excelHeaderColor);

                int rowIndex = 3;
                foreach (DataTable table in ds.Tables)
                {
                    int sno = 0;
                    
                    worksheet.Row(rowIndex).Height = 20;
                    worksheet.Row(rowIndex).Style.Font.Bold = true;
                    worksheet.Cells[rowIndex, 1, rowIndex, 7].Merge = true;
                    worksheet.Row(rowIndex).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells[rowIndex, 1].Value = table.Rows[0]["title"] + " (Round "+table.Rows[0]["round"]+") On " + Convert.ToDateTime(table.Rows[0]["date_of_interview"]).ToShortDateString();
                    worksheet.Cells[rowIndex, 1].Style.Fill.PatternType = ExcelFillStyle.Solid;
                    worksheet.Cells[rowIndex, 1].Style.Fill.BackgroundColor.SetColor(Constants.excelHeaderColor);
                    rowIndex += 1;
                    
                    worksheet.Row(rowIndex).Height = 20;
                    worksheet.Row(rowIndex).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Row(rowIndex).Style.Font.Bold = true;
                    worksheet.Cells[rowIndex, 1].Value = "S.No";
                    worksheet.Cells[rowIndex, 2].Value = "Candidate Name";
                    worksheet.Cells[rowIndex, 3].Value = "Score";
                    worksheet.Cells[rowIndex, 4].Value = "Rating";
                    worksheet.Cells[rowIndex, 5].Value = "Comments";
                    worksheet.Cells[rowIndex, 6].Value = "Status";
                    worksheet.Cells[rowIndex, 7].Value = "Date";
                    rowIndex += 1;

                    foreach (DataRow dr in table.Rows)
                    { 
                        worksheet.Cells[rowIndex, 1].Value = sno+=1;
                        worksheet.Cells[rowIndex, 2].Value = dr["candidate_name"];
                        worksheet.Cells[rowIndex, 3].Value = dr["score"];
                        worksheet.Cells[rowIndex, 4].Value = dr["rating"];
                        worksheet.Cells[rowIndex, 5].Value = dr["employer_comments"];
                        worksheet.Cells[rowIndex, 6].Value = dr["status"];
                        worksheet.Cells[rowIndex, 7].Value = Convert.ToDateTime(dr["date_added"]).ToShortDateString();
                        rowIndex += 1;
                    }
                    worksheet.Cells[rowIndex, 1].Value = "";
                    rowIndex += 1;
                }

                //worksheet.Column(1).AutoFit();
                worksheet.Column(2).AutoFit();
                worksheet.Column(3).AutoFit();
                worksheet.Column(4).AutoFit();
                worksheet.Column(5).AutoFit();
                worksheet.Column(6).AutoFit();
                worksheet.Column(7).AutoFit();

                string filename = Request.QueryString["job_id"] + Utils.GetTimestamp(DateTime.Now) + ".xlsx";

                this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                this.Response.AddHeader(
                          "content-disposition",
                          string.Format("attachment;  filename={0}", filename));
                this.Response.BinaryWrite(excelPackage.GetAsByteArray());
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString()+"/InterviewResults?job_id="+Request.QueryString["job_id"]+"&interview_id="+Request.Form["interview_id"]);
        }

        protected void btn_export_Click(object sender, EventArgs e)
        {
            WriteToSpreadsheet();
        }
    }
}