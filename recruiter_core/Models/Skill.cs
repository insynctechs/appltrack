using Microsoft.ApplicationBlocks.Data;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System;
using System.IO;

namespace recruiter_core.Models
{
    public class Skill
    {
        public async Task<DataSet> GetSkills(string srchBy, string srchVal)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@SearchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SearchValue", srchVal);
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspSkills_Get", sqlParam));
        }

        public async Task<DataSet> GetSkill(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspSkills_GetSingle", sqlParam));
        }


        #region "Insert Skill"
        public async Task<int> InsertSkill(Dictionary<string, string> skill)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@title", skill["title"]);
            sqlParam[1] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[1].Direction = ParameterDirection.Output;

            // sqlParam[1] = new SqlParameter("@RETURNVALUE", SqlDbType.Int);
            //sqlParam[1].Direction = ParameterDirection.Output;
            //sqlParam[1].Size = 10;
            await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspSkills_Add", sqlParam));
            return Convert.ToInt32(sqlParam[1].Value);
        }
        #endregion

        public async Task<int> EditSkill(Dictionary<string, string> skill)
        {
            File.WriteAllText("D:\\Skill_edit.txt", "called");
            SqlParameter[] sqlParam = new SqlParameter[2];           
            sqlParam[0] = new SqlParameter("@id", skill["id"]);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            sqlParam[1] = new SqlParameter("@title", skill["title"]);
            File.WriteAllText("D:\\editSkills.txt", "id is "+ skill["id"].ToString()+ " and title is "+ skill["title"]);
            return await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspSkills_Edit", sqlParam));
        }

        /*
        // New Insert Skill
        public async Task<int> InsertSkill(jobj)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@title", title);
            // sqlParam[1] = new SqlParameter("@RETURNVALUE", SqlDbType.Int);
            //sqlParam[1].Direction = ParameterDirection.Output;
            //sqlParam[1].Size = 10;
            return await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspSkills_Add", sqlParam));
            //return Int32.Parse(sqlParam[1].Value.ToString());
        }
        */

        public async Task<int> DeleteSkills(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspSkills_Delete", sqlParam)));
        }

        // Procedure to add records to Skills table through datatable.
        public async Task<int> InsertSkills(DataTable dtSkills, int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@List", dtSkills);
            sqlParam[0].SqlDbType = SqlDbType.Structured;
            sqlParam[1] = new SqlParameter("@Userid", userid);
            sqlParam[1].SqlDbType = SqlDbType.Int;
            sqlParam[2] = new SqlParameter("@RowsInserted", SqlDbType.Int);
            sqlParam[2].Direction = ParameterDirection.Output;
            var ret = await Task.Run(() => (SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspSkills_UDT_Add5", sqlParam)));           
            return Convert.ToInt32(sqlParam[2].Value);
        }

        public async Task<DataSet> GetSkillsDuplicates(int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Userid", userid);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspTemp_Skills_Get", sqlParam));
        }
    }
}