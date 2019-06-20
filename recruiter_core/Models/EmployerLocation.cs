using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace recruiter_core.Models
{
    public class EmployerLocation
    {
        public async Task<DataSet> GetEmployerLocation(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployerLocations_GetSingle", sqlParam));
        }

        // New method to implement pagination
        public async Task<DataSet> GetEmployerLocations(string employer_id, string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[6];
            sqlParam[0] = new SqlParameter("@EmployerId", employer_id);
            sqlParam[1] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[2] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[3] = new SqlParameter("@PageSize", PageSize);
            sqlParam[4] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[5] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[5].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployerLocations_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[5].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }

        public async Task<DataSet> GetLocationListForEmployer(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployerLocations_GetList", sqlParam));
        }

        public async Task<int> InsertEmployerLocation(Dictionary<string, string> employerLocation)
        {
            SqlParameter[] sqlParam = new SqlParameter[9];
            sqlParam[0] = new SqlParameter("@employer_id", employerLocation["employer_id"]);
            sqlParam[1] = new SqlParameter("@address", employerLocation["address"]);
            sqlParam[2] = new SqlParameter("@city", employerLocation["city"]);
            sqlParam[3] = new SqlParameter("@zip", employerLocation["zip"]);
            sqlParam[4] = new SqlParameter("@email", employerLocation["email"]);
            sqlParam[5] = new SqlParameter("@phone", employerLocation["phone"]);
            sqlParam[6] = new SqlParameter("@country", employerLocation["country"]);
            sqlParam[7] = new SqlParameter("@active", employerLocation["active"]);
            sqlParam[8] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[8].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspEmployerLocations_Add", sqlParam));
            return Convert.ToInt32(sqlParam[8].Value);
        }

        public async Task<int> EditEmployerLocation(Dictionary<string, string> employerLocation)
        {
            SqlParameter[] sqlParam = new SqlParameter[10];
            sqlParam[0] = new SqlParameter("@id", employerLocation["id"]);
            sqlParam[1] = new SqlParameter("@employer_id", employerLocation["employer_id"]);
            sqlParam[2] = new SqlParameter("@address", employerLocation["address"]);
            sqlParam[3] = new SqlParameter("@city", employerLocation["city"]);
            sqlParam[4] = new SqlParameter("@zip", employerLocation["zip"]);
            sqlParam[5] = new SqlParameter("@email", employerLocation["email"]);
            sqlParam[6] = new SqlParameter("@phone", employerLocation["phone"]);
            sqlParam[7] = new SqlParameter("@country", employerLocation["country"]);
            sqlParam[8] = new SqlParameter("@active", employerLocation["active"]);
            sqlParam[9] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[9].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspEmployerLocations_Edit", sqlParam)));
            return Convert.ToInt32(sqlParam[9].Value);
        }

    }
}