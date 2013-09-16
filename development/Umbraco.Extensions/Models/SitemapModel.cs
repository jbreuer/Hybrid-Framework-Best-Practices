using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core.Models;
using Umbraco.Extensions.Models.Custom;
using Umbraco.Web.Models;

namespace Umbraco.Extensions.Models
{
    public class SitemapModel : BaseModel
    {
        public IEnumerable<SitemapItem> SitemapItems { get; set; }
    }
}