using DevTrends.MvcDonutCaching;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using Umbraco.Extensions.Controllers.Base;
using Umbraco.Extensions.Enums;
using Umbraco.Extensions.Models;
using Umbraco.Extensions.Models.Custom;
using Umbraco.Extensions.Models.Form;
using Umbraco.Extensions.Utilities;
using Umbraco.Web;
using Umbraco.Web.Models;

namespace Umbraco.Extensions.Controllers
{
    public class ContactController : FormController
    {
        /// <summary>
        /// The Default Controller isn't used because we do have a Contact contoller.
        /// We need to do the same as in that controller for this ActionResult.
        /// </summary>
        /// <returns></returns>
        [DonutOutputCache(Duration = 86400, Location = OutputCacheLocation.Server, VaryByCustom = "url;device")]
        public ActionResult Contact()
        {
            var baseModel = GetModel<BaseModel>();
            return CurrentTemplate(baseModel);
        }

        [ChildActionOnly]
        public ActionResult ShowDates()
        {
            var model = new Date()
            {
                Date1 = DateTime.Now,
                Date2 = DateTime.Now.AddDays(2)
            };

            return PartialView("ShowDates", model);
        }

        [HttpPost]
        public ActionResult SendContact(ContactFormModel model)
        {
            if (!ModelState.IsValid)
            {
                return CurrentUmbracoPage();
            }

            //Set the fields that need to be replaced.
            var formFields = new Dictionary<string, string> 
            {
                {"Name", model.Name},
                {"Email", model.Email},
                {"Comment", model.Comment}
            };

            //Send the e-mail with the filled in form data.
            ProcessForms(formFields, EmailType.Contact, "emailUser", "emailCompany");

            //Redirect to the succes page.
            var child = CurrentPage.Children.FirstOrDefault();
            if (child != null)
            {
                return RedirectToUmbracoPage(child);
            }

            return RedirectToCurrentUmbracoPage();
        }
    }
}
