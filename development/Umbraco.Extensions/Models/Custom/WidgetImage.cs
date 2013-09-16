using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco.Extensions.Models.Custom
{
    public class WidgetImage : WidgetBase
    {
        public string Title { get; set; }
        public HtmlString Text { get; set; }
        public MediaItemCrop Image { get; set; }
    }
}