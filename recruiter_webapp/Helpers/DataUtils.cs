using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using ExcelDataReader;
using System.Net;
using System.Net.Mail;
using System.Configuration;
using System.Threading.Tasks;

namespace recruiter_webapp.Helpers
{
    public class DataUtils
    {
        // To perform validations on Excel files (.xls and .xlxs) for all models
        public string ValidateExcelFile(string filepath, int userid, Object modelType)
        {
            string validationMsg = "";

            FileStream stream = File.Open(filepath, FileMode.Open, FileAccess.Read);
            IExcelDataReader excelReader;

            // Reading Excel file
            if (Path.GetExtension(filepath).ToLower() == ".xls")
            {
                // Reading from a binary Excel file ('97-2003 format; *.xls)
                excelReader = ExcelReaderFactory.CreateBinaryReader(stream);
            }
            else
            {
                // Reading from a OpenXml Excel file (2007 format; *.xlsx)
                excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
            }

            // DataSet - The result of each spreadsheet will be created in the result.Tables
            //DataSet result = excelReader.AsDataSet();
            // DataSet - Create column names from first row
            //excelReader.IsFirstRowAsColumnNames = true; // deprecated property

            var conf = new ExcelDataSetConfiguration
            {
                ConfigureDataTable = _ => new ExcelDataTableConfiguration
                {
                    UseHeaderRow = true
                }
            };
            // DataSet - The result of each spreadsheet will be created in the result.Tables
            DataSet ds = excelReader.AsDataSet(conf);
            DataTable dt = ds.Tables[0];

            //Console.WriteLine(dt.Rows[rowPosition][columnPosition]);
            excelReader.Close();

            switch (modelType.ToString())
            {
                case "Skill":
                    validationMsg = validateSkillsDataTable(dt, userid);
                    break;
                case "Qualification":
                    validationMsg = validateQualificationsDataTable(dt, userid);
                    break;
            }
            return validationMsg;
        }

        // To validate rows, columns in uploaded file on Skill Template
        public string validateSkillsDataTable(DataTable dt, int userid)
        {
            string validationMsg = "";
            for (int row = 1, col = 0; row < dt.Rows.Count; row++)
            {
                if (String.IsNullOrEmpty((dt.Rows[row][col]).ToString()))
                {
                    validationMsg = "Empty field in Column:" + col + ", Row:" + (row + 1);
                    return validationMsg;
                }
            }
            try
            {
                var url = string.Format("api/Skills/Insert/Upload");
                string res = new WebApiHelper().PostExecuteNonQueryResFromWebApi(url, userid, dt);
                validationMsg = res;
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return validationMsg;
        }

        // To validate rows, columns in uploaded file on Qualification Template
        public string validateQualificationsDataTable(DataTable dt, int userid)
        {
            string validationMsg = "";
            for (int row = 1, col = 0; row < dt.Rows.Count; row++)
            {
                if (String.IsNullOrEmpty((dt.Rows[row][col]).ToString()))
                {
                    validationMsg = "Empty field in Column: " + col + ", Row: " + (row + 1);
                    return validationMsg;
                }
            }
            try
            {
                var url = string.Format("api/Qualifications/Insert/Upload");
                string res = new WebApiHelper().PostExecuteNonQueryResFromWebApi(url, userid, dt);
                validationMsg = res;
            }
            catch (Exception ex)
            {
                CommonLogger.Info(ex.ToString());
            }
            return validationMsg;
        }

        public void SendEmail(string name, string email, string password, Constants.EmailTypes emailType)
        {

                //Fetching Settings from WEB.CONFIG file.  
                string emailSender = ConfigurationManager.AppSettings["UserName"].ToString();
                string emailSenderPassword = ConfigurationManager.AppSettings["Password"].ToString();
                string emailSenderHost = ConfigurationManager.AppSettings["Host"].ToString();
                int emailSenderPort = Convert.ToInt16(ConfigurationManager.AppSettings["Port"]);
                Boolean emailIsSSL = Convert.ToBoolean(ConfigurationManager.AppSettings["EnableSsl"]);


                //Fetching Email Body Text from EmailTemplate File.
                string MailText = "";
                string subject = "";

                // Fetching email contents w.r.t predefined email types
                if (emailType == Constants.EmailTypes.NewUser)
                {
                    string FilePath = HttpContext.Current.Server.MapPath(Constants.emailTemplates) + "NewUser.html";
                    StreamReader str = new StreamReader(FilePath);
                    MailText = str.ReadToEnd();
                    str.Close();

                    //Replacing the html for [newusername] and [newpassword] with actual values.
                    MailText = MailText.Replace("[name]", name);
                    MailText = MailText.Replace("[newusername]", email);
                    MailText = MailText.Replace("[newpassword]", password);

                    subject = "Welcome to InsyncTalentBox";
                }

                //Base class for sending email  
                MailMessage _mailmsg = new MailMessage();

                //Make TRUE because our body text is html  
                _mailmsg.IsBodyHtml = true;

                //Set From Email ID  
                _mailmsg.From = new MailAddress(emailSender);

                //Set To Email ID  
                _mailmsg.To.Add(email);

                //Set Subject  
                _mailmsg.Subject = subject;

                //Set Body Text of Email   
                _mailmsg.Body = MailText;


                //Now set your SMTP   
                SmtpClient _smtp = new SmtpClient();

                //Object state = _mailmsg;

                //Set HOST server SMTP detail  
                _smtp.Host = emailSenderHost;

                //Set PORT number of SMTP  
                _smtp.Port = emailSenderPort;

                //Set SSL --> True / False  
                _smtp.EnableSsl = emailIsSSL;

                //Set Sender UserEmailID, Password  
                NetworkCredential _network = new NetworkCredential(emailSender, emailSenderPassword);
                _smtp.Credentials = _network;

                //Send Method will send your MailMessage create above.  
                //_smtp.Send(_mailmsg);

                //_smtp.SendCompleted += new SendCompletedEventHandler(smtpClient_SendCompleted);
                try
                {
                    _smtp.Send(_mailmsg);
                }
                catch (Exception ex)
                {
                    CommonLogger.Info(ex.ToString() + " while sending mail to " + email + " at " + DateTime.Now);
                }
  
        }

        public void smtpClient_SendCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
        {
            MailMessage mail = e.UserState as MailMessage;

            if (!e.Cancelled && e.Error != null)
            {
                File.WriteAllText(HttpContext.Current.Server.MapPath(Constants.uploadsDir)+"mailstatus.txt", "Mail sent successfully at " + DateTime.Now + "\r\n");
            }
        }
    }
}