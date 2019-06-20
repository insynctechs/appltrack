using Microsoft.ApplicationBlocks.Data;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System;
using System.IO;

namespace recruiter_core.Models
{
    public class CustomerStaff
    {
        // New method to implement pagination
        public async Task<DataSet> GetCustomerStaffs(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[5];
            sqlParam[0] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[2] = new SqlParameter("@PageSize", PageSize);
            sqlParam[3] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[4] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[4].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCustomerStaffs_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[4].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }

        public async Task<DataSet> GetCustomerStaff(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCustomerStaffs_GetSingle", sqlParam));
        }

        // To insert customer using form data
        public async Task<int> InsertCustomerStaff(Dictionary<string, string> customerStaff)
        {
            File.WriteAllText("d:\\customerStaff_insert.txt", customerStaff["name"].ToString());
            SqlParameter[] sqlParam = new SqlParameter[14];
            sqlParam[0] = new SqlParameter("@id", customerStaff["id"]);
            sqlParam[1] = new SqlParameter("@user_id", customerStaff["user_id"]);
            sqlParam[2] = new SqlParameter("@customer_id", customerStaff["customer_id"]);
            sqlParam[3] = new SqlParameter("@name", customerStaff["name"]);
            sqlParam[4] = new SqlParameter("@gender", customerStaff["gender"]);
            sqlParam[5] = new SqlParameter("@designation", customerStaff["designation"]);
            sqlParam[6] = new SqlParameter("@address", customerStaff["address"]);
            sqlParam[7] = new SqlParameter("@phone", customerStaff["phone"]);
            sqlParam[8] = new SqlParameter("@email", customerStaff["email"]);
            sqlParam[9] = new SqlParameter("@active", customerStaff["active"]);
            sqlParam[10] = new SqlParameter("@added_date", customerStaff["added_date"]);
            sqlParam[11] = new SqlParameter("@updated_date", customerStaff["updated_date"]);
            sqlParam[12] = new SqlParameter("@logged_in_user_id", customerStaff["logged_in_user_id"]);
            sqlParam[13] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[13].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCustomerStaffs_Add", sqlParam));
            File.WriteAllText("d:\\customerStaff_insert_ret.txt", sqlret.ToString() + " : " + sqlParam[13].Value.ToString());
            return Convert.ToInt32(sqlParam[13].Value);
        }


        public async Task<int> EditCustomerStaff(Dictionary<string, string> customerStaff)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@id", customerStaff["id"]);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            sqlParam[1] = new SqlParameter("@title", customerStaff["title"]);
            return await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCustomerStaffs_Edit", sqlParam));
        }

        public async Task<int> DeleteCustomerStaff(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspCustomerStaffs_Delete", sqlParam)));
        }

        // Procedure to add records to Customers table through datatable.
        public async Task<int> InsertCustomerStaff(DataTable dtCustomerStaffs, int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@List", dtCustomerStaffs);
            sqlParam[0].SqlDbType = SqlDbType.Structured;
            sqlParam[1] = new SqlParameter("@Userid", userid);
            sqlParam[1].SqlDbType = SqlDbType.Int;
            sqlParam[2] = new SqlParameter("@RowsInserted", SqlDbType.Int);
            sqlParam[2].Direction = ParameterDirection.Output;
            var ret = await Task.Run(() => (SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCustomerStaffs_Add_FromFile", sqlParam)));
            return Convert.ToInt32(sqlParam[2].Value);
        }

        public async Task<DataSet> GetCustomerStaffsDuplicates(int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Userid", userid);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCustomerStaffs&Temp_Get", sqlParam));
        }
    }
}