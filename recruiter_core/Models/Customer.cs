using Microsoft.ApplicationBlocks.Data;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System;
using System.IO;

namespace recruiter_core.Models
{
    public class Customer
    {
        // New method to implement pagination
        public async Task<DataSet> GetCustomers(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[5];
            sqlParam[0] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[2] = new SqlParameter("@PageSize", PageSize);
            sqlParam[3] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[4] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[4].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCustomers_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[4].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }

        public async Task<DataSet> GetCustomer(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCustomers_GetSingle", sqlParam));
        }

        // To insert customer using form data
        public async Task<int> InsertCustomer(Dictionary<string, string> customer)
        {
            File.WriteAllText("d:\\customer_insert.txt", customer["name"].ToString());
            SqlParameter[] sqlParam = new SqlParameter[15];
            sqlParam[0] = new SqlParameter("@name", customer["name"]);
            sqlParam[1] = new SqlParameter("@address", customer["address"]);
            sqlParam[2] = new SqlParameter("@city", customer["city"]);
            sqlParam[3] = new SqlParameter("@state", customer["state"]);
            sqlParam[4] = new SqlParameter("@zip", customer["zip"]);
            sqlParam[5] = new SqlParameter("@contact", customer["contact"]);
            sqlParam[6] = new SqlParameter("@email", customer["email"]);
            sqlParam[7] = new SqlParameter("@phone", customer["phone"]);
            sqlParam[8] = new SqlParameter("@active", customer["active"]);
            sqlParam[9] = new SqlParameter("@license", customer["license"]);
            sqlParam[10] = new SqlParameter("@license_expiry", customer["license_expiry"]);
            sqlParam[11] = new SqlParameter("@license_year", customer["license_year"]);
            sqlParam[12] = new SqlParameter("@added_date", customer["added_date"]);
            sqlParam[13] = new SqlParameter("@updated_date", customer["updated_date"]);
            sqlParam[14] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[14].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCustomers_Add", sqlParam));
            File.WriteAllText("d:\\customer_insert_ret.txt", sqlret.ToString()+ " : " + sqlParam[14].Value.ToString());
            return Convert.ToInt32(sqlParam[14].Value);
        }


        public async Task<int> EditCustomer(Dictionary<string, string> customer)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@id", customer["id"]);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            sqlParam[1] = new SqlParameter("@title", customer["title"]);
            return await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCustomers_Edit", sqlParam));
        }

        public async Task<int> DeleteCustomers(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id);
            return await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspCustomers_Delete", sqlParam)));
        }

        // Procedure to add records to Customers table through datatable.
        public async Task<int> InsertCustomers(DataTable dtCustomers, int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@List", dtCustomers);
            sqlParam[0].SqlDbType = SqlDbType.Structured;
            sqlParam[1] = new SqlParameter("@Userid", userid);
            sqlParam[1].SqlDbType = SqlDbType.Int;
            sqlParam[2] = new SqlParameter("@RowsInserted", SqlDbType.Int);
            sqlParam[2].Direction = ParameterDirection.Output;
            var ret = await Task.Run(() => (SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCustomers_Add_FromFile", sqlParam)));
            return Convert.ToInt32(sqlParam[2].Value);
        }

        public async Task<DataSet> GetCustomersDuplicates(int userid)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Userid", userid);
            sqlParam[0].SqlDbType = SqlDbType.Int;
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCustomers&Temp_Get", sqlParam));
        }
    }
}