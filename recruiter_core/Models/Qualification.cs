using Microsoft.ApplicationBlocks.Data;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System;

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
        public async Task<int> InsertQualification(string title)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@title", title);
            // sqlParam[1] = new SqlParameter("@RETURNVALUE", SqlDbType.Int);
            //sqlParam[1].Direction = ParameterDirection.Output;
            //sqlParam[1].Size = 10;
            return await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_Add", sqlParam));
            //return Int32.Parse(sqlParam[1].Value.ToString());
        }
        #endregion

        public async Task<int> DeleteQualifications(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_Delete", sqlParam)));
        }

        // Procedure to add records to Skills table through datatable.
        public async Task<int> InsertQualifications(DataTable dtQualifications)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@List", dtQualifications);
            sqlParam[0].SqlDbType = SqlDbType.Structured;
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_UDT_Add", sqlParam)));
        }
    }
}
