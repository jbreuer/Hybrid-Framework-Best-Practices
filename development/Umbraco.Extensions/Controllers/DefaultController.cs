using DevTrends.MvcDonutCaching;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using Umbraco.Extensions.Controllers.Base;
using Umbraco.Extensions.Models;
using Umbraco.Extensions.Utilities;
using Umbraco.Web;
using Umbraco.Web.Models;

namespace Umbraco.Extensions.Controllers
{
    public class DefaultController : BaseSurfaceController
    {
        /// <summary>
        /// If the route hijacking doesn't find a controller this default controller will be used.
        /// That way a each page will always go through a controller and we can always have a BaseModel for the masterpage.
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [DonutOutputCache(Duration = 86400, Location = OutputCacheLocation.Server, VaryByCustom = "url;device")]
        public override ActionResult Index(RenderModel model)
        {
            var baseModel = GetModel<BaseModel>();
            return CurrentTemplate(baseModel);
        }
    }
}
