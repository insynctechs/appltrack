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
    public class EmployersController : ApiController
    {
        Employer objEmployer = new Employer();

        // To fetch a single employer based on id
        [Route("api/Employers/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetEmployer(int id)
        {
            var art = await objEmployer.GetEmployer(id);
            return Ok(art);
        }

        // To fetch employer & employer location details based on id
        [Route("api/Employers/GetFormData/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetFormData(int id)
        {
            var art = await objEmployer.GetFormData(id);
            return Ok(art);
        }

        // To fetch list of employer ids and names
        [Route("api/Employers/GetList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetEmployerList()
        {
            var art = await objEmployer.GetEmployerList();
            return Ok(art);
        }

        // To fetch multiple employers based on a field type and field value.
        [Route("api/Employers/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetEmployers(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "%";
            var art = await objEmployer.GetEmployers(srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        [Route("api/Employers/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertEmployer([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> employer = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objEmployer.InsertEmployer(employer);
            return Ok(cat);
        }

 
        // Action for updating database through excel/csv file upload.
        // JObject being passed has 2 Jproperties "userid" and "datatable"
        [Route("api/Employers/Insert/Upload/")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertEmployers([FromBody] JObject jData)
        {
            int userid = Convert.ToInt32(jData.GetValue("userid"));
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jData.GetValue("datatable").ToString());
            var cat = await objEmployer.InsertEmployers(dt, userid);
            return Ok(cat);
        }


        [Route("api/Employers/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteEmployers(int id)
        {
            var art = await objEmployer.DeleteEmployers(id);
            return Ok(art);
        }

        [Route("api/Employers/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditEmployer([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> employer = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objEmployer.EditEmployer(employer);
            return Ok(cat);
        }

        // To update employers table for progress in multi-step form setup
        [Route("api/Employer/UpdateProgress")]
        [HttpPost]
        public async Task<IHttpActionResult> UpdateProgress([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> emp = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objEmployer.UpdateEmployerProgress(emp);
            return Ok(cat);
        }


        // For fetching conflicting entries in customer and customer_temp tables
        [Route("api/Employers/Get/Duplicates/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetEmployersDuplicates(int userid)
        {
            var art = await objEmployer.GetEmployersDuplicates(userid);
            return Ok(art);
        }
    }
}