using DevTrends.MvcDonutCaching;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using Umbraco.Extensions.Controllers.Base;
using Umbraco.Extensions.Models;
using Umbraco.Extensions.Models.Custom;
using Umbraco.Extensions.Utilities;
using Umbraco.Web;
using Umbraco.Web.Models;

namespace Umbraco.Extensions.Controllers
{
    public class NewsOverviewController : BaseSurfaceController
    {
        //[DonutOutputCache(Duration = 86400, Location = OutputCacheLocation.Server, VaryByCustom = "url;device")]
        public ActionResult NewsOverview()
        {
            var model = GetModel<NewsOverviewModel>();

            var newsItems = GetNewsItems();
            var pager = Umbraco.GetPager(2, newsItems.Count());

            //Only put the paged items in the list.
            model.NewsItems = newsItems.Skip((pager.CurrentPage - 1) * pager.ItemsPerPage).Take(pager.ItemsPerPage);
            model.Pager = pager;

            return CurrentTemplate(model);
        }

        public IEnumerable<NewsItem> GetNewsItems()
        {
            return
            (
                from n in CurrentPage.Children
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
