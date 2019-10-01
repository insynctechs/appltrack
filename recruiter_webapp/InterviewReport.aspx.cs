﻿using recruiter_webapp.Helpers;
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
    public partial class InterviewReport : System.Web.UI.Page
    {
        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public int customer_id { get; set; }
        public List<DataRow> employerList = new List<DataRow>();
        public List<DataRow> jobList = new List<DataRow>();
        public List<DataRow> reportList = new List<DataRow>();
        public DataTable globalDT { get; set; }
        public string globalURL { get; set; }

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
                    }

                    GetEmployers();
                    if (employer_id.Value != "0")
                    {
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
                var url = string.Format("api/Jobs/GetList?employer_id=" + employer_id.Value);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                jobList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            job_id.Value = "0";
            lblResponseMsg.Text = "";
        }

        protected void btn_Export_Click(object sender, EventArgs e)
        {
            lblResponseMsg.Text = "";
            WriteToSpreadsheet();
        }

        public void WriteToSpreadsheet()
        {
            lblResponseMsg.Text = "";
            try
            {
                string url = string.Format("api/Interviews/GetReport?customer_id=" + customer_id + "&employer_id=" + employer_id.Value + "&job_id=" + job_id.Value + "&from_date=" + fromDate.Value + "&to_date=" + toDate.Value);
                globalURL = url;
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                reportList = dt.AsEnumerable().ToList();

                if (reportList.Count > 0)
                {
                    //Using SaveAs
                    using (ExcelPackage excelPackage = new ExcelPackage())
                    {
                        //Set some properties of the Excel document
                        excelPackage.Workbook.Properties.Author = "InsyncTech Solutions";
                        excelPackage.Workbook.Properties.Title = "Interview Report";
                        excelPackage.Workbook.Properties.Subject = "Interview Report";
                        excelPackage.Workbook.Properties.Created = DateTime.Now;


                        ExcelWorksheet worksheet = excelPackage.Workbook.Worksheets.Add("Report");
                        worksheet.Row(1).Height = 20;
                        worksheet.Row(1).Style.Font.Bold = true;
                        worksheet.Cells[1, 1, 1, 8].Merge = true;
                        worksheet.Row(1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        worksheet.Cells[1, 1].Value = "Interview Report generated on " + DateTime.Now + (fromDate.Value==""?" (All Records)":" (" + fromDate.Value + " to " + toDate.Value + ")");
                        worksheet.Cells[1, 1].Style.Fill.PatternType = ExcelFillStyle.Solid;
                        worksheet.Cells[1, 1].Style.Fill.BackgroundColor.SetColor(Constants.excelHeaderColor);

                        int rowIndex = 2;

                        worksheet.Row(rowIndex).Height = 20;
                        worksheet.Row(rowIndex).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        worksheet.Row(rowIndex).Style.Font.Bold = true;
                        worksheet.Cells[rowIndex, 1].Value = "S.No";
                        worksheet.Cells[rowIndex, 2].Value = "Employer";
                        worksheet.Cells[rowIndex, 3].Value = "Job Code";
                        worksheet.Cells[rowIndex, 4].Value = "Joining Date";
                        worksheet.Cells[rowIndex, 5].Value = "Int. Title";
                        worksheet.Cells[rowIndex, 6].Value = "Round";
                        worksheet.Cells[rowIndex, 7].Value = "Venue";
                        worksheet.Cells[rowIndex, 8].Value = "Interview Date";
                        rowIndex += 1;

                        foreach (var item in reportList)
                        {
                            worksheet.Cells[rowIndex, 1].Value = item["row_number"];
                            worksheet.Cells[rowIndex, 2].Value = item["employer"];
                            worksheet.Cells[rowIndex, 3].Value = item["job_code"];
                            worksheet.Cells[rowIndex, 4].Value = Convert.ToDateTime(item["join_date"]).ToShortDateString();
                            worksheet.Cells[rowIndex, 5].Value = item["title"];
                            worksheet.Cells[rowIndex, 6].Value = item["round"];
                            worksheet.Cells[rowIndex, 7].Value = item["venue"];
                            worksheet.Cells[rowIndex, 8].Value = Convert.ToDateTime(item["date_of_interview"]).ToShortDateString();
                            rowIndex += 1;
                        }
                        worksheet.Cells[rowIndex, 1].Value = "";
                        rowIndex += 1;

                        //worksheet.Column(1).AutoFit();
                        worksheet.Column(2).AutoFit();
                        worksheet.Column(3).AutoFit();
                        worksheet.Column(4).AutoFit();
                        worksheet.Column(5).AutoFit();
                        worksheet.Column(6).AutoFit();
                        worksheet.Column(7).AutoFit();
                        worksheet.Column(8).AutoFit();

                        string filename = "Interview_Report_" + Utils.GetTimestamp(DateTime.Now) + ".xlsx";
                        this.Response.Clear(); // To fix file corruption
                        this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        this.Response.AddHeader(
                                  "content-disposition",
                                  string.Format("attachment;  filename={0}", filename));
                        this.Response.BinaryWrite(excelPackage.GetAsByteArray());
                    }
                    Utils.setSuccessLabel(lblResponseMsg, Constants.SUCCESS_EXCEL_GEN);
                }
                else
                {
                    Utils.setErrorLabel(lblResponseMsg, Constants.ERR_EXCEL_NO_RECORDS);
                }
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            string strJavascript = "<script type='text/javascript'>window.open('Report.aspx?customer_id="+customer_id+"&employer_id=";
            strJavascript += employer_id.Value + "&job_id=" + job_id.Value + "&from_date=" + fromDate.Value + "&to_date=" + toDate.Value +"','_blank');</script>";
            Response.Write(strJavascript);
        }
    }
}