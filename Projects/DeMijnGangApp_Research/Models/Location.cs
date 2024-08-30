using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace AndroidApp_Prototype.Models
{
    [XmlRoot("location")]
    public class Location
    {
        [XmlAttribute("id")]
        public int Id { get; set; }

        [XmlElement("name")]
        public string Name { get; set; }

        [XmlElement("address")]
        public string Address { get; set; }

        [XmlElement("town")]
        public string Town { get; set; }

        [XmlElement("region")]
        public string Region { get; set; }

        [XmlElement("state")]
        public string State { get; set; }

        [XmlElement("postcode")]
        public string Postcode { get; set; }
    }
}
