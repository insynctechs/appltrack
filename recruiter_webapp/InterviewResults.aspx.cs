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

        public string ApiPath { get; set; }
        public string WebURL { get; set; }
        WebApiHelper wHelper = new WebApiHelper();
        public List<DataRow> employerList = new List<DataRow>();
        public List<DataRow> jobList = new List<DataRow>();
        public List<DataRow> interviewList = new List<DataRow>();
        public List<DataRow> resultList = new List<DataRow>();
        public int customer_id;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            {
                if (Convert.ToInt32(Session["user_id"]) < 4)
                {
                    customer_id = 58;
                    if (!IsPostBack)
                    {
                        ApiPath = ConfigurationManager.AppSettings["Api"].ToString();
                        WebURL = ConfigurationManager.AppSettings["WebURL"].ToString();
                    }
                    GetEmployers();
                    if (employer_id.Value != "0" || Request.QueryString["employer_id"]!=null)
                    {
                        GetJobs();
                    }
                    if (job_id.Value != "0" || Request.QueryString["job_id"] != null)
                    {
                        GetInterviewListForJob();
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
                var url = "";
                if(employer_id.Value!="0")
                {
                    url = string.Format("api/Jobs/GetList?employer_id=" + employer_id.Value);
                }
                if(Request.QueryString["employer_id"]!=null)
                {
                    url = string.Format("api/Jobs/GetList?employer_id=" + Request.QueryString["employer_id"]);
                }
                
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                jobList = dt.AsEnumerable().ToList();

            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        private void GetInterviewListForJob()
        {
            try
            {
                var url = "";
                if (job_id.Value != "0")
                {
                    url = string.Format("api/Jobs/GetInterviewList?job_id=" + job_id.Value);
                }
                if (Request.QueryString["job_id"] != null)
                {
                    url = string.Format("api/Jobs/GetInterviewList?job_id=" + Request.QueryString["job_id"]);
                } 
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                interviewList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public void GetInterviewResults()
        {
            //int interview_id = Convert.ToInt32(Request.QueryString["interview_id"]);
            try
            {
                var url = string.Format("api/Interviews/GetResults?employer_id=" + employer_id.Value + "&job_id=" + job_id.Value +"&interview_id="+ interview_id.Value);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                resultList = dt.AsEnumerable().ToList();
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
        }

        public void WriteToSpreadsheet()
        {
            try
            {
                var url = string.Format("api/Interviews/GetResults?employer_id=" + employer_id.Value + "&job_id=" + job_id.Value + "&interview_id=" + interview_id.Value);
                DataTable dt = wHelper.GetDataTableFromWebApi(url);
                resultList = dt.AsEnumerable().ToList();

                if (resultList.Count > 0)
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
                        worksheet.Row(1).Style.Font.Size = 12;
                        worksheet.Cells[1, 1, 1, 13].Merge = true;
                        worksheet.Row(1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        worksheet.Cells[1, 1].Value = "Interview Results Report generated on " + DateTime.Now.ToLongDateString();
                        worksheet.Cells[1, 1].Style.Fill.PatternType = ExcelFillStyle.Solid;
                        worksheet.Cells[1, 1].Style.Fill.BackgroundColor.SetColor(Constants.excelHeaderColor);

                        int rowIndex = 2;

                        worksheet.Row(rowIndex).Height = 20;
                        worksheet.Row(rowIndex).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        worksheet.Row(rowIndex).Style.Font.Bold = true;
                        worksheet.Cells[rowIndex, 1].Value = "S.No";
                        worksheet.Cells[rowIndex, 2].Value = "Employer";
                        worksheet.Cells[rowIndex, 3].Value = "Job Code";
                        worksheet.Cells[rowIndex, 4].Value = "Title";
                        worksheet.Cells[rowIndex, 5].Value = "Round";
                        worksheet.Cells[rowIndex, 6].Value = "Venue";
                        worksheet.Cells[rowIndex, 7].Value = "Int. Date";
                        worksheet.Cells[rowIndex, 8].Value = "Candidate Name";
                        worksheet.Cells[rowIndex, 9].Value = "Score";
                        worksheet.Cells[rowIndex, 10].Value = "Rating";
                        worksheet.Cells[rowIndex, 11].Value = "Comments";
                        worksheet.Cells[rowIndex, 12].Value = "Status";
                        worksheet.Cells[rowIndex, 13].Value = "Status Date";
                        rowIndex += 1;


                        foreach (var item in resultList)
                        {
                            worksheet.Cells[rowIndex, 1].Value = item["row_number"];
                            worksheet.Cells[rowIndex, 2].Value = item["employer"];
                            worksheet.Cells[rowIndex, 3].Value = item["job_code"];
                            worksheet.Cells[rowIndex, 4].Value = item["title"];
                            worksheet.Cells[rowIndex, 5].Value = item["round"];
                            worksheet.Cells[rowIndex, 6].Value = item["venue"];
                            worksheet.Cells[rowIndex, 7].Value = Convert.ToDateTime(item["date_of_interview"]).ToShortDateString();
                            worksheet.Cells[rowIndex, 8].Value = item["candidate_name"];
                            worksheet.Cells[rowIndex, 9].Value = item["score"];
                            worksheet.Cells[rowIndex, 10].Value = item["rating"];
                            worksheet.Cells[rowIndex, 11].Value = item["employer_comments"];
                            worksheet.Cells[rowIndex, 12].Value = item["status"];
                            worksheet.Cells[rowIndex, 13].Value = Convert.ToDateTime(item["date_added"]).ToShortDateString();
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
                        worksheet.Column(9).AutoFit();
                        worksheet.Column(10).AutoFit();
                        worksheet.Column(11).AutoFit();
                        worksheet.Column(12).AutoFit();
                        worksheet.Column(13).AutoFit();

                        string filename = "Interview_Results_" + Utils.GetDatestamp(DateTime.Now) + ".xlsx";
                        this.Response.Clear(); // To fix file corruption
                        this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        this.Response.AddHeader(
                                  "content-disposition",
                                  string.Format("attachment;  filename={0}", filename));
                        this.Response.BinaryWrite(excelPackage.GetAsByteArray());
                        this.Response.End();
                    }
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

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            GetInterviewResults();
        }

        protected void btn_Export_Click(object sender, EventArgs e)
        {
            lblResponseMsg.Text = "";
            WriteToSpreadsheet();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            lblResponseMsg.Text = "";
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            string strJavascript = "<script type='text/javascript'>window.open('Report2.aspx?employer_id=" + employer_id.Value + "&job_id=";
            strJavascript += job_id.Value + "&interview_id=" + interview_id.Value +"','_blank');</script>";
            Response.Write(strJavascript);
        }
    }
}