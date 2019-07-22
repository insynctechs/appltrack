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
    public class EmployerStaff
    {
        public async Task<DataSet> GetEmployerStaff(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployerStaffs_GetSingle", sqlParam));
        }

        // New method to implement pagination
        public async Task<DataSet> GetEmployerStaffs(string employer_id, string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            SqlParameter[] sqlParam = new SqlParameter[6];
            sqlParam[0] = new SqlParameter("@EmployerId", employer_id);
            sqlParam[1] = new SqlParameter("@SrchBy", srchBy);
            sqlParam[2] = new SqlParameter("@SrchVal", srchVal);
            sqlParam[3] = new SqlParameter("@PageSize", PageSize);
            sqlParam[4] = new SqlParameter("@CurrentPage", CurrentPage);
            sqlParam[5] = new SqlParameter("@ItemCount", SqlDbType.Int);
            sqlParam[5].Direction = ParameterDirection.Output;
            DataSet ds = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspEmployerStaffs_Get", sqlParam));
            // To add an additional table to store the total no. of matching records in db.
            DataTable dt = new DataTable("DB_OUT");
            dt.Columns.Add(new DataColumn("ItemCount", typeof(int)));
            DataRow dr = dt.NewRow();
            dr["ItemCount"] = sqlParam[5].Value;
            dt.Rows.Add(dr);
            ds.Tables.Add(dt);
            return ds;
        }

        public async Task<int> InsertEmployerStaff(Dictionary<string, string> employerStaff)
        {
            
            string password = Utils.GeneratePassword();
            //File.AppendAllText("d:\\EmployerStaffLogins.txt", "Email: " + employerStaff["email"] + "\r\nPassword: " + password + "\r\n\r\n");
            SqlParameter[] sqlParam = new SqlParameter[16];
            sqlParam[0] = new SqlParameter("@user_id", employerStaff["user_id"]);
            sqlParam[1] = new SqlParameter("@employer_id", employerStaff["employer_id"]);
            sqlParam[2] = new SqlParameter("@employer_location_id", employerStaff["employer_location_id"]);
            sqlParam[3] = new SqlParameter("@name", employerStaff["name"]);
            sqlParam[4] = new SqlParameter("@gender", employerStaff["gender"]);
            sqlParam[5] = new SqlParameter("@designation", employerStaff["designation"]);
            sqlParam[6] = new SqlParameter("@address", employerStaff["address"]);
            sqlParam[7] = new SqlParameter("@phone", employerStaff["phone"]);
            sqlParam[8] = new SqlParameter("@email", employerStaff["email"]);
            sqlParam[9] = new SqlParameter("@active", employerStaff["active"]);
            sqlParam[10] = new SqlParameter("@logged_in_userid", employerStaff["logged_in_userid"]);
            sqlParam[11] = new SqlParameter("@password", password);
            sqlParam[12] = new SqlParameter("@ip_address", employerStaff["ip_address"]);
            sqlParam[13] = new SqlParameter("@notification", employerStaff["notification"]);
            sqlParam[14] = new SqlParameter("@user_type", employerStaff["user_type"]);
            sqlParam[15] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[15].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspEmployerStaffs_Add", sqlParam));
            return Convert.ToInt32(sqlParam[15].Value);
        }

        // Some fields not meant to be changed are disabled
        public async Task<int> EditEmployerStaff(Dictionary<string, string> employerStaff)
        {
            SqlParameter[] sqlParam = new SqlParameter[12];
            sqlParam[0] = new SqlParameter("@employer_staff_id", employerStaff["id"]);
            sqlParam[1] = new SqlParameter("@employer_id", employerStaff["employer_id"]);
            sqlParam[2] = new SqlParameter("@employer_location_id", employerStaff["employer_location_id"]);
            sqlParam[3] = new SqlParameter("@name", employerStaff["name"]);
            sqlParam[4] = new SqlParameter("@gender", employerStaff["gender"]);
            sqlParam[5] = new SqlParameter("@designation", employerStaff["designation"]);
            sqlParam[6] = new SqlParameter("@address", employerStaff["address"]);
            sqlParam[7] = new SqlParameter("@phone", employerStaff["phone"]);
            sqlParam[8] = new SqlParameter("@email", employerStaff["email"]);
            sqlParam[9] = new SqlParameter("@active", employerStaff["active"]);
            sqlParam[10] = new SqlParameter("@logged_in_userid", employerStaff["logged_in_userid"]);
            //sqlParam[11] = new SqlParameter("@ip_address", employerStaff["ip_address"]);
            //sqlParam[13] = new SqlParameter("@notification", employerStaff["notification"]);
            //sqlParam[14] = new SqlParameter("@user_type", employerStaff["user_type"]);
            sqlParam[11] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[11].Direction = ParameterDirection.Output;

            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspEmployerStaffs_Edit", sqlParam));
            return Convert.ToInt32(sqlParam[11].Value);
        }
    }
}