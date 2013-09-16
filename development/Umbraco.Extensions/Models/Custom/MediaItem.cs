using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco.Extensions.Models.Custom
{
    public class MediaItem
    {
        public string Url { get; set; }
        public string Alt { get; set; }
        public string TrackLabel { get; set; }
        public virtual bool HasValue
        {
            get
            {
                return !string.IsNullOrEmpty(Url) && !string.IsNullOrEmpty(Alt);
            }
        }
    }
}