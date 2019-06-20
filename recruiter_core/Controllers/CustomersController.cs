using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using recruiter_core.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace recruiter_core.Controllers
{
    public class CustomersController : ApiController
    {
        Customer objCustomer = new Customer();

        // To fetch a single customer based on id
        [Route("api/Customers/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCustomer(int id)
        {
            var art = await objCustomer.GetCustomer(id);
            return Ok(art);
        }

        // To fetch multiple customers based on a field type and field value.
        [Route("api/Customers/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCustomers(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "%";
            var art = await objCustomer.GetCustomers(srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        [Route("api/Customers/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertCustomer([FromBody] JObject dictionaryAsJson)
        {
            File.WriteAllText("d:\\customer_contrl_insert.txt", dictionaryAsJson.ToString());
            Dictionary<string, string> customer = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objCustomer.InsertCustomer(customer);
            return Ok(cat);
        }

        // Action for updating database through excel/csv file upload.
        // JObject being passed has 2 Jproperties "userid" and "datatable"
        [Route("api/Customers/Insert/Upload/")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertCustomers([FromBody] JObject jData)
        {
            int userid = Convert.ToInt32(jData.GetValue("userid"));
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jData.GetValue("datatable").ToString());
            var cat = await objCustomer.InsertCustomers(dt, userid);
            return Ok(cat);
        }


        [Route("api/Customers/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteCustomers(int id)
        {
            var art = await objCustomer.DeleteCustomers(id);
            return Ok(art);
        }

        [Route("api/Customers/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditCustomer([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> customer = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objCustomer.EditCustomer(customer);
            return Ok(cat);
        }

        // For fetching conflicting entries in customer and customer_temp tables
        [Route("api/Customers/Get/Duplicates/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCustomersDuplicates(int userid)
        {
            var art = await objCustomer.GetCustomersDuplicates(userid);
            return Ok(art);
        }
    }
}