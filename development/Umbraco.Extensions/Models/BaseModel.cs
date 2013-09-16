using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core.Models;
using Umbraco.Extensions.Models.Custom;
using Umbraco.Web;
using Umbraco.Web.Models;

namespace Umbraco.Extensions.Models
{
    public class BaseModel : RenderModel
    {
        public BaseModel() : base(UmbracoContext.Current.PublishedContentRequest.PublishedContent) { }

        public IEnumerable<MenuItem> MenuItems { get; set; }
        public IEnumerable<WidgetBase> Widgets { get; set; }
    }
}