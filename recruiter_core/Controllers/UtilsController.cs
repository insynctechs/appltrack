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

        // To fetch industry list
        [Route("api/Utils/GetIndustryList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetIndustryList()
        {
            var art = await objUtil.GetIndustryList();
            return Ok(art);
        }

        // To fetch industry list with job count
        [Route("api/Utils/GetIndustryListWithJobCount/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetIndustryListWithJobCount()
        {
            var art = await objUtil.GetIndustryListWithJobCount();
            return Ok(art);
        }

        // To fetch category list
        [Route("api/Utils/GetCategoryList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCategoryList()
        {
            var art = await objUtil.GetCategoryList();
            return Ok(art);
        }

        // To fetch category list with job count
        [Route("api/Utils/GetCategoryListWithJobCount/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCategoryListWithJobCount()
        {
            var art = await objUtil.GetCategoryListWithJobCount();
            return Ok(art);
        }

        // To fetch currency list
        [Route("api/Utils/GetDocumentTypeList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetDocumentTypeList()
        {
            var art = await objUtil.GetDocumentTypeList();
            return Ok(art);
        }

        // To fetch candidate status list
        [Route("api/Utils/GetCandidateStatusList/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCandidateStatusList()
        {
            var art = await objUtil.GetCandidateStatusList();
            return Ok(art);
        }
    }
}