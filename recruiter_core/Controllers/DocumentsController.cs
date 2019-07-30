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
    }
}