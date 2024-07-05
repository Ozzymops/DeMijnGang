using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using AndroidApp_Prototype.Models;

namespace AndroidApp_Prototype.Code
{
    internal class IcalHandler
    {
        private readonly Uri _IcalUri = new Uri("https://demijngang.nl/events.ics");

        public FileStream FetchIcal()
        {
            System.Net.WebClient webClient = new System.Net.WebClient();
            webClient.DownloadFile(_IcalUri, "emCal.ics");
            var Ical = File.Open(AppDomain.CurrentDomain.BaseDirectory + $"\\emCal.ics", FileMode.Open);
            return Ical;
        }

        public List<Event> ParseIcal(FileStream Ical)
        {
            string[] content;
            using (StreamReader reader = new StreamReader(Ical))
            {
                string temp = reader.ReadToEnd();
                content = temp.Split('\n');
            }

            bool parsing = false;
            bool checkNextLine = false;
            string combinedString = null;
            int index = 0;
            List<Event> events = new List<Event>();

            foreach (string line in content)
            {
                if (line.Contains("END:VEVENT"))
                {
                    parsing = false;
                    checkNextLine = false;
                    index++;
                }

                if (parsing)
                {
                    // fix line
                    // TODO: remove additional, unneccessary spaces
                    Regex regex = new Regex("[ ]{2,}", RegexOptions.None);
                    string fixedLine = line.Replace("&amp\\;", "&").ReplaceLineEndings(" ");
                    fixedLine = regex.Replace(fixedLine, " ");

                    // extra code to make it more readable
                    if (checkNextLine)
                    {
                        if (!fixedLine.Contains("DESCRIPTION:") && !fixedLine.Contains("LOCATION:") && !fixedLine.Contains("X-APPLE-STRUCTURED-LOCATION;") && !fixedLine.Contains("ATTACH;") && !fixedLine.Contains("CATEGORIES:"))
                        {
                            combinedString += fixedLine;
                        }
                        else
                        { 
                            if (fixedLine.Contains("LOCATION:") || fixedLine.Contains("ATTACH;")) // previous was DESCRIPTION
                            {
                                events[index].Description = combinedString;
                            }
                            else if (fixedLine.Contains("X-APPLE")) // previous was LOCATION
                            {
                                // TODO
                                events[index].Location = null;
                            }

                            checkNextLine = false;
                        }
                    }
                    
                    if (!checkNextLine)
                    {
                        if (fixedLine.Contains("UID:"))
                        {
                            events[index].Id = Convert.ToInt32(fixedLine.Split(':')[1].Split('@')[0]);
                        }
                        else if (fixedLine.Contains("DTSTART;"))
                        {
                            events[index].StartTime = DateTime.ParseExact(fixedLine.Split(':')[1].Trim(), "yyyyMMdd'T'HHmmss", CultureInfo.InvariantCulture);
                        }
                        else if (fixedLine.Contains("DTEND;"))
                        {
                            events[index].EndTime = DateTime.ParseExact(fixedLine.Split(':')[1].Trim(), "yyyyMMdd'T'HHmmss", CultureInfo.InvariantCulture);
                        }
                        else if (fixedLine.Contains("SUMMARY:"))
                        {
                            events[index].Title = fixedLine.Split(':')[1].Trim();
                        }
                        else if (fixedLine.Contains("DESCRIPTION:") || fixedLine.Contains("LOCATION:"))
                        {
                            checkNextLine = true;
                            combinedString = fixedLine.Split(':')[1];
                        }
                        else if (line.Contains("CATEGORIES:Uitgelicht"))
                        {
                            events[index].Featured = true;
                        }
                    }         
                }

                if (line.Contains("BEGIN:VEVENT"))
                {
                    parsing = true;
                    events.Add(new Event());
                }
            }

            return null;
        }
    }
}
