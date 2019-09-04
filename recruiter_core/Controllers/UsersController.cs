using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using recruiter_core.Models;
using System;
using System.Collections.Generic;
using System.IO;
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
        public async Task<IHttpActionResult> GetUserDetails(int id, int user_type)
        {
            var art = await objUser.GetUserDetails(id, user_type);
            return Ok(art);
        }

        // To validate user based on username & password
        [Route("api/Users/ChangePassword/")]
        [HttpGet]
        public async Task<IHttpActionResult> ChangePassword(string email, string old_password, string new_password, string ip_address)
        {
            //File.WriteAllText("d:\\changecalled.txt", email + " -> " + old_password + " -> " + new_password + " -> " + ip_address);
            var art = await objUser.ChangePassword(email, old_password, new_password, ip_address);
            return Ok(art);
        }

        [Route("api/Users/EditDetails/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditUserDetails([FromBody] JObject dictionaryAsJson)
        {

            Dictionary<string, string> user = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objUser.EditUserDetails(user);
            return Ok(cat);
        }
    }
}