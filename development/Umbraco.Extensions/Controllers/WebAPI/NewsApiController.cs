using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Umbraco.Extensions.Models.Custom;
using Umbraco.Extensions.Utilities;
using Umbraco.Web;
using Umbraco.Web.WebApi;

namespace Umbraco.Extensions.Controllers.WebAPI
{
    public class NewsApiController : UmbracoApiController
    {
        public IEnumerable<NewsItem> GetAllNews(int newsOverviewId)
        {
            var content = Umbraco.TypedContent(newsOverviewId);

            return
            (
                from n in content.Children
                orderby n.GetPropertyValue<DateTime>("currentDate") descending
                select new NewsItem()
                {
                    Title = n.GetPropertyValue<string>("title"),
                    Url = n.Url(),
                    Image = n.GetCroppedImage("image", 300, 300),
                    Date = n.GetPropertyValue<DateTime>("currentDate")
                }
            );
        }
    }
}
