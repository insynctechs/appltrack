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
    public class Util
    {
        public async Task<DataSet> GetCurrencyList()
        {
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCurrencies_GetList"));
        }
    }
}