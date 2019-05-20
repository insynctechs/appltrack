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

        // For Skills/Get?id=
        [Route("api/Qualifications/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetQualification(int id)
        {
            var art = await objQualification.GetQualification(id);
            return Ok(art);
        }

        // For Skills/Get/
        [Route("api/Qualifications/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetQualifications(string srchBy, string srchVal)
        {
            var art = await objQualification.GetQualifications(srchBy, srchVal);
            return Ok(art);
        }

        [Route("api/Qualifications/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertQualification([FromBody] Object jsonString)
        {
            File.WriteAllText("D:\\SkillsController_InsertSkill.txt", jsonString.ToString());
            var cat = await objQualification.InsertQualification(jsonString.ToString());
            return Ok(cat);
        }

        [Route("api/Qualifications/Insert/Upload")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertQualifications([FromBody] JArray jsonString)
        {
            //string httpContent = Request.Content.ReadAsStringAsync().Result;
            File.WriteAllText("D:\\SkillsController_InsertSkills.txt", jsonString.ToString());
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jsonString.ToString());
            var cat = await objQualification.InsertQualifications(dt);
            return Ok(cat);
        }

        [Route("api/Qualifications/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteQualifications(int id)
        {
            var art = await objQualification.DeleteQualifications(id);
            return Ok(art);
        }
    }
}