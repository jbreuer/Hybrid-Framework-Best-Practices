using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco.Extensions.Models.Custom
{
    public class MediaItemCrop : MediaItem
    {
        public string Crop { get; set; }
        public override bool HasValue
        {
            get
            {
                return !string.IsNullOrEmpty(Url) && !string.IsNullOrEmpty(Alt) && !string.IsNullOrEmpty(Crop);
            }
        }
    }
}