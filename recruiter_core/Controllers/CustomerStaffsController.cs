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
    public class CustomerStaffsController : ApiController
    {
        CustomerStaff objCustomerStaff = new CustomerStaff();

        // To fetch a single customer staff based on id
        [Route("api/CustomerStaffs/Get/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCustomer(int id)
        {
            var art = await objCustomerStaff.GetCustomerStaff(id);
            return Ok(art);
        }

        // To fetch multiple customer staffs based on a field type and field value.
        [Route("api/CustomerStaffs/Get")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCustomers(string srchBy, string srchVal, string PageSize, string CurrentPage)
        {
            if (srchVal == null)
                srchVal = "%";
            var art = await objCustomerStaff.GetCustomerStaffs(srchBy, srchVal, PageSize, CurrentPage);
            return Ok(art);
        }

        [Route("api/CustomerStaffs/Insert")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertCustomerStaff([FromBody] JObject dictionaryAsJson)
        {
            File.WriteAllText("d:\\customer_contrl_insert.txt", dictionaryAsJson.ToString());
            Dictionary<string, string> customerStaff = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objCustomerStaff.InsertCustomerStaff(customerStaff);
            return Ok(cat);
        }

        // Action for updating database through excel/csv file upload.
        // JObject being passed has 2 Jproperties "userid" and "datatable"
        [Route("api/CustomerStaffs/Insert/Upload/")]
        [HttpPost]
        public async Task<IHttpActionResult> InsertCustomerStaffs([FromBody] JObject jData)
        {
            int userid = Convert.ToInt32(jData.GetValue("userid"));
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jData.GetValue("datatable").ToString());
            var cat = await objCustomerStaff.InsertCustomerStaff(dt, userid);
            return Ok(cat);
        }


        [Route("api/CustomerStaffs/Delete")]
        [HttpDelete]
        public async Task<IHttpActionResult> DeleteCustomerStaff(int id)
        {
            var art = await objCustomerStaff.DeleteCustomerStaff(id);
            return Ok(art);
        }

        [Route("api/CustomerStaffs/Edit/")]
        [HttpPost]
        public async Task<IHttpActionResult> EditCustomer([FromBody] JObject dictionaryAsJson)
        {
            Dictionary<string, string> customerStaff = JsonConvert.DeserializeObject<Dictionary<string, string>>(dictionaryAsJson.ToString());
            var cat = await objCustomerStaff.EditCustomerStaff(customerStaff);
            return Ok(cat);
        }

        // For fetching conflicting entries in customer staffs and customerstaffs_temp tables
        [Route("api/CustomerStaffs/Get/Duplicates/")]
        [HttpGet]
        public async Task<IHttpActionResult> GetCustomerStaffsDuplicates(int userid)
        {
            var art = await objCustomerStaff.GetCustomerStaffsDuplicates(userid);
            return Ok(art);
        }
    }
}