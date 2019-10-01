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

        // To fetch multiple customers based on a field type and field value.
        [Route("api/Candidates/GetCandidates")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCandidates(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "";
            var art = await objCandidate.GetCandidates(srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }


        [Route("api/Candidates/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertCandidate([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> candidate = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objCandidate.InsertCandidate(candidate);
            return Ok(cat);
        }

        [Route("api/Candidates/Edit")]
        [HttpPost]
        public async Task<IHttpActionResult> EditCandidate([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> candidate = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objCandidate.EditCandidate(candidate);
            return Ok(cat);
        }

        [Route("api/Candidates/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCandidate(int id)
        {
            var art = await objCandidate.GetCandidate(id);
            return Ok(art);
        }

        [Route("api/Candidates/GetSkills/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCandidateSkills(int id)
        {
            var art = await objCandidate.GetCandidateSkills(id);
            return Ok(art);
        }

        [Route("api/Candidates/GetQualifications/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCandidateQualifications(int id)
        {
            var art = await objCandidate.GetCandidateQualifications(id);
            return Ok(art);
        }

        [Route("api/Candidates/GetExperiences/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCandidateExperiences(int id)
        {
            var art = await objCandidate.GetCandidateExperiences(id);
            return Ok(art);
        }

        [Route("api/Candidates/GetCandidateDocuments/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCandidateDocuments(int id)
        {
            var art = await objCandidate.GetCandidateDocuments(id);
            return Ok(art);
        }

        [Route("api/Candidates/DeleteDocument/")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteDocument(string file)
        {
            var art = await objCandidate.DeleteDocument(file);
            return Ok(art);
        }

        [Route("api/Candidates/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteCandidate(int id)
        {
            var art = await objCandidate.DeleteCandidate(id);
            return Ok(art);
        }
    }
}
