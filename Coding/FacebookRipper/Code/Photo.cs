using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FacebookRipper.Code
{
    public class Photo
    {
        public string Id { get; set; }
        public DateTime CreatedTime { get; set; }
        public string Source { get; set; }
        public string GeneratedFilename { get; set; }
    }
}