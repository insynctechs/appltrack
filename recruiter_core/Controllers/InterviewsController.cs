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
        Interview objInterview = new Interview();

        // To fetch a single Interview based on id
        [Route("api/Interviews/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetInterview(int id)
        {
            var art = await objInterview.GetInterview(id);
            return Ok(art);
        }

        // To fetch interview list based on job id
        [Route("api/Interviews/GetList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetInterviewList(int id)
        {
            var art = await objInterview.GetInterviewList(id);
            return Ok(art);
        }

        // To fetch multiple Interviews based on a field type and field value.
        [Route("api/Interviews/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetInterviews(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "";
            var art = await objInterview.GetInterviews(srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        [Route("api/Interviews/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertInterview([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> interview = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objInterview.InsertInterview(interview);
            return Ok(cat);
        }

        [Route("api/Interviews/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditInterview([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> interview = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objInterview.EditInterview(interview);
            return Ok(cat);
        }

        [Route("api/Interviews/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteInterview(int id)
        {
            var art = await objInterview.DeleteInterview(id);
            return Ok(art);
        }

        [Route("api/Interviews/SetInterview")]
        [HttpPost]
        public async Task<IHttpActionResult> SetInterviewForCandidates([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> interview_candidates = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objInterview.SetInterviewForCandidates(interview_candidates);
            return Ok(cat);
        }

        [Route("api/Interviews/UpdateCandidates")]
        [HttpPost]
        public async Task<IHttpActionResult> UpdateCandidatesForInterview([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> interview_candidates = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objInterview.UpdateCandidatesForInterview(interview_candidates);
            return Ok(cat);
        }

        [Route("api/Interviews/GetResults/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetResults(int employer_id, int job_id, int interview_id)
        {
            var art = await objInterview.GetResults(employer_id, job_id, interview_id);
            return Ok(art);
        }

        [Route("api/Interviews/GetReport/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetReport(string customer_id, string employer_id, string job_id, string from_date, string to_date)
        {
            var art = await objInterview.GetReport(customer_id, employer_id, job_id, from_date, to_date);
            return Ok(art);
        }
    }
}