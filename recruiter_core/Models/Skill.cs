using Microsoft.ApplicationBlocks.Data;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System;

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
        public async Task<int> InsertSkill(string title)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@title", title);
            // sqlParam[1] = new SqlParameter("@RETURNVALUE", SqlDbType.Int);
            //sqlParam[1].Direction = ParameterDirection.Output;
            //sqlParam[1].Size = 10;
            return await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspSkills_Add", sqlParam));
            //return Int32.Parse(sqlParam[1].Value.ToString());
        }
        #endregion
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
        public async Task<int> InsertSkills(DataTable dtSkills)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@List", dtSkills);
            sqlParam[0].SqlDbType = SqlDbType.Structured;
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspSkills_UDT_Add2", sqlParam)));
            
        }
    }
}