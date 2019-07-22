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
    public class InterviewsController : ApiController
    {
        Interview objJob = new Interview();

        // To fetch a single Interview based on id
        [Route("api/Interviews/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetInterview(int id)
        {
            var art = await objJob.GetInterview(id);
            return Ok(art);
        }

        // To fetch multiple Interviews based on a field type and field value.
        [Route("api/Interviews/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetInterviews(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "%";
            var art = await objJob.GetInterviews(srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        [Route("api/Interviews/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertInterview([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> interview = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objJob.InsertInterview(interview);
            return Ok(cat);
        }

        [Route("api/Interviews/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditInterview([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> interview = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objJob.EditInterview(interview);
            return Ok(cat);
        }

    }
}