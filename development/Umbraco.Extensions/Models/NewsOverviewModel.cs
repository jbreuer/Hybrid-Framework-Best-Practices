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
    public class NewsOverviewModel : BaseModel
    {
        public IEnumerable<NewsItem> NewsItems { get; set; }
        public Pager Pager { get; set; }
    }
}