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
    public class Candidate
    {
        public async Task<DataSet> GetCandidates(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[5];
            sqlParam[0] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[2] = new SqlParameter("@PageSize", PageSize);
            sqlParam[3] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[4] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[4].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidates_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[4].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }

        public async Task<int> InsertCandidate(Dictionary<string, string> candidate)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("skill_id", typeof(int)));
            var array = candidate["skills"].Split(',');
            foreach(string str in array)
            {
                DataRow dr = dt.NewRow();
                dr["skill_id"] = Convert.ToInt32(str);
                dt.Rows.Add(dr);
            }

            /*
            DataTable dtQualification = new DataTable();
            Dictionary<string, Dictionary<string, string>> dictCandidateQualifications = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["qualifications"].ToString());
            dt.Columns.Add(new DataColumn("qualification", typeof(string)));
            dt.Columns.Add(new DataColumn("institute", typeof(string)));
            dt.Columns.Add(new DataColumn("year", typeof(int)));
            dt.Columns.Add(new DataColumn("percentage", typeof(int)));

            foreach (KeyValuePair<string, Dictionary<string, string>> i in dictCandidateQualifications)
            {
                DataRow dr = dtQualification.NewRow();
                foreach (KeyValuePair<string, string> j in (i.Value))
                {
                    dr[j.Key] = j.Value;
                }
                dtQualification.Rows.Add(dr);
            }
            /*
            DataTable dtExperience = new DataTable();
            Dictionary<string, Dictionary<string, string>> candidateExperiences = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["experiences"].ToString());
            dt.Columns.Add(new DataColumn("qualification", typeof(string)));
            dt.Columns.Add(new DataColumn("institute", typeof(string)));
            dt.Columns.Add(new DataColumn("year", typeof(int)));
            dt.Columns.Add(new DataColumn("percentage", typeof(int)));

            foreach (KeyValuePair<string, Dictionary<string, string>> i in dictCandidateQualifications)
            {
                foreach (KeyValuePair<string, string> j in (i.Value))
                {
                    DataRow dr = dt.NewRow();
                    dr[j.Key] = j.Value;      
                }
            }
            
            foreach (DataRow row in dtQualification.Rows)
            {
                File.AppendAllText("d:\\rows.txt", row[0].ToString() + row[1].ToString());
            }
            */



            SqlParameter[] sqlParam = new SqlParameter[15];
            sqlParam[0] = new SqlParameter("@user_id", candidate["user_id"]);
            sqlParam[1] = new SqlParameter("@name", candidate["name"]);
            sqlParam[2] = new SqlParameter("@gender", candidate["gender"]);
            sqlParam[3] = new SqlParameter("@dob", candidate["dob"]);
            sqlParam[4] = new SqlParameter("@address", candidate["address"]);
            sqlParam[5] = new SqlParameter("@email", candidate["email"]);
            sqlParam[6] = new SqlParameter("@phone", candidate["phone"]);
            sqlParam[7] = new SqlParameter("@others", candidate["others"]);
            sqlParam[8] = new SqlParameter("@SkillList", dt);
            sqlParam[8].SqlDbType = SqlDbType.Structured;
            sqlParam[9] = new SqlParameter("@active", candidate["active"]);
            sqlParam[10] = new SqlParameter("@password", candidate["password"]);
            sqlParam[11] = new SqlParameter("@ip_address", candidate["ip_address"]);
            sqlParam[12] = new SqlParameter("@notification", candidate["notification"]);
            sqlParam[13] = new SqlParameter("@user_type", candidate["user_type"]);
            /*
            sqlParam[17] = new SqlParameter("@qualificationList", DictionaryToDataTable(JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["qualifications"].ToString())));
            sqlParam[17].SqlDbType = SqlDbType.Structured;

            sqlParam[18] = new SqlParameter("@experienceList", DictionaryToDataTable(JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["experiences"].ToString())));
            sqlParam[18].SqlDbType = SqlDbType.Structured;
            */
            sqlParam[14] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[14].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCandidates_Add3", sqlParam));

            //return Convert.ToInt32(sqlParam[17].Value);

            // The return value is id of candidate.
            if (Convert.ToInt32(sqlParam[14].Value) >= 0)
            {
                Dictionary<string, Dictionary<string, string>> candidateQualifications = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["qualifications"].ToString());
                Boolean ret_of_qual = await InsertCandidateQualifications(Convert.ToInt32(sqlParam[14].Value), candidateQualifications);
                Dictionary<string, Dictionary<string, string>> candidateExperiences = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["experiences"].ToString());
                Boolean ret_of_exp = await InsertCandidateExperiences(Convert.ToInt32(sqlParam[14].Value), candidateExperiences);
                if (ret_of_qual && ret_of_exp)
                    return (Convert.ToInt32(sqlParam[14].Value));
            }
            return -1;
        }

        public async Task<int> EditCandidate(Dictionary<string, string> candidate)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("skill_id", typeof(int)));
            var array = candidate["skills"].Split(',');
            foreach (string str in array)
            {
                DataRow dr = dt.NewRow();
                dr["skill_id"] = Convert.ToInt32(str);
                dt.Rows.Add(dr);
            }


            SqlParameter[] sqlParam = new SqlParameter[15];
            sqlParam[0] = new SqlParameter("@user_id", candidate["user_id"]);
            sqlParam[1] = new SqlParameter("@name", candidate["name"]);
            sqlParam[2] = new SqlParameter("@gender", candidate["gender"]);
            sqlParam[3] = new SqlParameter("@dob", candidate["dob"]);
            //sqlParam[3].SqlDbType = SqlDbType.Date;
            sqlParam[4] = new SqlParameter("@address", candidate["address"]);
            sqlParam[5] = new SqlParameter("@email", candidate["email"]);
            sqlParam[6] = new SqlParameter("@phone", candidate["phone"]);
            sqlParam[7] = new SqlParameter("@others", candidate["others"]);
            sqlParam[8] = new SqlParameter("@SkillList", dt);
            sqlParam[8].SqlDbType = SqlDbType.Structured;
            sqlParam[9] = new SqlParameter("@active", candidate["active"]);
            sqlParam[10] = new SqlParameter("@ip_address", candidate["ip_address"]);
            sqlParam[11] = new SqlParameter("@notification", candidate["notification"]);
            sqlParam[12] = new SqlParameter("@user_type", candidate["user_type"]);
            sqlParam[13] = new SqlParameter("@id", candidate["id"]);

            sqlParam[14] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[14].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCandidates_Edit", sqlParam));
            //return Convert.ToInt32(sqlParam[17].Value);
            // The return value is id of candidate.
            if (Convert.ToInt32(sqlParam[14].Value) >= 0)
            {
                Dictionary<string, Dictionary<string, string>> candidateQualifications = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["qualifications"].ToString());
                Boolean ret_of_qual = await InsertCandidateQualifications(Convert.ToInt32(sqlParam[14].Value), candidateQualifications);
                Dictionary<string, Dictionary<string, string>> candidateExperiences = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["experiences"].ToString());
                Boolean ret_of_exp = await InsertCandidateExperiences(Convert.ToInt32(sqlParam[14].Value), candidateExperiences);
                if (ret_of_qual && ret_of_exp)
                {
                    return (Convert.ToInt32(sqlParam[14].Value));
                }
            }
            return -1;
        }


        public async Task<Boolean> InsertCandidateQualifications(int candidate_id, Dictionary<string, Dictionary<string, string>> candidateQualifications)
        {
            int ret = 0;
            foreach (KeyValuePair<string, Dictionary<string, string>> i in candidateQualifications)
            {
                SqlParameter[] sqlParam = new SqlParameter[5];
                sqlParam[0] = new SqlParameter("@candidate_id", candidate_id.ToString());
                int count = 0;
                foreach (KeyValuePair<string, string> j in (i.Value))
                {
                    sqlParam[count+=1] = new SqlParameter("@"+j.Key, j.Value);
                }
                ret += await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCandidate_Qualifications_Add2", sqlParam));
            }
            if (ret == candidateQualifications.Count)
                return true;
            return false;
        }

        public async Task<Boolean> InsertCandidateExperiences(int candidate_id, Dictionary<string, Dictionary<string, string>> candidateExperiences)
        {
            int ret = 0;
            foreach (KeyValuePair<string, Dictionary<string, string>> i in candidateExperiences)
            {
                SqlParameter[] sqlParam = new SqlParameter[7];
                sqlParam[0] = new SqlParameter("@candidate_id", candidate_id.ToString());
                int count = 0;
                foreach (KeyValuePair<string, string> j in (i.Value))
                {
                    sqlParam[count += 1] = new SqlParameter("@" + j.Key, j.Value);
                }
                ret += await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCandidate_Experiences_Add2", sqlParam));
            }
            if (ret == candidateExperiences.Count)
                return true;
            return false;
        }

        /*
        // Helper method to convert Dictionary to Datatable
        public static DataTable DictionaryToDataTable(Dictionary<string, Dictionary<string, string>> dictionary)
        {
            int index;
            string key = "YourPrimaryKeyColumnNameHere";
            DataTable dt = new DataTable();

            dt.Columns.Add(key);
            dt.PrimaryKey = new DataColumn[] { dt.Columns[key] };

            foreach (var header in dictionary)
            {
                dt.Columns.Add(header.Key);
                foreach (var row in header.Value)
                {
                    index = dt.Rows.IndexOf(dt.Rows.Find(row.Key));

                    if (index < 0)
                    {
                        dt.Rows.Add(new[] { row.Key });
                        dt.Rows[dt.Rows.Count - 1][header.Key] = row.Value;
                    }
                    else
                    {
                        dt.Rows[index][header.Key] = row.Value;
                    }
                }
            }
            return dt;
        }
        */

        public async Task<DataSet> GetCandidate(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@candidate_id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidates_GetSingle", sqlParam));
        }

        public async Task<DataSet> GetCandidateSkills(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@candidate_id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidateSkills_Get", sqlParam));
        }

        public async Task<DataSet> GetCandidateQualifications(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@candidate_id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidateQualifications_Get", sqlParam));
        }

        public async Task<DataSet> GetCandidateExperiences(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@candidate_id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidateExperiences_Get", sqlParam));
        }

        public async Task<DataSet> GetCandidateDocuments(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[6];
            sqlParam[0] = new SqlParameter("@candidate_id", id);
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidateDocuments_GetAll", sqlParam));
            return ds;
        }

        public async Task<int> DeleteDocument(string file)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@filename", file);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspCandidateDocuments_Delete", sqlParam)));
        }

        public async Task<int> DeleteCandidate(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspCandidates_Delete", sqlParam)));
        }
    }
}