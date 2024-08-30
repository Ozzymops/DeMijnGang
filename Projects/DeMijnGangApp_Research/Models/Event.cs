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
        public string _StartDateString { get; set; }

        [XmlElement("endDate")]
        public string _EndDateString { get; set; }

        public DateTime StartDate
        {
            get { return DateTime.Parse(_StartDateString); }
            set { _StartDateString = StartDate.ToString(); }
        }

        public DateTime EndDate
        {
            get { return DateTime.Parse(_EndDateString); }
            set { _EndDateString = EndDate.ToString(); }
        }
    }
}
