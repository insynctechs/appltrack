using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using recruiter_core.Models;

namespace recruiter_core.Controllers
{
    public class SkillsController : ApiController
    {
        Skill objSkill = new Skill();

        [Route("api/Skills/Get")]
        public async Task<IHttpActionResult> GetSkills(string srchBy, string srchVal)
        {
            var art = await objSkill.GetSkills(srchBy, srchVal);
            return Ok(art);
        }

       
        [Route("api/Skills/Insert")]
        [HttpGet]
        public async Task<IHttpActionResult> InsertSkill(string title)
        {

            var cat = await objSkill.InsertSkill(title);
            return Ok(cat);
        }

        [Route("api/Skills/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteSkills(int id)
        {
            var art = await objSkill.DeleteSkills(id);
            return Ok(art);
        }

        [Route("api/Skills/Post")]
        [HttpPost]
        public async Task<IHttpActionResult> PostSkills(int id)
        {
            var art = await objSkill.DeleteSkills(id);
            return Ok(art);
        }
    }
}