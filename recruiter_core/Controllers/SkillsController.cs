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
        public async Task<IHttpActionResult> GetSkills(string srchBy, string srchVal)
        {
            var art = await objSkill.GetSkills(srchBy, srchVal);
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
       
        [Route("api/Skills/Insert/Upload/{userid}")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertSkills(int userid, [FromBody] JArray dataTableAsJson)
        {
            File.WriteAllText("D:\\SkillsController_excelup.txt", "called" + " ; userid=" + userid);
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(dataTableAsJson.ToString());
            var cat = await objSkill.InsertSkills(dt, userid);
            File.WriteAllText("D:\\SkillsController_ret.txt", cat.ToString()+" ; userid="+userid);
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
            File.WriteAllText("D:\\Skillcontroller_edit.txt", "action called");
            Dictionary<string, string> skill = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objSkill.EditSkill(skill);
            File.WriteAllText("D:\\Skilledit_ret.txt", cat.ToString());
            return Ok(cat);
        }

        // For Skills/Get/Duplicates
        [Route("api/Skills/Get/Duplicates/{userid}")]
        [HttpGet]
        public async Task<IHttpActionResult> GetSkillsDuplicates(int userid)
        {
            var art = await objSkill.GetSkillsDuplicates(userid);
            return Ok(art);
        }

    }
}
