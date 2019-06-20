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
    public class Employer
    {
        // New method to implement pagination
        public async Task<DataSet> GetEmployers(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[5];
            sqlParam[0] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[2] = new SqlParameter("@PageSize", PageSize);
            sqlParam[3] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[4] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[4].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployers_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[4].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }

        public async Task<DataSet> GetEmployer(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployers_GetSingle", sqlParam));
        }

        public async Task<DataSet> GetFormData(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployers_GetFormData", sqlParam));
        }
       
        public async Task<DataSet> GetEmployerList()
        {
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployers_GetList"));
        }

        // To insert employer using form data
        public async Task<int> InsertEmployer(Dictionary<string, string> employer)
        {
            SqlParameter[] sqlParam = new SqlParameter[9];
            sqlParam[0] = new SqlParameter("@name", employer["name"]);
            sqlParam[1] = new SqlParameter("@address", employer["address"]);
            sqlParam[2] = new SqlParameter("@city", employer["city"]);
            sqlParam[3] = new SqlParameter("@state", employer["state"]);
            sqlParam[4] = new SqlParameter("@zip", employer["zip"]);
            sqlParam[5] = new SqlParameter("@email", employer["email"]);
            sqlParam[6] = new SqlParameter("@phone", employer["phone"]);
            sqlParam[7] = new SqlParameter("@active", employer["active"]);
            sqlParam[8] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[8].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspEmployers_Add", sqlParam));
            return Convert.ToInt32(sqlParam[8].Value);
        }

        public async Task<int> EditEmployer(Dictionary<string, string> employer)
        {
            SqlParameter[] sqlParam = new SqlParameter[10];
            sqlParam[0] = new SqlParameter("@id", employer["id"]);
            sqlParam[1] = new SqlParameter("@name", employer["name"]);
            sqlParam[2] = new SqlParameter("@address", employer["address"]);
            sqlParam[3] = new SqlParameter("@city", employer["city"]);
            sqlParam[4] = new SqlParameter("@state", employer["state"]);
            sqlParam[5] = new SqlParameter("@zip", employer["zip"]);
            sqlParam[6] = new SqlParameter("@email", employer["email"]);
            sqlParam[7] = new SqlParameter("@phone", employer["phone"]);
            sqlParam[8] = new SqlParameter("@active", employer["active"]);
            sqlParam[9] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[9].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspEmployers_Edit", sqlParam)));
            return Convert.ToInt32(sqlParam[9].Value);
        }

        // To update employer progress field
        public async Task<int> UpdateEmployerProgress(Dictionary<string, string> emp)
        {           
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@id", emp["id"]);
            sqlParam[1] = new SqlParameter("@progress", emp["progress"]);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspEmployers_Update_Progress", sqlParam)));    
        }

        public async Task<int> DeleteEmployers(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspEmployers_Delete", sqlParam)));
        }

        // Procedure to add records to Customers table through datatable.
        public async Task<int> InsertEmployers(DataTable dtEmployers, int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@List", dtEmployers);
            sqlParam[0].SqlDbType = SqlDbType.Structured;
            sqlParam[1] = new SqlParameter("@Userid", userid);
            sqlParam[1].SqlDbType = SqlDbType.Int;
            sqlParam[2] = new SqlParameter("@RowsInserted", SqlDbType.Int);
            sqlParam[2].Direction = ParameterDirection.Output;
            var ret = await Task.Run(() => (SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspEmployers_Add_FromFile", sqlParam)));
            return Convert.ToInt32(sqlParam[2].Value);
        }


        public async Task<DataSet> GetEmployersDuplicates(int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Userid", userid);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployers&Temp_Get", sqlParam));
        }
    }
}