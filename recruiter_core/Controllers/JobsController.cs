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
    public class JobsController : ApiController
    {
        Job objJob = new Job();

        // To fetch a single job based on id
        [Route("api/Jobs/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetJob(int id)
        {
            var art = await objJob.GetJob(id);
            return Ok(art);
        }

        // To fetch multiple jobs based on a field type and field value.
        [Route("api/Jobs/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetJobs(string employer_id, string location_id, string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "%";
            var art = await objJob.GetJobs(employer_id, location_id, srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        [Route("api/Jobs/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertJob([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> job = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objJob.InsertJob(job);
            return Ok(cat);
        }

        [Route("api/Jobs/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditJob([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> job = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objJob.EditJob(job);
            return Ok(cat);
        }
    }
}