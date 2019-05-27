using Microsoft.ApplicationBlocks.Data;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System;
using System.IO;

namespace recruiter_core.Models
{
    public class Qualification
    {
        public async Task<DataSet> GetQualifications(string srchBy, string srchVal)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@SearchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SearchValue", srchVal);
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_Get", sqlParam));
        }

        public async Task<DataSet> GetQualification(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_GetSingle", sqlParam));
        }


        #region "Insert Qualification"
        public async Task<int> InsertQualification(Dictionary<string, string> qualification)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@title", qualification["title"]);
            sqlParam[1] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[1].Direction = ParameterDirection.Output;
            await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_Add", sqlParam));
            return Convert.ToInt32(sqlParam[1].Value);
        }
        #endregion

        public async Task<int> EditQualification(Dictionary<string, string> qualification)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@id", qualification["id"]);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            sqlParam[1] = new SqlParameter("@title", qualification["title"]);
            return await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_Edit", sqlParam));
        }

        public async Task<int> DeleteQualifications(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_Delete", sqlParam)));
        }

        // Procedure to add records to Qualifications table through datatable.
        public async Task<int> InsertQualifications(DataTable dtQualifications, int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@List", dtQualifications);
            sqlParam[0].SqlDbType = SqlDbType.Structured;
            sqlParam[1] = new SqlParameter("@Userid", userid);
            sqlParam[1].SqlDbType = SqlDbType.Int;
            sqlParam[2] = new SqlParameter("@RowsInserted", SqlDbType.Int);
            sqlParam[2].Direction = ParameterDirection.Output;
            var ret = await Task.Run(() => (SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_UDT_Add", sqlParam)));
            return Convert.ToInt32(sqlParam[2].Value);
        }

        public async Task<DataSet> GetQualificationsDuplicates(int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Userid", userid);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspTemp_Qualifications_Get", sqlParam));
        }
    }
}
