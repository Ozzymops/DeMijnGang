using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace AndroidApp_Prototype.Models
{
    [XmlRoot("event")]
    public class Event
    {
        [XmlAttribute("id")]
        public int Id { get; set; }

        [XmlElement("title")]
        public string Title { get; set; }

        [XmlElement("categories")]
        public string Categories { get; set; }

        [XmlElement("tags")]
        public string Tags { get; set; }

        [XmlElement("description")]
        public string Description { get; set; }

        [XmlElement("excerpt")]
        public string Excerpt { get; set; }

        [XmlElement("location")]
        public Location Location { get; set; }

        [XmlElement("startDate")]
        public DateTime StartDate { get; set; }

        [XmlElement("endDate")]
        public DateTime EndDate { get;set; }
    }
}
