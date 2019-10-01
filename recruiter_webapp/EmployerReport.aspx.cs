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
    public partial class EmployerReport : System.Web.UI.Page
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public int customer_id { get; set; }
        public List<DataRow> employerList = new List<DataRow>();
        public List<DataRow> jobList = new List<DataRow>();
        public List<DataRow> reportList = new List<DataRow>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_type"]) < 4)
                {
                    customer_id = 58; // Implementation to resolve needed.
                    lblResponseMsg.Text = "";
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                        fromDate.Value = DateTime.Now.Day.ToString("d2") + "-" + DateTime.Now.Month.ToString("d2") + "-" + DateTime.Now.Year;
                        toDate.Value = DateTime.Now.Day.ToString("d2") + "-" + DateTime.Now.Month.ToString("d2") + "-" + DateTime.Now.Year;
                        GetReport();
                    }
                    
                    GetEmployers();
                    if(employer_id.Value != "0") {
                        GetJobs();
                    }

                }
            }
            else
            {
                Response.Redirect(ConfigurationManager.AppSettings["WebURL"].ToString());
            }
        }

        private void GetEmployers()
        {
            try
            {
                var url = string.Format("api/Employers/GetList");
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                employerList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetJobs()
        {
            try
            {
                var url = string.Format("api/Jobs/GetList?employer_id="+employer_id.Value);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                jobList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetReport()
        {
            try
            {
                var url = string.Format("api/Interviews/GetReport?customer_id="+customer_id+"&employer_id=" + employer_id.Value + "&job_id=" + job_id.Value + "&from_date=" + fromDate.Value + "&to_date=" + toDate.Value);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                reportList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetReport();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {

        }

        public void WriteToSpreadsheet()
        {/*
            //Using SaveAs
            using (ExcelPackage excelPackage = new ExcelPackage())
            {
                //Set some properties of the Excel document
                excelPackage.Workbook.Properties.Author = "InsyncTech Solutions";
                excelPackage.Workbook.Properties.Title = "Interview Results";
                excelPackage.Workbook.Properties.Subject = "Employer Report";
                excelPackage.Workbook.Properties.Created = DateTime.Now;


                ExcelWorksheet worksheet = excelPackage.Workbook.Worksheets.Add("Report");
                worksheet.Row(1).Height = 20;
                worksheet.Row(1).Style.Font.Bold = true;
                worksheet.Cells[1, 1, 1, 7].Merge = true;
                worksheet.Row(1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                worksheet.Cells[1, 1].Value = ("Report for " + jobList[0]["job_code"].ToString()).ToUpper() + " Generated On: " + DateTime.Now.ToShortDateString();
                worksheet.Cells[1, 1].Style.Fill.PatternType = ExcelFillStyle.Solid;
                worksheet.Cells[1, 1].Style.Fill.BackgroundColor.SetColor(Constants.excelHeaderColor);

                int rowIndex = 3;
                foreach (DataTable table in reportDs.Tables)
                {
                    int sno = 0;

                    worksheet.Row(rowIndex).Height = 20;
                    worksheet.Row(rowIndex).Style.Font.Bold = true;
                    worksheet.Cells[rowIndex, 1, rowIndex, 7].Merge = true;
                    worksheet.Row(rowIndex).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    worksheet.Cells[rowIndex, 1].Value = table.Rows[0]["title"] + " (Round " + table.Rows[0]["round"] + ") On " + Convert.ToDateTime(table.Rows[0]["date_of_interview"]).ToShortDateString();
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
                        worksheet.Cells[rowIndex, 1].Value = sno += 1;
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

                string filename = employer_id.Value + Utils.GetTimestamp(DateTime.Now) + ".xlsx";

                this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                this.Response.AddHeader(
                          "content-disposition",
                          string.Format("attachment;  filename={0}", filename));
                this.Response.BinaryWrite(excelPackage.GetAsByteArray());
            }
        */}
    }
}