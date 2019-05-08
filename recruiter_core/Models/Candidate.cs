using Microsoft.ApplicationBlocks.Data;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace recruiter_core.Models
{
    public class Candidate
    {
        public async Task<DataSet> GetCandidates(string srchBy, string srchVal)
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@SearchBy", srchBy);
            sqlParam[1] = new SqlParameter("@SearchValue", srchVal);
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidates_Get", sqlParam));
        }
    }
}