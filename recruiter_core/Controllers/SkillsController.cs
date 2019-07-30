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
    public class SkillsController : ApiController
    {
        Skill objSkill = new Skill();

        // For Skills/Get?id=
        [Route("api/Skills/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetSkill(int id)
        {
            var art = await objSkill.GetSkill(id);
            return Ok(art);
        }
        
        // For Skills/Get/
        [Route("api/Skills/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetSkills(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "%";
            var art = await objSkill.GetSkills(srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        // To fetch list of skills based on a search value for AJAX autocomplete fields.
        // Overloaded method for Skills/Get?srchVal=
        [Route("api/Skills/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetSkills(string srchVal)
        {
            var art = await objSkill.GetSkills(srchVal);
            return Ok(art);
        }

        [Route("api/Skills/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertSkill([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> skill = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objSkill.InsertSkill(skill);
            return Ok(cat);
        }

        // Action for updating database through excel/csv file upload.
        // JObject being passed has 2 Jproperties "userid" and "datatable"
        [Route("api/Skills/Insert/Upload/")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertSkills([FromBody] JObject jData)
        {           
            int userid = Convert.ToInt32(jData.GetValue("userid"));
            File.WriteAllText("d:\\jdata.txt", jData.ToString());
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jData.GetValue("datatable").ToString());
            var cat = await objSkill.InsertSkills(dt, userid);
            return Ok(cat);
        }


        [Route("api/Skills/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteSkills(int id)
        {
            var art = await objSkill.DeleteSkills(id);
            return Ok(art);
        }

        [Route("api/Skills/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditSkill([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> skill = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objSkill.EditSkill(skill);
            return Ok(cat);
        }

        // For Skills/Get/Duplicates
        [Route("api/Skills/Get/Duplicates/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetSkillsDuplicates(int userid)
        {
            var art = await objSkill.GetSkillsDuplicates(userid);
            return Ok(art);
        }       
    }
}
