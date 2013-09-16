using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco.Extensions.Models.Custom
{
    public class WidgetText : WidgetBase
    {
        public string Title { get; set; }
        public HtmlString Text { get; set; }
        public UrlPicker Url { get; set; }
    }
}