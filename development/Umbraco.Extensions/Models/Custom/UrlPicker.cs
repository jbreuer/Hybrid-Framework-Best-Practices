using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco.Extensions.Models.Custom
{
    public class UrlPicker
    {
        public string Url { get; set; }
        public string Title { get; set; }
        public bool NewWindow { get; set; }
        public string Target
        {
            get
            {
                return NewWindow ? "_blank" : "_self";
            }
        }
    }
}