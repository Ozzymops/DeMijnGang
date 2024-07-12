using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using AndroidApp_Prototype.Models;

namespace AndroidApp_Prototype.Code
{
    internal class IcalHandler
    {
        private readonly Uri _IcalUri = new Uri("https://demijngang.nl/events.ics");

        public async Task<List<Event>> RetrieveEvents()
        {
            var ical = await new HttpClient().GetStringAsync(_IcalUri);
            string[] icalContent = ical.Split(new string[] { Environment.NewLine }, StringSplitOptions.TrimEntries);


            bool inEvent = false;
            bool multiLine = false;
            string combinedString = null;
            string[] forbiddenMultiLineContent = { "DESCRIPTION:", "ATTACH;", "LOCATION:", "CATEGORIES:" };
            List<Event> events = new List<Event>();
            Event temporaryEvent = null;

            foreach(string icalLine in icalContent)
            {
                if (icalLine.Contains("BEGIN:VEVENT"))
                {
                    inEvent = true;
                    temporaryEvent = new Event();
                }
                else if (icalLine.Contains("END:VEVENT"))
                {
                    inEvent = false;
                    events.Add(temporaryEvent);
                }

                if (inEvent)
                {
                    if (multiLine) // duplicate protection
                    {
                        if (!forbiddenMultiLineContent.Any(icalLine.Contains))
                        {
                            combinedString += icalLine;
                        }
                        else
                        {
                            temporaryEvent.Description = combinedString;
                            multiLine = false;
                        }                        
                    }
                    
                    if (!multiLine) // second check for if disabled previous line
                    {
                        switch (icalLine)
                        {
                            case string line when line.Contains("UID:"):
                                temporaryEvent.Id = Convert.ToInt32(line.Split(':')[1].Split('@')[0]);
                                break;

                            case string line when line.Contains("SUMMARY:"):
                                temporaryEvent.Title = line.Split(':')[1];
                                break;

                            // hardcoded, maybe add more conditions some other time
                            case string line when line.Contains("CATEGORIES:Uitgelicht"):
                                temporaryEvent.Featured = true;
                                break;

                            case string line when line.Contains("DTSTART;"):
                                temporaryEvent.StartTime = DateTime.ParseExact(line.Split(':')[1].Trim(), "yyyyMMdd'T'HHmmss", CultureInfo.InvariantCulture);
                                break;

                            case string line when line.Contains("DTEND;"):
                                temporaryEvent.EndTime = DateTime.ParseExact(line.Split(':')[1].Trim(), "yyyyMMdd'T'HHmmss", CultureInfo.InvariantCulture);
                                break;

                            case string line when line.Contains("DESCRIPTION:"):
                                combinedString = line.Split(':')[1];
                                multiLine = true;
                                break;

                            // TODO: Attachment, Location
                            case null:
                                break;
                        }
                    }                
                }
            }

            return events;
        }
    }
}
