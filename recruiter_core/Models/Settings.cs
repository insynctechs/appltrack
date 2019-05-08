using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;

namespace recruiter_core.Models
{
    public class Settings
    {
        public static string Constr
        {
            get
            {
                return System.Configuration.ConfigurationManager.AppSettings["ConString"].ToString();
            }
        }
    }
}