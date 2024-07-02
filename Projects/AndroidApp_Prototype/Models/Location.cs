using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AndroidApp_Prototype.Models
{
    internal class Location
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Excerpt { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string Country { get; set; }
        public string PostalCode { get; set; }

        /// <summary>
        /// Location datamodel
        /// </summary>
        /// <param name="locId">Event Manager's Location ID</param>
        /// <param name="locName">Name</param>
        /// <param name="locAddress">Address (streetname plus number)</param>
        /// <param name="locCity">Ccity</param>
        /// <param name="locRegion">Region/province</param>
        /// <param name="locCountry">Country</param>
        /// <param name="locPostalCode">Postal code (XXXXYY format)</param>
        /// <param name="locDescription">Optional description</param>
        /// <param name="locExcerpt">Optional short description</param>
        public Location(int locId, string locName, string locAddress, string locCity, string locRegion, string locCountry, string locPostalCode, string locDescription = null, string locExcerpt = null)
        {
            Id = locId;
            Name = locName;
            Description = locDescription;
            Excerpt = locExcerpt;
            Address = locAddress;
            City = locCity;
            Region = locRegion;
            Country = locCountry;
            PostalCode = locPostalCode;
        }
    }
}
