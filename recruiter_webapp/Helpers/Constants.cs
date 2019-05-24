using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace recruiter_webapp.Helpers
{
    public class Constants
    {
        public static string uploadsDir = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData)+"/insyncTalentBox/Uploads/";
        public const int MAX_UPLOAD_SIZE = 1048576;

        // Constants for data validation against model structure (Used in DataUtils.cs for template validation)
        public enum ModelTypes {Customer, Employer, Candidate, Job, Skill, Qualification}

        // Error Messages
        public const String ERR_NO_FILE = "Please select a file.";
        public const String ERR_FILE_SIZE = "Filesize exceeds maximum limit 1MB.";
        public const String ERR_UNSUPPORTED_DATAFILE = "Only .xls, .xlsx, .csv files supported.";
        public const String ERR_CORRUPTED_FILE = "Uploaded file is corrupted!";
        public const String ERR_RECORD_EXIST = "Record already exist!";
        public const String ERR_DB_OPERATION = "Error executing database operation.";
        public const String ERR_UPDATE = "Record updation failed!";
        

        // Success Messages
        public const String SUCCESS_INSERT = "Record inserted successfully.";
        public const String SUCCESS_DELETE = "Record deleted successfully.";
        public const String SUCCESS_UPDATE = "Record updated successfully.";
        public const String SUCCESS_INSERTS_COUNT = " Records inserted."; 

        // Colors for file upload messages
        public static System.Drawing.Color successColor = System.Drawing.Color.LimeGreen;
        public static System.Drawing.Color failureColor = System.Drawing.Color.Firebrick;
    }
}