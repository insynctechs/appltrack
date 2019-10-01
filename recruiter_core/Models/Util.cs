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

        public async Task<DataSet> GetIndustryList()
        {
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspIndustries_GetList"));
        }

        public async Task<DataSet> GetIndustryListWithJobCount()
        {
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspIndustries_GetListWithJobCount"));
        }

        public async Task<DataSet> GetCategoryList()
        {
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCategories_GetList"));
        }

        public async Task<DataSet> GetCategoryListWithJobCount()
        {
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCategories_GetListWithJobCount"));
        }

        public async Task<DataSet> GetDocumentTypeList()
        {
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspDocumentTypes_GetList"));
        }

        public async Task<DataSet> GetCandidateStatusList()
        {
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidateStatus_GetList"));
        }
    }
}