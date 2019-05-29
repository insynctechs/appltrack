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
        // New method to implement pagination
        public async Task<DataSet> GetQualifications(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {            
            SqlParameter[] sqlParam = new SqlParameter[5];
            sqlParam[0] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[2] = new SqlParameter("@PageSize", PageSize);
            sqlParam[3] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[4] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[4].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[4].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
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
            var ret = await Task.Run(() => (SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspQualifications_Add_FromFile", sqlParam)));
            return Convert.ToInt32(sqlParam[2].Value);
        }

        public async Task<DataSet> GetQualificationsDuplicates(int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Userid", userid);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspQualifications&Temp_Get", sqlParam));
        }
    }
}
