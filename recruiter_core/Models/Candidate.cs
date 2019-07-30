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
        public async Task<DataSet> GetCandidates(string srchBy, string srchVal)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@SearchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SearchValue", srchVal);
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidates_Get", sqlParam));
        }

        public async Task<int> InsertCandidate(Dictionary<string, string> candidate)
        {
            int ret = 0;
            string password = Utils.GeneratePassword();
            //File.AppendAllText("d:\\CandidateLogins.txt", "Email: " + candidate["email"] + "\r\nPassword: " + password + "\r\n\r\n");

            SqlParameter[] sqlParam = new SqlParameter[18];
            sqlParam[0] = new SqlParameter("@user_id", candidate["user_id"]);
            sqlParam[1] = new SqlParameter("@name", candidate["name"]);
            sqlParam[2] = new SqlParameter("@gender", candidate["gender"]);
            sqlParam[3] = new SqlParameter("@dob", candidate["dob"]);
            sqlParam[4] = new SqlParameter("@address", candidate["address"]);
            sqlParam[5] = new SqlParameter("@email", candidate["email"]);
            sqlParam[6] = new SqlParameter("@phone", candidate["phone"]);
            sqlParam[7] = new SqlParameter("@others", candidate["others"]);
            sqlParam[8] = new SqlParameter("@skills", candidate["skills"]);
            sqlParam[9] = new SqlParameter("@status", candidate["status"]);
            sqlParam[10] = new SqlParameter("@rating", candidate["rating"]);
            sqlParam[11] = new SqlParameter("@employer_comments", candidate["employer_comments"]);
            sqlParam[12] = new SqlParameter("@active", candidate["active"]);
            sqlParam[13] = new SqlParameter("@password", password);
            sqlParam[14] = new SqlParameter("@ip_address", candidate["ip_address"]);
            sqlParam[15] = new SqlParameter("@notification", candidate["notification"]);
            sqlParam[16] = new SqlParameter("@user_type", candidate["user_type"]);
            /*
            sqlParam[17] = new SqlParameter("@qualificationList", DictionaryToDataTable(JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["qualifications"].ToString())));
            sqlParam[17].SqlDbType = SqlDbType.Structured;

            sqlParam[18] = new SqlParameter("@experienceList", DictionaryToDataTable(JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["experiences"].ToString())));
            sqlParam[18].SqlDbType = SqlDbType.Structured;
            */
            sqlParam[17] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[17].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCandidates_Add2", sqlParam));
            File.WriteAllText("d:\\sqlretofcandins.txt", sqlret.ToString());
            File.WriteAllText("d:\\retofcandins.txt", sqlParam[17].Value.ToString());
            //return Convert.ToInt32(sqlParam[17].Value);

            // The return value is id of candidate.
            if (Convert.ToInt32(sqlParam[17].Value) >= 0)
            {
                Dictionary<string, Dictionary<string, string>> candidateQualifications = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["qualifications"].ToString());
                Boolean ret_of_qual = await InsertCandidateQualifications(ret, candidateQualifications);
                Dictionary<string, Dictionary<string, string>> candidateExperiences = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, string>>>(candidate["experiences"].ToString());
                Boolean ret_of_exp = await InsertCandidateExperiences(ret, candidateExperiences);
                if (ret_of_qual && ret_of_exp)
                    return (Convert.ToInt32(sqlParam[17].Value));
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
    }
}