using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FacebookRipper.Models
{
    public class Photo
    {
        public long Id { get; set; }
        public string Filename { get; set; }
        public DateTime CreatedTime { get; set; }
        public int[] Dimensions { get; set; }
        public string Link { get; set; }

        public Photo (long id, DateTime createdTime, int[] dimensions, string link)
        {
            Id = id;
            CreatedTime = createdTime;
            Dimensions = dimensions;
            Link = link;

            Filename = CreatedTime.ToString("yyyyMMdd") + "_" + Id.ToString();
        }
    }
}