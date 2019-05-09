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
    public class CandidatesController : ApiController
    {
        Candidate objCand = new Candidate();

        [Route("api/Candidate/GetCandidate")]
        public async Task<IHttpActionResult> GetCandidates(string srchBy, string srchVal)
        {
            var art = await objCand.GetCandidates(srchBy, srchVal);
            return Ok(art);
        }

        


    }
}
