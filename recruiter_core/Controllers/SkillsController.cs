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

        /*
        [Route("api/Skills/Insert")]
        [HttpGet]
        public async Task<IHttpActionResult> InsertSkill(string title)
        {
            var cat = await objSkill.InsertSkill(title);
            return Ok(cat);
        }
        */

        [Route("api/Skills/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertSkill([FromBody] Object jsonString)
        {
            File.WriteAllText("D:\\SkillsController_InsertSkill.txt", jsonString.ToString());
            var cat = await objSkill.InsertSkill(jsonString.ToString());
            return Ok(cat);
        }
       
        [Route("api/Skills/Insert/Upload")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertSkills([FromBody] JArray jsonString)
        {
            //string httpContent = Request.Content.ReadAsStringAsync().Result;
            File.WriteAllText("D:\\SkillsController_InsertSkills.txt", jsonString.ToString());
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jsonString.ToString());
            var cat = await objSkill.InsertSkills(dt);
            return Ok(cat);
        }


        /*
        [Route("api/Skills/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertSkill(string title)
        {
            var cat = await objSkill.InsertSkill(title);
            return Ok(cat);
        }
        */

        [Route("api/Skills/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteSkills(int id)
        {
            var art = await objSkill.DeleteSkills(id);
            return Ok(art);
        }


        /*
        [Route("api/Skills/Edit/{id:int}")]
        [HttpPost]
        public async Task<IHttpActionResult> EditSkills([FromBody] JObject jData, int id)
        {
            Skill skill = JsonConvert.DeserializeObject<Skill>(jData.ToString());
            var art = await objSkill.InsertSkill();
            /*object[] objData = skill.list.ToArray();
            var res = await rev.InsertCommenter(objData[0].ToString(), objData[1].ToString(), objData[2].ToString(), objData[3].ToString(), objData[4].ToString(), 1);
            if (res == "success")
            {
                if (skill.doaction == "yes")
                    ReviewActions.SendRegistrationMail(objData[1].ToString(), objData[2].ToString(), objData[3].ToString());

            }
        }
        */

    }
}
