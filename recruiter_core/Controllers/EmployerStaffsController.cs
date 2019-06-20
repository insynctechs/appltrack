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
    public class EmployerStaffsController : ApiController
    {
        EmployerStaff objEmployerStaff = new EmployerStaff();

        // To fetch a single employer location based on id
        [Route("api/EmployerStaffs/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetEmployerStaff(int id)
        {
            var art = await objEmployerStaff.GetEmployerStaff(id);
            return Ok(art);
        }

        // To fetch multiple employers based on a field type and field value.
        [Route("api/EmployerStaffs/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetEmployerStaffs(string employer_id, string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "%";
            var art = await objEmployerStaff.GetEmployerStaffs(employer_id, srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        [Route("api/EmployerStaffs/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertEmployerStaff([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> employerStaff = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objEmployerStaff.InsertEmployerStaff(employerStaff);
            return Ok(cat);
        }

        [Route("api/EmployerStaffs/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditEmployerStaff([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> employer = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objEmployerStaff.EditEmployerStaff(employer);
            return Ok(cat);
        }
    }
}