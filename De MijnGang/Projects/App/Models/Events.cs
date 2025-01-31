
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace DeMijnGangApp.Models
{
    [XmlRoot("events")]
    public class Events
    {
        [XmlElement("event")]
        public List<Event> eventList { get; set; }
    }
}
