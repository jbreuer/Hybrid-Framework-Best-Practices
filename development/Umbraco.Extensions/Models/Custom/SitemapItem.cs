using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco.Extensions.Models.Custom
{
    public class SitemapItem
    {
        public string Name { get; set; }
        public string Url { get; set; }
        public IEnumerable<SitemapItem> Children { get; set; }
    }
}