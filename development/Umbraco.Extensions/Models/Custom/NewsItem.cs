using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco.Extensions.Models.Custom
{
    public class NewsItem
    {
        public string Url { get; set; }
        public string Title { get; set; }
        public MediaItemCrop Image { get; set; }
        public DateTime Date { get; set; }
    }
}