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

        public async Task<DataSet> GetJobDetails(int job_id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@job_id", job_id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_GetDetails", sqlParam));
        }

        // Method for list display with pagination 
        public async Task<DataSet> GetJobs(string employer_id, string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[6];
            sqlParam[0] = new SqlParameter("@employer_id", employer_id);
            sqlParam[1] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[2] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[3] = new SqlParameter("@PageSize", PageSize);
            sqlParam[4] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[5] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[5].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[5].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }

        public async Task<DataSet> GetJobList(int employer_id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@employer_id", employer_id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_GetListForEmployer", sqlParam));
        }

        // Method for displaying all job vacancies with pagination (For client queries)
        public async Task<DataSet> GetJobVacancies(int customer, int industry, int category, int skill, string job_code, int employer, int min_exp, int max_exp, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[11];
            sqlParam[0] = new SqlParameter("@customer", customer);
            sqlParam[1] = new SqlParameter("@industry", industry);
            sqlParam[2] = new SqlParameter("@category", category);
            sqlParam[3] = new SqlParameter("@skill", skill);
            sqlParam[4] = new SqlParameter("@job_code", job_code);
            sqlParam[5] = new SqlParameter("@employer", employer);
            sqlParam[6] = new SqlParameter("@min_exp", min_exp);
            sqlParam[7] = new SqlParameter("@max_exp", max_exp);
            sqlParam[8] = new SqlParameter("@PageSize", PageSize);
            sqlParam[9] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[10] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[10].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_GetVacancies3", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[10].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }

        public async Task<int> InsertJob(Dictionary<string, string> job)
        {
            // Skills and qualifications passed as json array (string) 
            // converted to datatable for passing to UDT in sql.
            // Int values delimited by ','.
            DataTable dtSkills = new DataTable();
            dtSkills.Columns.Add(new DataColumn("skill_id", typeof(int)));
            var array = job["job_skills"].Split(',');
            foreach (string str in array)
            {
                DataRow dr = dtSkills.NewRow();
                dr["skill_id"] = Convert.ToInt32(str);
                dtSkills.Rows.Add(dr);
            }

            DataTable dtQualifications = new DataTable();
            dtQualifications.Columns.Add(new DataColumn("qualification_id", typeof(int)));
            array = job["job_qualifications"].Split(',');
            foreach (string str in array)
            {
                DataRow dr = dtQualifications.NewRow();
                dr["qualification_id"] = Convert.ToInt32(str);
                dtQualifications.Rows.Add(dr);
            }

            SqlParameter[] sqlParam = new SqlParameter[19];
            sqlParam[0] = new SqlParameter("@job_code", job["job_code"]);
            sqlParam[1] = new SqlParameter("@description", job["description"]);
            sqlParam[2] = new SqlParameter("@industry", job["industry"]);
            sqlParam[3] = new SqlParameter("@category", job["category"]);
            sqlParam[4] = new SqlParameter("@employer_id", job["employer_id"]);
            sqlParam[5] = new SqlParameter("@location_id", job["location_id"]);                      
            sqlParam[6] = new SqlParameter("@vacancy_count", job["vacancy_count"]);
            sqlParam[7] = new SqlParameter("@other_notes", job["other_notes"]);
            sqlParam[8] = new SqlParameter("@min_exp", job["min_exp"]);
            sqlParam[9] = new SqlParameter("@max_exp", job["max_exp"]);
            sqlParam[10] = new SqlParameter("@skillList", dtSkills);
            sqlParam[10].SqlDbType = SqlDbType.Structured;
            sqlParam[11] = new SqlParameter("@qualificationList", dtQualifications);
            sqlParam[11].SqlDbType = SqlDbType.Structured;
            /*sqlParam[8] = new SqlParameter("@job_skills", job["job_skills"]);
            sqlParam[9] = new SqlParameter("@job_qualifications", job["job_qualifications"]);*/
            sqlParam[12] = new SqlParameter("@currency", job["currency"]);
            sqlParam[13] = new SqlParameter("@min_sal", job["min_sal"]);
            sqlParam[14] = new SqlParameter("@max_sal", job["max_sal"]);
            sqlParam[15] = new SqlParameter("@active", job["active"]);
            sqlParam[16] = new SqlParameter("@logged_in_userid", job["logged_in_userid"]);
            sqlParam[17] = new SqlParameter("@join_date", job["join_date"]);
            sqlParam[18] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[18].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspJobs_Add", sqlParam));
            return Convert.ToInt32(sqlParam[18].Value);
        }

        
        // Some fields not meant to be changed are disabled
        public async Task<int> EditJob(Dictionary<string, string> job)
        {
            DataTable dtSkills = new DataTable();
            dtSkills.Columns.Add(new DataColumn("skill_id", typeof(int)));
            var array = job["job_skills"].Split(',');
            foreach (string str in array)
            {
                DataRow dr = dtSkills.NewRow();
                dr["skill_id"] = Convert.ToInt32(str);
                dtSkills.Rows.Add(dr);
            }

            DataTable dtQualifications = new DataTable();
            dtQualifications.Columns.Add(new DataColumn("qualification_id", typeof(int)));
            array = job["job_qualifications"].Split(',');
            foreach (string str in array)
            {
                DataRow dr = dtQualifications.NewRow();
                dr["qualification_id"] = Convert.ToInt32(str);
                dtQualifications.Rows.Add(dr);
            }

            SqlParameter[] sqlParam = new SqlParameter[20];
            sqlParam[0] = new SqlParameter("@job_id", job["job_id"]);
            sqlParam[1] = new SqlParameter("@job_code", job["job_code"]);
            sqlParam[2] = new SqlParameter("@description", job["description"]);
            sqlParam[3] = new SqlParameter("@industry", job["industry"]);
            sqlParam[4] = new SqlParameter("@category", job["category"]);
            sqlParam[5] = new SqlParameter("@employer_id", job["employer_id"]);
            sqlParam[6] = new SqlParameter("@location_id", job["location_id"]);
            sqlParam[7] = new SqlParameter("@vacancy_count", job["vacancy_count"]);
            sqlParam[8] = new SqlParameter("@other_notes", job["other_notes"]);
            sqlParam[9] = new SqlParameter("@min_exp", job["min_exp"]);
            sqlParam[10] = new SqlParameter("@max_exp", job["max_exp"]);
            sqlParam[11] = new SqlParameter("@skillList", dtSkills);
            sqlParam[11].SqlDbType = SqlDbType.Structured;
            sqlParam[12] = new SqlParameter("@qualificationList", dtQualifications);
            sqlParam[12].SqlDbType = SqlDbType.Structured;
            sqlParam[13] = new SqlParameter("@currency", job["currency"]);
            sqlParam[14] = new SqlParameter("@min_sal", job["min_sal"]);
            sqlParam[15] = new SqlParameter("@max_sal", job["max_sal"]);
            sqlParam[16] = new SqlParameter("@active", job["active"]);
            sqlParam[17] = new SqlParameter("@logged_in_userid", job["logged_in_userid"]);
            sqlParam[18] = new SqlParameter("@join_date", job["join_date"]);
            sqlParam[19] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[19].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspJobs_Edit", sqlParam));
            return Convert.ToInt32(sqlParam[19].Value);
        }

        public async Task<DataSet> GetJobSkills(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@job_id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobSkills_Get", sqlParam));
        }

        public async Task<DataSet> GetJobQualifications(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@job_id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobQualifications_Get", sqlParam));
        }

        public async Task<DataSet> GetQualifiedCandidatesList(int job_id, string status)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@job_id", job_id.ToString());
            sqlParam[1] = new SqlParameter("@status", status);
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_GetQualifiedsList3", sqlParam));
        }

        public async Task<DataSet> GetQualifiedCandidatesList2(int job_id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@job_id", job_id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_GetQualifiedsList2", sqlParam));
        }

        public async Task<DataSet> GetSelectedCandidatesList(int interview_id)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@interview_id", interview_id.ToString());
            sqlParam[1] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[1].Direction = ParameterDirection.Output;
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_GetSelectedsList", sqlParam));
        }
        /*
        public async Task<DataSet> GetInterviewResults(int job_id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@job_id", job_id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_GetInterviewResults", sqlParam));
        }
        */
        public async Task<DataSet> GetInterviewList(int job_id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@job_id", job_id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJobs_GetInterviewList", sqlParam));
        }

        public async Task<int> InsertAppliedCandidate(Dictionary<string, string> job_candidate)
        {
            SqlParameter[] sqlParam = new SqlParameter[4];
            sqlParam[0] = new SqlParameter("@job_id", job_candidate["job_id"]);
            sqlParam[1] = new SqlParameter("@candidate_id", job_candidate["candidate_id"]);
            sqlParam[2] = new SqlParameter("@logged_in_userid", job_candidate["logged_in_userid"]);
            sqlParam[3] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[3].Direction = ParameterDirection.Output;
            await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspJob_Candidates_AddApplied", sqlParam));
            return Convert.ToInt32(sqlParam[3].Value);
        }

        public async Task<int> IsAppliedForJob(int job_id, int candidate_id)
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@job_id", job_id.ToString());
            sqlParam[1] = new SqlParameter("@candidate_id", candidate_id.ToString());
            sqlParam[2] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[2].Direction = ParameterDirection.Output;
            await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspJob_Candidates_IsApplied", sqlParam));
            return Convert.ToInt32(sqlParam[2].Value);
        }
    }
}