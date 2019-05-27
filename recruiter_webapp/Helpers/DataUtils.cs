using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using ExcelDataReader;

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
            }
            return validationMsg;
        }

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
    }
}