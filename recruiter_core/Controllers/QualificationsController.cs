using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using recruiter_core.Models;

namespace recruiter_core.Controllers
{
    public class QualificationsController : ApiController
    {
        Qualification objQualification = new Qualification();

        // For Qualifications/Get?id=
        [Route("api/Qualifications/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetQualification(int id)
        {
            var art = await objQualification.GetQualification(id);
            return Ok(art);
        }

        // For Qualifications/Get/
        [Route("api/Qualifications/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetQualifications(string srchBy, string srchVal)
        {
            var art = await objQualification.GetQualifications(srchBy, srchVal);
            return Ok(art);
        }

        [Route("api/Qualifications/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertQualification([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> qualification = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objQualification.InsertQualification(qualification);
            return Ok(cat);
        }

        // Action for updating database through excel/csv file upload.
        // JObject being passed has 2 Jproperties "userid" and "datatable"
        [Route("api/Qualifications/Insert/Upload/")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertQualifications([FromBody] JObject jData)
        {
            int userid = Convert.ToInt32(jData.GetValue("userid"));
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jData.GetValue("datatable").ToString());
            var cat = await objQualification.InsertQualifications(dt, userid);
            return Ok(cat);
        }


        [Route("api/Qualifications/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteQualifications(int id)
        {
            var art = await objQualification.DeleteQualifications(id);
            return Ok(art);
        }

        [Route("api/Qualifications/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditQualification([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> qualification = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objQualification.EditQualification(qualification);
            return Ok(cat);
        }

        // For Qualifications/Get/Duplicates
        [Route("api/Qualifications/Get/Duplicates/{userid}")]
        [HttpGet]
        public async Task<IHttpActionResult> GetQualificationsDuplicates(int userid)
        {
            var art = await objQualification.GetQualificationsDuplicates(userid);
            return Ok(art);
        }
    }
}