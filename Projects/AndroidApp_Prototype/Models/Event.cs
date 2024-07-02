using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AndroidApp_Prototype.Models
{
    internal class Event
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public bool Featured { get; set; }
        public string Description { get; set; }
        public string Excerpt { get; set; }
        public Location Location { get; set; }
        public DateTime[] DateRange { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }

        /// <summary>
        /// Event datamodel
        /// </summary>
        /// <param name="eventId">Event Manager's Event ID</param>
        /// <param name="eventTitle">Title</param>
        /// <param name="eventDateRange">Single or multiple days during which the event takes place</param>
        /// <param name="eventStartTime">Start time (24h format)</param>
        /// <param name="eventEndTime">Dnd time (24h format)</param>
        /// <param name="eventDescription">Optional description</param>
        /// <param name="eventExcerpt">Optional short description</param>
        /// <param name="eventLocation">Optional location</param>
        /// <param name="eventFeatured">Optional featured status</param>
        public Event(int eventId, string eventTitle, DateTime[] eventDateRange,
                     DateTime eventStartTime, DateTime eventEndTime, string eventDescription = null,
                     string eventExcerpt = null, Location eventLocation = null, bool eventFeatured = false)
        {
            Id = eventId;
            Title = eventTitle;
            DateRange = eventDateRange;
            StartTime = eventStartTime;
            EndTime = eventEndTime;
            Description = eventDescription;
            Excerpt = eventExcerpt;
            Location = eventLocation;
            Featured = eventFeatured;
        }
    }
}
