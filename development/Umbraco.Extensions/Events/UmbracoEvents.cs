using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

using DevTrends.MvcDonutCaching;
using Examine;
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
using System.Text;
using System.Globalization;
using System.IO;

namespace Umbraco.Extensions.Events
{
    public class UmbracoEvents : IApplicationEventHandler
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
            Document.New += new Document.NewEventHandler(Document_New);
            Document.AfterPublish += new Document.PublishEventHandler(Document_AfterPublish);
            Document.AfterUnPublish += Document_AfterUnPublish;
            Document.AfterMove += Document_AfterMove;
            Document.AfterMoveToTrash += Document_AfterMoveToTrash;
            Document.AfterDelete += Document_AfterDelete;
            Media.AfterSave += Media_AfterSave;
            ExamineManager.Instance.IndexProviderCollection["ExternalIndexer"].GatheringNodeData += OnGatheringNodeData;

            //By registering this here we can make sure that if route hijacking doesn't find a controller it will use this controller.
            //That way each page will always be routed through one of our controllers.
            DefaultRenderMvcControllerResolver.Current.SetDefaultControllerType(typeof(DefaultController));
        }

        public void OnApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
        }

        protected void Document_New(Document sender, NewEventArgs e)
        {
            if (sender.getProperty("currentDate") != null)
            {
                sender.getProperty("currentDate").Value = DateTime.Now;
            }
        }

        protected void Document_AfterPublish(Document sender, PublishEventArgs e)
        {
            ClearCache();
        }

        protected void Document_AfterUnPublish(Document sender, UnPublishEventArgs e)
        {
            ClearCache();
        }

        protected void Document_AfterMove(object sender, MoveEventArgs e)
        {
            ClearCache();
        }

        protected void Document_AfterMoveToTrash(Document sender, MoveToTrashEventArgs e)
        {
            ClearCache();
        }

        protected void Document_AfterDelete(Document sender, DeleteEventArgs e)
        {
            ClearCache();
        }

        protected void Media_AfterSave(Media sender, SaveEventArgs e)
        {
            ClearCache();
        }

        private void ClearCache()
        {
            try
            {
                //Clear all output cache so everything is refreshed.
                var cacheManager = new OutputCacheManager();
                cacheManager.RemoveItems();
            }
            catch (Exception ex)
            {
                Log.Add(LogTypes.Error, -1, string.Format("Exception: {0} - StackTrace: {1}", ex.Message, ex.StackTrace));
            }
        }

        protected void OnGatheringNodeData(object sender, IndexingNodeDataEventArgs e)
        {
            // Create searchable path
            if (e.Fields.ContainsKey("path"))
            {
                e.Fields["searchPath"] = e.Fields["path"].Replace(',', ' ');
            }

            // Lowercase all the fields for case insensitive searching
            var keys = e.Fields.Keys.ToList();
            foreach (var key in keys)
            {
                e.Fields[key] = HttpUtility.HtmlDecode(e.Fields[key].ToLower(CultureInfo.InvariantCulture));
            }

            // Extract the filename from media items
            if (e.Fields.ContainsKey("umbracoFile"))
            {
                e.Fields["umbracoFileName"] = Path.GetFileName(e.Fields["umbracoFile"]);
            }

            // Stuff all the fields into a single field for easier searching
            var combinedFields = new StringBuilder();
            foreach (var keyValuePair in e.Fields)
            {
                combinedFields.AppendLine(keyValuePair.Value);
            }
            e.Fields.Add("contents", combinedFields.ToString());
        }
    }
}