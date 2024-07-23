using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace DeMijnGangApp.Models
{
    [XmlRoot("event")]
    public class Event
    {
        [XmlAttribute("id")]
        public int Id { get; set; }
        
        [XmlElement("title")]
        public string Title { get; set; }
        
        [XmlElement("description")]
        public string Description { get; set; }
    }
}
