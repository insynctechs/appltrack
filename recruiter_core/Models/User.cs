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
    public class User
    {
        // To validate user based on username(ie; email) and password combo. Return is '1' for match, '-1' for non-match and '0' for db error.
        public async Task<int> ValidateUser(string username, string password, string ip_address)
        {
            SqlParameter[] sqlParam = new SqlParameter[4];
            sqlParam[0] = new SqlParameter("@Username", username);
            sqlParam[1] = new SqlParameter("@Password", password);
            sqlParam[2] = new SqlParameter("@Ip_address", ip_address);
            sqlParam[3] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[3].Direction = ParameterDirection.Output;
            int ret = await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspUsers_ValidateUser", sqlParam)));
            return ret;
        }

        // To fetch the necessary details of a user based on email inorder to be stored in user session.
        // This is the immediate method call after successful validation of user.
        public async Task<DataSet> GetUser(string username)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@email", username);
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspUsers_GetSingle", sqlParam));
        }

        // To fetch all the details of a user based on id in the corresponding staff table.
        public async Task<DataSet> GetUserDetails(int id, int user_type)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@ref_id", id);
            sqlParam[1] = new SqlParameter("@user_type", user_type);
            var ret = await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspUsers_GetDetails", sqlParam));
            return ret;
        }

        // To change user password.
        public async Task<int> ChangePassword(string email, string old_password, string new_password, string ip_address)
        {
            SqlParameter[] sqlParam = new SqlParameter[5];
            sqlParam[0] = new SqlParameter("@email", email);
            sqlParam[1] = new SqlParameter("@old_password", old_password);
            sqlParam[2] = new SqlParameter("@new_password", new_password);
            sqlParam[3] = new SqlParameter("@ip_address", ip_address);
            sqlParam[4] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[4].Direction = ParameterDirection.Output;
            int ret = await Task.Run(() => Convert.ToInt32(SqlHelper.ExecuteScalar(Settings.Constr, CommandType.StoredProcedure, "uspUsers_ChangePassword", sqlParam)));
            return ret;
        }

        public async Task<int> EditUserDetails(Dictionary<string, string> user)
        {

            SqlParameter[] sqlParam = new SqlParameter[10];
            sqlParam[0] = new SqlParameter("@user_id", user["user_id"]);
            sqlParam[1] = new SqlParameter("@ref_id", user["ref_id"]);
            sqlParam[2] = new SqlParameter("@user_type", user["user_type"]);
            sqlParam[3] = new SqlParameter("@name", user["name"]);
            sqlParam[4] = new SqlParameter("@gender", user["gender"]);
            sqlParam[5] = new SqlParameter("@designation", user["designation"]);
            sqlParam[6] = new SqlParameter("@address", user["address"]);
            sqlParam[7] = new SqlParameter("@phone", user["phone"]);
            sqlParam[8] = new SqlParameter("@email", user["email"]);

            sqlParam[9] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[9].Direction = ParameterDirection.Output;

            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspUsers_EditDetails", sqlParam));

            return Convert.ToInt32(sqlParam[9].Value);
        }
    }
}