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
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@Username", username);
            sqlParam[1] = new SqlParameter("@Password", password);
            //sqlParam[2] = new SqlParameter("@Ip_address", ip_address);
            sqlParam[2] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[2].Direction = ParameterDirection.Output;
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
    }
}