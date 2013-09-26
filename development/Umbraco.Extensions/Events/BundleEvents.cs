using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

using DevTrends.MvcDonutCaching;
using Umbraco.Core;
using umbraco.cms.businesslogic;
using umbraco.cms.businesslogic.media;
using umbraco.cms.businesslogic.web;
using Umbraco.Extensions.Controllers;
using Umbraco.Extensions.Models;
using Umbraco.Web;
using Umbraco.Web.Mvc;
using Umbraco.Extensions.Utilities;
using umbraco.BusinessLogic;

namespace Umbraco.Extensions.Events
{
    public class BundleEvents : IApplicationEventHandler
    {
        #region Properties

        private UmbracoHelper _umbraco;
        public UmbracoHelper Umbraco
        {
            get
            {
                return _umbraco ?? (_umbraco = new UmbracoHelper(UmbracoContext.Current));
            }
        }

        private Configuration Configuration
        {
            get
            {
                return Configuration.Instance;
            }
        }

        #endregion

        public void OnApplicationInitialized(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
        }

        public void OnApplicationStarting(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
        }

        public void OnApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            RegisterStyles(BundleTable.Bundles);
            RegisterJavascript(BundleTable.Bundles);
        }

        private static void RegisterStyles(BundleCollection bundles)
        {
            //Add all style files. These will be bundled and minified.
            //After everything has been bundled (which only happens when debug=false in the web.config) check if there are no errors in the bundled file. Not all files can be bundled.
            bundles.Add(new StyleBundle("~/bundle/styles.css").Include(
                    "~/css/main.css"
                )
            );
        }

        private static void RegisterJavascript(BundleCollection bundles)
        {
            //Add all javascript files. These will be bundled and minified.
            //After everything has been bundled (which only happens when debug=false in the web.config) check if there are no errors in the bundled file. Not all files can be bundled.
            bundles.Add(new ScriptBundle("~/bundle/javascript.js").Include(
                    "~/umbraco/plugins/TrackMedia/Tracking.js",
                    "~/scripts/jquery.validate.js",
                    "~/scripts/slimmage.js",
                    "~/scripts/functions.js"
                )
            );
        }
    }
}