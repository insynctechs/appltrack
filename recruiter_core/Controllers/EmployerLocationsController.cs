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
    public class EmployerLocationsController : ApiController
    {
        EmployerLocation objEmployerLocation = new EmployerLocation();

        // To fetch a single employer location based on id
        [Route("api/EmployerLocations/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetEmployerLocation(int id)
        {
            var art = await objEmployerLocation.GetEmployerLocation(id);
            return Ok(art);
        }

        // To fetch multiple employer locations based on a field type and field value.
        [Route("api/EmployerLocations/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetEmployerLocations(string employer_id, string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "%";
            var art = await objEmployerLocation.GetEmployerLocations(employer_id, srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        // To fetch employer & employer location details based on id
        [Route("api/EmployerLocations/GetList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetLocationListForEmployer(int id)
        {
            var art = await objEmployerLocation.GetLocationListForEmployer(id);
            return Ok(art);
        }

        // Employer Location Insertion.
        [Route("api/EmployerLocations/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertEmployerLocation([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> employerLocation = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objEmployerLocation.InsertEmployerLocation(employerLocation);
            return Ok(cat);
        }

        [Route("api/EmployerLocations/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditEmployerLocation([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> employer = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objEmployerLocation.EditEmployerLocation(employer);
            return Ok(cat);
        }
    }
}