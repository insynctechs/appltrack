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
    public class Document
    {
        public async Task<DataSet> GetDocumentListForEmployer(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspDocuments_GetList", sqlParam));
        }

        // To insert customer using form data
        public async Task<int> InsertDocument(Dictionary<string, string> doc)
        {
            SqlParameter[] sqlParam = new SqlParameter[4];
            sqlParam[0] = new SqlParameter("@candidate_id", doc["candidate_id"]);
            sqlParam[1] = new SqlParameter("@document_type_id", doc["document_type_id"]);
            sqlParam[2] = new SqlParameter("@filename", doc["filename"]);
            sqlParam[3] = new SqlParameter("@Ret", SqlDbType.Int);
            sqlParam[3].Direction = ParameterDirection.Output;
            var sqlret = await Task.Run(() => SqlHelper.ExecuteNonQuery(Settings.Constr, CommandType.StoredProcedure, "uspCandidateDocuments_Add", sqlParam));
            return Convert.ToInt32(sqlParam[3].Value);
        }

        public async Task<DataSet> GetCandidateDocuments(int id)
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@id", id.ToString());
            return await Task.Run(() => SqlHelper.ExecuteDataset(Settings.Constr, CommandType.StoredProcedure, "uspCandidateDocuments_Get", sqlParam));
        }
    }
}