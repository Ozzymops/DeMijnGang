using AndroidApp_Prototype.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;

namespace AndroidApp_Prototype.Code
{
    internal class XmlParser
    {
        private readonly Uri _uri = new Uri("https://demijngang.nl/appfeed");

        public async Task<List<Event>> Parse()
        {
            XmlSerializer serializer = new XmlSerializer(typeof(Events));
            
            using (XmlTextReader reader = new XmlTextReader(_uri.ToString()))
            {
                Events result = (Events)serializer.Deserialize(reader);
            }
            
            Console.ReadLine();


            //XmlDocument xml = new XmlDocument();
            //string file = await new HttpClient().GetStringAsync(_uri);
            //xml.Load("<xml>"+ file + "</xml>");

            //foreach(XmlNode node in xml.DocumentElement.ChildNodes)
            //{
            //    Console.WriteLine(node.InnerText);
            //}

            return null;
        }
    }
}
