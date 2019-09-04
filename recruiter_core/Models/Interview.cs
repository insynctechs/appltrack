using Microsoft.ApplicationBlocks.Data;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System;
using System.IO;
using recruiter_core.Helpers;
using Newtonsoft.Json;

namespace recruiter_core.Models
{
    public class Interview
    {
        public async Task<DataSet> GetInterview(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspInterviews_GetSingle", sqlParam));
        }

        public async Task<DataSet> GetInterviewList(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@job_id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspInterviews_GetList", sqlParam));
        }

        // Method for list display with pagination 
        public async Task<DataSet> GetInterviews(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[5];

            sqlParam[0] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[2] = new SqlParameter("@PageSize", PageSize);
            sqlParam[3] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[4] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[4].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspInterviews_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[4].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }

        public async Task<int> InsertInterview(Dictionary<string, string> interview)
        {
            SqlParameter[] sqlParam = new SqlParameter[9];
            sqlParam[0] = new SqlParameter("@job_id", interview["job_id"]);
            sqlParam[1] = new SqlParameter("@title", interview["title"]);
            sqlParam[2] = new SqlParameter("@description", interview["description"]);
            sqlParam[3] = new SqlParameter("@round", interview["round"]);
            sqlParam[4] = new SqlParameter("@venue", interview["venue"]);
            sqlParam[5] = new SqlParameter("@date_of_interview", interview["date_of_interview"]);
            sqlParam[5].SqlDbType = SqlDbType.Date;
            sqlParam[6] = new SqlParameter("@active", interview["active"]);
            sqlParam[7] = new SqlParameter("@logged_in_user_id", interview["logged_in_userid"]);
            sqlParam[8] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[8].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspInterviews_Add", sqlParam));
            return Convert.ToInt32(sqlParam[8].Value);
        }


        // Some fields not meant to be changed are disabled
        public async Task<int> EditInterview(Dictionary<string, string> interview)
        {
            SqlParameter[] sqlParam = new SqlParameter[10];
            sqlParam[0] = new SqlParameter("@id", interview["id"]);
            sqlParam[1] = new SqlParameter("@job_id", interview["job_id"]);
            sqlParam[2] = new SqlParameter("@title", interview["title"]);
            sqlParam[3] = new SqlParameter("@description", interview["description"]);
            sqlParam[4] = new SqlParameter("@round", interview["round"]);
            sqlParam[5] = new SqlParameter("@venue", interview["venue"]);
            sqlParam[6] = new SqlParameter("@date_of_interview", interview["date_of_interview"]);
            sqlParam[6].SqlDbType = SqlDbType.Date;
            sqlParam[7] = new SqlParameter("@active", interview["active"]);
            sqlParam[8] = new SqlParameter("@logged_in_user_id", interview["logged_in_userid"]);
            sqlParam[9] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[9].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspInterviews_Edit", sqlParam));
            return Convert.ToInt32(sqlParam[9].Value);
        }

        public async Task<int> DeleteInterview(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspInterviews_Delete", sqlParam)));
        }

        public async Task<int> SetInterviewForCandidates(Dictionary<string, string> interview_candidates)
        {
            DataTable dtCandidates = new DataTable();
            dtCandidates.Columns.Add(new DataColumn("candidate_id", typeof(int)));
            var array = interview_candidates["selected_candidates"].Split(',');
            foreach (string str in array)
            {
                DataRow dr = dtCandidates.NewRow();
                dr["candidate_id"] = Convert.ToInt32(str);
                dtCandidates.Rows.Add(dr);
            }

            SqlParameter[] sqlParam = new SqlParameter[5];
            sqlParam[0] = new SqlParameter("@interview_id", interview_candidates["interview_id"]);
            sqlParam[1] = new SqlParameter("@candidateList", dtCandidates);
            sqlParam[1].SqlDbType = SqlDbType.Structured;
            sqlParam[2] = new SqlParameter("@status", interview_candidates["status"]);
            sqlParam[3] = new SqlParameter("@logged_in_user_id", interview_candidates["logged_in_user_id"]);
            sqlParam[4] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[4].Direction = ParameterDirection.Output;

            if(Convert.ToInt32(interview_candidates["status"])==Constants.notifyToApply)
            {
                var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspJob_Candidates_AddNotified", sqlParam));
            }
            else
            {
                var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspInterview_Candidates_SetInterview", sqlParam));
            }
            return Convert.ToInt32(sqlParam[4].Value);
        }

        public async Task<int> UpdateCandidatesForInterview(Dictionary<string, string> interview_candidates)
        {
            Dictionary<string, Dictionary<string, string>> candidates = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(interview_candidates["candidatesDetails"].ToString());
            
            DataTable dtCandidates = new DataTable();
            dtCandidates.Columns.Add(new DataColumn("candidate_id", typeof(int)));
            dtCandidates.Columns.Add(new DataColumn("score", typeof(int)));
            dtCandidates.Columns.Add(new DataColumn("rating", typeof(int)));
            dtCandidates.Columns.Add(new DataColumn("employer_comments", typeof(string)));
            foreach (KeyValuePair<string, Dictionary<string, string>> i in candidates)
            {
                int k = 0;
                DataRow dr = dtCandidates.NewRow();
                foreach (KeyValuePair<string, string> j in i.Value)
                {
                    dr[j.Key] = j.Value;
                }
                dtCandidates.Rows.Add(dr);
            }

            SqlParameter[] sqlParam = new SqlParameter[5];
            sqlParam[0] = new SqlParameter("@interview_id", interview_candidates["interview_id"]);
            sqlParam[1] = new SqlParameter("@candidateList", dtCandidates);
            sqlParam[1].SqlDbType = SqlDbType.Structured;
            sqlParam[2] = new SqlParameter("@status", interview_candidates["status"]);
            sqlParam[3] = new SqlParameter("@logged_in_user_id", 1);
            sqlParam[4] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[4].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspInterview_Candidates_UpdateCandidates", sqlParam));
            return Convert.ToInt32(sqlParam[4].Value);
        }

    }
}