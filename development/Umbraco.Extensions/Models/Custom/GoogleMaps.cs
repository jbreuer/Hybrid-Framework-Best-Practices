using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Umbraco.Extensions.Models.Custom
{
    public class GoogleMaps
    {
        public string Lat { get; set; }
        public string Lng { get; set; }
        public int Zoom { get; set; }
    }
}