using Microsoft.ApplicationBlocks.Data;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System;
using System.IO;
using recruiter_core.Helpers;

namespace recruiter_core.Models
{
    public class Job
    {
        public async Task<DataSet> GetJob(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_GetSingle", sqlParam));
        }

        // Method for list display with pagination 
        public async Task<DataSet> GetJobs(string employer_id, string location_id, string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[7];
            sqlParam[0] = new SqlParameter("@employer_id", employer_id);
            sqlParam[1] = new SqlParameter("@location_id", location_id);
            sqlParam[2] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[3] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[4] = new SqlParameter("@PageSize", PageSize);
            sqlParam[5] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[6] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[6].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[6].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }
        
        public async Task<int> InsertJob(Dictionary<string, string> job)
        {           
            SqlParameter[] sqlParam = new SqlParameter[17];
            sqlParam[0] = new SqlParameter("@job_code", job["job_code"]);
            sqlParam[1] = new SqlParameter("@description", job["description"]);
            sqlParam[2] = new SqlParameter("@employer_id", job["employer_id"]);
            sqlParam[3] = new SqlParameter("@location_id", job["location_id"]);                      
            sqlParam[4] = new SqlParameter("@vacancy_count", job["vacancy_count"]);
            sqlParam[5] = new SqlParameter("@other_notes", job["other_notes"]);
            sqlParam[6] = new SqlParameter("@min_exp", job["min_exp"]);
            sqlParam[7] = new SqlParameter("@max_exp", job["max_exp"]);
            sqlParam[8] = new SqlParameter("@job_skills", job["job_skills"]);
            sqlParam[9] = new SqlParameter("@job_qualifications", job["job_qualifications"]);
            sqlParam[10] = new SqlParameter("@currency", job["currency"]);
            sqlParam[11] = new SqlParameter("@min_sal", job["min_sal"]);
            sqlParam[12] = new SqlParameter("@max_sal", job["max_sal"]);
            sqlParam[13] = new SqlParameter("@active", job["active"]);
            sqlParam[14] = new SqlParameter("@logged_in_userid", job["logged_in_userid"]);
            sqlParam[15] = new SqlParameter("@join_date", job["join_date"]);
            sqlParam[16] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[16].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspJobs_Add", sqlParam));
            return Convert.ToInt32(sqlParam[16].Value);
        }

        
        // Some fields not meant to be changed are disabled
        public async Task<int> EditJob(Dictionary<string, string> job)
        {
            SqlParameter[] sqlParam = new SqlParameter[18];
            sqlParam[0] = new SqlParameter("@job_id", job["job_id"]);
            sqlParam[1] = new SqlParameter("@job_code", job["job_code"]);
            sqlParam[2] = new SqlParameter("@description", job["description"]);
            sqlParam[3] = new SqlParameter("@employer_id", job["employer_id"]);
            sqlParam[4] = new SqlParameter("@location_id", job["location_id"]);
            sqlParam[5] = new SqlParameter("@vacancy_count", job["vacancy_count"]);
            sqlParam[6] = new SqlParameter("@other_notes", job["other_notes"]);
            sqlParam[7] = new SqlParameter("@min_exp", job["min_exp"]);
            sqlParam[8] = new SqlParameter("@max_exp", job["max_exp"]);
            sqlParam[9] = new SqlParameter("@job_skills", job["job_skills"]);
            sqlParam[10] = new SqlParameter("@job_qualifications", job["job_qualifications"]);
            sqlParam[11] = new SqlParameter("@currency", job["currency"]);
            sqlParam[12] = new SqlParameter("@min_sal", job["min_sal"]);
            sqlParam[13] = new SqlParameter("@max_sal", job["max_sal"]);
            sqlParam[14] = new SqlParameter("@active", job["active"]);
            sqlParam[15] = new SqlParameter("@logged_in_userid", job["logged_in_userid"]);
            sqlParam[16] = new SqlParameter("@join_date", job["join_date"]);
            sqlParam[17] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[17].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspJobs_Edit", sqlParam));
            return Convert.ToInt32(sqlParam[17].Value);
        }
        
        
    }
}