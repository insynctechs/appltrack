using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using recruiter_core.Models;

namespace recruiter_core.Controllers
{
    public class DocumentsController : ApiController
    {
        Document objDocument = new Document();

        // To fetch the document list for a specific employer
        [Route("api/Documents/GetList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetDocumentListForEmployer(int id)
        {
            var art = await objDocument.GetDocumentListForEmployer(id);
            return Ok(art);
        }

        [Route("api/Documents/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertDocument([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> doc = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objDocument.InsertDocument(doc);
            return Ok(cat);
        }

        // To fetch the document for a candidate
        [Route("api/Documents/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCandidateDocuments(int id)
        {
            var art = await objDocument.GetCandidateDocuments(id);
            return Ok(art);
        }
    }
}