using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FacebookExtractor.Models
{
    internal class Post
    {
        public string Content { get; set; }
        public DateTime Date { get; set; }
        public List<Uri> Images { get; set; }
    }
}