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
        Candidate cand = new Candidate();

        [Route("api/Candidate/GetCandidate")]
        public async Task<IHttpActionResult> GetCandidates(string srchBy, string srchVal)
        {
            var art = await cand.GetCandidates(srchBy, srchVal);
            return Ok(art);
        }

        [Route("api/Candidate/InsertCandidate")]
        [HttpGet]
        public async Task<IHttpActionResult> InsertCandidate(string CandidateName, string Address, string Email, string Phone)
        {

            var cat = await rfq.InsertRFQ(CandiidateName, ContactName, Email, Address, Phone, Comments);
            return Ok(cat);
        }


    }
}
