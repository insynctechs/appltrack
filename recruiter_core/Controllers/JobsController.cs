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

        // To fetch a single job based on id
        [Route("api/Jobs/GetDetails/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetJobDetails(int job_id)
        {
            var art = await objJob.GetJobDetails(job_id);
            return Ok(art);
        }

        // To fetch multiple jobs based on a field type and field value.
        [Route("api/Jobs/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetJobs(string employer_id, string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "";
            var art = await objJob.GetJobs(employer_id, srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        // To fetch list of jobs ids and titles, for a specific employer
        [Route("api/Jobs/GetList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetJobList(int employer_id)
        {
            var art = await objJob.GetJobList(employer_id);
            return Ok(art);
        }

        // To fetch all job vacancies based on industry, category and skill (For client queries)
        [Route("api/Jobs/GetVacancies")]
        [HttpGet]
        public async Task<IHttpActionResult> GetJobVacancies(int customer, int industry, int category, int skill, string job_code, int employer, int min_exp, int max_exp, string PageSize, string CurrentPage)
        {
            if (job_code == null)
                job_code = "";
            var art = await objJob.GetJobVacancies(customer, industry, category, skill, job_code, employer, min_exp, max_exp, PageSize, CurrentPage);
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

        [Route("api/Jobs/GetSkills/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetJobSkills(int id)
        {
            var art = await objJob.GetJobSkills(id);
            return Ok(art);
        }

        [Route("api/Jobs/GetQualifications/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetJobQualifications(int id)
        {
            var art = await objJob.GetJobQualifications(id);
            return Ok(art);
        }

        [Route("api/Jobs/GetQualifiedsList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetQualifiedCandidatesList(int job_id, string status)
        {
            var art = await objJob.GetQualifiedCandidatesList(job_id, status);
            return Ok(art);
        }

        [Route("api/Jobs/GetQualifiedsList2/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetQualifiedCandidatesList2(int job_id)
        {
            var art = await objJob.GetQualifiedCandidatesList2(job_id);
            return Ok(art);
        }

        [Route("api/Jobs/GetSelectedsList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetSelectedCandidatesList(int interview_id)
        {
            var art = await objJob.GetSelectedCandidatesList(interview_id);
            return Ok(art);
        }

        

        [Route("api/Jobs/GetInterviewList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetInterviewList(int job_id)
        {
            var art = await objJob.GetInterviewList(job_id);
            return Ok(art);
        }

        [Route("api/Jobs/InsertApplied")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertAppliedCandidate([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> job_candidate = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objJob.InsertAppliedCandidate(job_candidate);
            return Ok(cat);
        }

        [Route("api/Jobs/IsApplied/")]
        [HttpGet]
        public async Task<IHttpActionResult> IsAppliedForJob(int job_id, int candidate_id)
        {
            var art = await objJob.IsAppliedForJob(job_id, candidate_id);
            return Ok(art);
        }
    }
}