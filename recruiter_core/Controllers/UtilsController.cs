using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using recruiter_core.Models;

namespace recruiter_core.Controllers
{
    public class UtilsController : ApiController
    {
        Util objUtil = new Util();

        // To fetch currency list
        [Route("api/Utils/GetCurrencyList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCurrencyList()
        {
            var art = await objUtil.GetCurrencyList();
            return Ok(art);
        }
    }
}