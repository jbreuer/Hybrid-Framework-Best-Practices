using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco.Extensions.Utilities
{
    public class Global : Umbraco.Web.UmbracoApplication
    {
        public override string GetVaryByCustomString(HttpContext context, string custom)
        {
            if (custom.ToLower() == "url")
            {
                return "url=" + context.Request.Url.AbsoluteUri;
            }

            if (custom.ToLower() == "url;device")
            {
                var mobileDetection = new MobileDetection(System.Web.HttpContext.Current);
                var isSmartphone = mobileDetection.DetectSmartphone();
                return "url=" + context.Request.Url.AbsoluteUri + "&isSmartphone=" + isSmartphone;
            }

            return base.GetVaryByCustomString(context, custom);
        }
    }
}