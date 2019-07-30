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
    public class CandidatesController : ApiController
    {
        Candidate objCandidate = new Candidate();

        [Route("api/Candidates/GetCandidate")]
        public async Task<IHttpActionResult> GetCandidates(string srchBy, string srchVal)
        {
            var art = await objCandidate.GetCandidates(srchBy, srchVal);
            return Ok(art);
        }

        [Route("api/Candidates/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertCandidate([FromBody] JObject dictionaryAsJson)
        {
            File.WriteAllText("d:\\insertcand.txt", dictionaryAsJson.ToString());
            Dictionary<string, string> job = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objCandidate.InsertCandidate(job);
            return Ok(cat);
        }


    }
}
