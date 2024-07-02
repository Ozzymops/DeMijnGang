using AndroidApp_Prototype.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ical.Net;
using Ical.Net.CalendarComponents;

namespace AndroidApp_Prototype.Code
{
    internal class iCalReader
    {
        private readonly Uri _iCalLink = new Uri("https://demijngang.nl/events.ics");

        public void FetchICS()
        {
            System.Net.WebClient _webClient = new System.Net.WebClient();
            _webClient.DownloadFile(_iCalLink, "emCal.ics");
        }

        public List<Event> ParseICS()
        {
            var iCal = File.Open(AppDomain.CurrentDomain.BaseDirectory + $"\\emCal.ics", FileMode.Open);
            Calendar calendar = Calendar.Load(iCal);

            List<Event> events = new List<Event>();

            foreach (CalendarEvent calEvent in calendar.Events)
            {
                // Id = UID in .ics
                Location tempLocation = null;
                bool featured = false;

                if (calEvent.Categories.Contains("Uitgelicht"))
                {
                    featured = true;
                }

                if (calEvent.Location != null)
                {
                    // new location, parse blah blah
                }

                Event tempEvent = new Event(0, calEvent.Summary, [calEvent.DtStart.Value, calEvent.DtEnd.Value], calEvent.DtStart.Value, calEvent.DtEnd.Value, calEvent.Description, calEvent.Description, tempLocation, featured);
                events.Add(tempEvent);
            }

            return events;
        }
    }
}
