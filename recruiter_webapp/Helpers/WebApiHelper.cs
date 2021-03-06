﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Net.Http;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Threading.Tasks;
using System.Text;
using System.Net.Http.Headers;
using System.IO;

namespace recruiter_webapp.Helpers
{
    public class WebApiHelper
    {
        public DataSet GetDataSetFromWebApi(string path)
        {
            var url = string.Format(path);
            HttpResponseMessage response = Utils.Client.GetAsync(url).Result;
            if (response.IsSuccessStatusCode)
            {
                var res = response.Content.ReadAsStringAsync().Result;
                DataSet ds = JsonConvert.DeserializeObject<DataSet>(res);
                return ds;
            }
            return null;
        }

        public DataTable GetDataTableFromWebApi(string path)
        {
            var url = string.Format(path);
            HttpResponseMessage response = Utils.Client.GetAsync(url).Result;
            if (response.IsSuccessStatusCode)
            {
                var res = response.Content.ReadAsStringAsync().Result;
                DataSet dt = JsonConvert.DeserializeObject<DataSet>(res);
                if (dt.Tables.Count > 0)
                    return dt.Tables[0];
                else
                    return null;
            }
            return null;
        }

        public int GetExecuteNonQueryResFromWebApi(string path)
        {
            var url = string.Format(path);
            HttpResponseMessage response = Utils.Client.GetAsync(url).Result;
            if (response.IsSuccessStatusCode)
            {
                var res = response.Content.ReadAsStringAsync().Result;
                int ret = JsonConvert.DeserializeObject<int>(res);
                return ret;
            }
            return 0;
        }


        public string GetExecuteNonQueryStringResFromWebApi(string path)
        {
            var url = string.Format(path);
            HttpResponseMessage response = Utils.Client.GetAsync(url).Result;
            if (response.IsSuccessStatusCode)
            {
                var res = response.Content.ReadAsStringAsync().Result;
                string ret = JsonConvert.DeserializeObject<string>(res);
                return ret;
            }
            else
                return "Error";// + response.StatusCode.ToString();
        }

        public int DeleteRecordFromWebApi(string path)
        {
            var url = string.Format(path);
            HttpResponseMessage response = Utils.Client.DeleteAsync(url).Result;
            if (response.IsSuccessStatusCode)
            {
                var res = response.Content.ReadAsStringAsync().Result;
                int ret = JsonConvert.DeserializeObject<int>(res);
                return ret;
            }
            return 0;
        }
        /*
        public int UpdateRecordFromWebApi(string path)
        {
            var url = string.Format(path);
            HttpResponseMessage response = Utils.Client.PutAsync(url, ).Result;
            if (response.IsSuccessStatusCode)
            {
                var res = response.Content.ReadAsStringAsync().Result;
                int ret = JsonConvert.DeserializeObject<int>(res);
                return ret;
            }
            return 0;
        }
        */

        // To insert / update a record from webform using url, dictionary(form field data) through post method
        public int PostExecuteNonQueryResFromWebApi(string path, Dictionary<string, string> dict)
        {
            var url = string.Format(path);
            string dictAsJson = JsonConvert.SerializeObject(dict);
            var content = new StringContent(dictAsJson.ToString(), Encoding.UTF8, "application/json");
            content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
            HttpResponseMessage response = Utils.Client.PostAsync(url, content).Result;

            if (response.IsSuccessStatusCode)
            {
                var res = response.Content.ReadAsStringAsync().Result;
                int ret = JsonConvert.DeserializeObject<int>(res);
                return ret;
            }
            return 0;
        }


        // To insert record from datatable using url, userid and datatable(parsed from file) through post method
        public string PostExecuteNonQueryResFromWebApi(string path, int userid, DataTable dt)
        {
            var url = string.Format(path);           
            JObject jData = new JObject();
            jData.Add("userid", userid);
            jData.Add("datatable", JsonConvert.SerializeObject(dt));
            var content = new StringContent(jData.ToString(), Encoding.UTF8, "application/json");
            content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
            HttpResponseMessage response = Utils.Client.PostAsync(url, content).Result;

            if (response.IsSuccessStatusCode)
            {
                var res = response.Content.ReadAsStringAsync().Result;
                string ret = JsonConvert.DeserializeObject<string>(res);
                return ret;
            }
            return "Error executing database operation!";
        }     

        /* // For sending datatable only
         public int PostExecuteNonQueryResFromWebApi(string path, DataTable dt)
        {
            var url = string.Format(path);           
            string dtAsJson = JsonConvert.SerializeObject(dt);
            var content = new StringContent(dtAsJson.ToString(), Encoding.UTF8, "application/json");
            content.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            HttpResponseMessage response = Utils.Client.PostAsJsonAsync(url, dt).Result;

            if (response.IsSuccessStatusCode)
            {
                var res = response.Content.ReadAsStringAsync().Result;
                int ret = JsonConvert.DeserializeObject<int>(res);
                return ret;
            }
            return 0;
        }
         */


        public string ApiUrl
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["Api"].ToString();
            }
        }

        public string NewsDirectory
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["NewsDirectory"].ToString();
            }
        }

        public string BlogDirectory
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["BlogDirectory"].ToString();
            }
        }

        public string WebUrl
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["WebURL"].ToString();
            }
        }

        /* SJ added profile configs */
        public string ProfileFromEmailAddress
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ProfileFromEmailAddress"].ToString();
            }
        }
        public string ProfileCCEmailAddress
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ProfileCCEmailAddress"].ToString();
            }
        }
        public string ProfileEmailSubject
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ProfileEmailSubject"].ToString();
            }
        }
        public string ProfileNonExistEmailSubject
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ProfileNonExistEmailSubject"].ToString();
            }
        }


    }
}