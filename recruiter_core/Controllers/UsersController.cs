using recruiter_core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace recruiter_core.Controllers
{
    public class UsersController : ApiController
    {
        User objUser = new User();

        // To validate user based on username & password
        [Route("api/Users/Validate/")]
        [HttpGet]
        public async Task<IHttpActionResult> ValidateUser(string username, string password, string ip_address)
        {
            var art = await objUser.ValidateUser(username, password, ip_address);
            return Ok(art);
        }

        // To fetch a user based on username.
        [Route("api/Users/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetUser(string username, string ip_address)
        {
            var art = await objUser.GetUser(username);
            return Ok(art);
        }

        [Route("api/Users/GetDetails/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetUserDetails(int id)
        {
            var art = await objUser.GetUserDetails(id);
            return Ok(art);
        }
    }
}