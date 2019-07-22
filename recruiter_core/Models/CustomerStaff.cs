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
    public class CustomerStaff
    {
        // New method to implement pagination
        public async Task<DataSet> GetCustomerStaffs(string customer_id, string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[6];
            sqlParam[0] = new SqlParameter("@CustomerId", customer_id);
            sqlParam[1] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[2] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[3] = new SqlParameter("@PageSize", PageSize);
            sqlParam[4] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[5] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[5].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCustomerStaffs_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[5].Value;
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
            string password = Utils.GeneratePassword();
            //File.AppendAllText("d:\\CustomerStaffLogins.txt", "Email: " + customerStaff["email"] + "\r\nPassword: " + password + "\r\n\r\n");
            SqlParameter[] sqlParam = new SqlParameter[15];
            
            sqlParam[0] = new SqlParameter("@user_id", customerStaff["user_id"]);
            sqlParam[1] = new SqlParameter("@customer_id", customerStaff["customer_id"]);
            sqlParam[2] = new SqlParameter("@name", customerStaff["name"]);
            sqlParam[3] = new SqlParameter("@gender", customerStaff["gender"]);
            sqlParam[4] = new SqlParameter("@designation", customerStaff["designation"]);
            sqlParam[5] = new SqlParameter("@address", customerStaff["address"]);
            sqlParam[6] = new SqlParameter("@phone", customerStaff["phone"]);
            sqlParam[7] = new SqlParameter("@email", customerStaff["email"]);
            sqlParam[8] = new SqlParameter("@active", customerStaff["active"]);
            sqlParam[9] = new SqlParameter("@logged_in_user_id", customerStaff["logged_in_user_id"]);
            sqlParam[10] = new SqlParameter("@password", password);
            sqlParam[11] = new SqlParameter("@ip_address", customerStaff["ip_address"]);
            sqlParam[12] = new SqlParameter("@notification", customerStaff["notification"]);
            sqlParam[13] = new SqlParameter("@user_type", customerStaff["user_type"]);
            sqlParam[14] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[14].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCustomerStaffs_Add", sqlParam));
            return Convert.ToInt32(sqlParam[14].Value);
        }


        public async Task<int> EditCustomerStaff(Dictionary<string, string> customerStaff)
        {
            SqlParameter[] sqlParam = new SqlParameter[13];
            sqlParam[0] = new SqlParameter("@id", customerStaff["id"]);
            sqlParam[1] = new SqlParameter("@user_id", customerStaff["user_id"]);
            sqlParam[2] = new SqlParameter("@name", customerStaff["name"]);
            sqlParam[3] = new SqlParameter("@gender", customerStaff["gender"]);
            sqlParam[4] = new SqlParameter("@designation", customerStaff["designation"]);
            sqlParam[5] = new SqlParameter("@address", customerStaff["address"]);
            sqlParam[6] = new SqlParameter("@phone", customerStaff["phone"]);
            sqlParam[7] = new SqlParameter("@email", customerStaff["email"]);
            sqlParam[8] = new SqlParameter("@active", customerStaff["active"]);
            sqlParam[9] = new SqlParameter("@logged_in_user_id", customerStaff["logged_in_user_id"]);
            sqlParam[10] = new SqlParameter("@ip_address", customerStaff["ip_address"]);
            sqlParam[11] = new SqlParameter("@notification", customerStaff["notification"]);
            sqlParam[12] = new SqlParameter("@user_type", customerStaff["user_type"]);
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